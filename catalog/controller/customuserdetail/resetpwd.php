<?php

class ControllerCustomuserdetailResetpwd extends Controller {

    private $error = array();

    public function index() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('customuserdetail/resetpwd', '', true);

            $this->response->redirect($this->url->link('account/register', '', true));
        }

        $this->load->language('customuserdetail/resetpwd');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->load->model('customuserdetail/customer');

            $this->model_customuserdetail_customer->editPassword($this->customer->getEmail(), $this->request->post['password']);

            $this->session->data['success'] = $this->language->get('text_success');

            // Add to activity log
            $this->load->model('customuserdetail/activity');

            $activity_data = array(
                'customer_id' => $this->customer->getId(),
                'name' => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
            );

            $this->model_customuserdetail_activity->addActivity('password', $activity_data);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('customuserdetail/editaccount', '', true));
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('account/register', '', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('customuserdetail/resetpwd', '', true)
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_password'] = $this->language->get('text_password');
        $data['old_password'] = $this->language->get('text_old_password');

        $data['entry_password'] = $this->language->get('entry_password');
        $data['entry_confirm'] = $this->language->get('entry_confirm');

        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');
		
		$data['old_lang_password'] = $this->language->get('old_password');
		$data['text_password'] = $this->language->get('text_password');
		$data['heading_title'] = $this->language->get('heading_title');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['entry_confirm'] = $this->language->get('entry_confirm');

        if (isset($this->error['old_password'])) {
            $data['error_old_password'] = $this->error['old_password'];
        } else {
            $data['error_old_password'] = '';
        }
        if (isset($this->error['old_password'])) {
            $data['error_empty_password'] = $this->error['old_password'];
        } else {
            $data['error_empty_password'] = '';
        }
        if (isset($this->error['password'])) {
            $data['error_password'] = $this->error['password'];
        } else {
            $data['error_password'] = '';
        }

        if (isset($this->error['confirm'])) {
            $data['error_confirm'] = $this->error['confirm'];
        } else {
            $data['error_confirm'] = '';
        }

        $data['action'] = $this->url->link('customuserdetail/resetpwd', '', true);

        if (isset($this->request->post['password'])) {
            $data['password'] = $this->request->post['password'];
        } else {
            $data['password'] = '';
        }

        if (isset($this->request->post['confirm'])) {
            $data['confirm'] = $this->request->post['confirm'];
        } else {
            $data['confirm'] = '';
        }

        $data['back'] = $this->url->link('customuserdetail/editaccount', '', true);

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('customuserdetail/resetpwd', $data));
	}

    public function login_login() {
        $email = $this->customer->getEmail();
        $json = array();
        $this->load->language('customuserdetail/quicksignup');
        $this->load->model('account/customer');
        if (isset($this->request->post)) {
            if (!$this->customer->login($email, $this->request->post['old_password'])) {
                $json['error'] = $this->language->get('error_login');
            }
            $customer_info = $this->model_account_customer->getCustomerByEmail($email);
            if ($customer_info && !$customer_info['approved']) {
                $json['error'] = $this->language->get('error_approved');
            }
        } else {
            $json['error'] = $this->language->get('error_warning');
        }

        if (!$json) {
            $json['success'] = true;
            unset($this->session->data['guest']);

            // Default Shipping Address
            $this->load->model('account/address');

            if ($this->config->get('config_tax_customer') == 'payment') {
                $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
            }

            if ($this->config->get('config_tax_customer') == 'shipping') {
                $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
            }

            // Add to activity log
            $this->load->model('account/activity');

            $activity_data = array(
                'customer_id' => $this->customer->getId(),
                'name' => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
            );

            $this->model_account_activity->addActivity('login', $activity_data);
        }

        return $json;
    }

    protected function validate() {

        if ($this->request->post['old_password']) {
            $data = $this->login_login();
            if (isset($data['success'])) {
            } else {
                $this->error['old_password'] = $this->language->get('error_old_password');
            }
        }
        if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
            $this->error['password'] = $this->language->get('error_password');
        }

        if ($this->request->post['confirm'] != $this->request->post['password']) {
            $this->error['confirm'] = $this->language->get('error_confirm');
        }

        return !$this->error;
    }
}
?>