<?php
class ControllerAccountRegister extends Controller {

    private $error = array();

    public function index() {

        if ($this->customer->isLogged()) {
            $this->response->redirect($this->url->link('customuserdetail/editaccount', '', true));
        }

        $this->load->language('account/register');

        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
        $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

        $this->load->model('account/customer');


        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $customer_id = $this->model_account_customer->addCustomer($this->request->post);
			$save_contact_info = $this->model_account_customer->save_contact_information_vendor($this->request->post , $customer_id);
			
            // Clear any previous login attempts for unregistered accounts.
            $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
            $this->customer->login($this->request->post['email'], $this->request->post['password']);

            unset($this->session->data['guest']);

          // Add to activity log
            $this->load->model('account/activity');

            $activity_data = array(
                'customer_id' => $customer_id,
                'name' => $this->request->post['firstname'] . ' ' . $this->request->post['lastname']
            );

            $this->model_account_activity->addActivity('register', $activity_data);
            $this->response->redirect($this->url->link('customuserdetail/userdetail'));
        }



        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('account/account', '', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_register'),
            'href' => $this->url->link('account/register', '', true)
        );

        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('account/login', '', true));
        $data['text_your_details'] = $this->language->get('text_your_details');
        $data['text_your_address'] = $this->language->get('text_your_address');
        $data['text_your_password'] = $this->language->get('text_your_password');
        $data['text_newsletter'] = $this->language->get('text_newsletter');
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');
        $data['text_select'] = $this->language->get('text_select');
        $data['text_none'] = $this->language->get('text_none');
        $data['text_loading'] = $this->language->get('text_loading');
        $data['entry_customer_group'] = $this->language->get('entry_customer_group');
        $data['entry_firstname'] = $this->language->get('entry_firstname');
        $data['entry_lastname'] = $this->language->get('entry_lastname');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_telephone'] = $this->language->get('entry_telephone');
        $data['entry_fax'] = $this->language->get('entry_fax');
        $data['entry_company'] = $this->language->get('entry_company');
        $data['entry_address_1'] = $this->language->get('entry_address_1');
        $data['entry_address_2'] = $this->language->get('entry_address_2');
        $data['entry_postcode'] = $this->language->get('entry_postcode');
        $data['entry_city'] = $this->language->get('entry_city');
        $data['entry_country'] = $this->language->get('entry_country');
        $data['entry_zone'] = $this->language->get('entry_zone');
        $data['entry_newsletter'] = $this->language->get('entry_newsletter');
        $data['entry_password'] = $this->language->get('entry_password');
        $data['entry_confirm'] = $this->language->get('entry_confirm');
        $data['button_continue'] = $this->language->get('button_continue');
		
        $data['button_upload'] = $this->language->get('button_upload');
        $data['text_success'] = $this->language->get('button_upload');
        $data['quick_registration'] = $this->language->get('quick_registration');
        $data['forget_password'] = $this->language->get('forget_password');
		
		$data['ex_name'] = $this->language->get('ex_name');
		$data['ex_surename'] = $this->language->get('ex_surename');
		$data['ex_email'] = $this->language->get('ex_email');
		$data['ex_r_email'] = $this->language->get('ex_r_email');
		$data['ex_phone'] = $this->language->get('ex_phone');
		$data['ex_pass'] = $this->language->get('ex_pass');
		

		
//        New Variables for template
//        Added by Hadi Syed  


        $data['name']         = $this->language->get('name');
        $data['surname']      = $this->language->get('surname');
        $data['repeat_email'] = $this->language->get('repeat_email');
        $data['phone_number'] = $this->language->get('phone_number');
       // $data['registered_customers']     = $this->language->get('registered_customers');
        //$data['if_you_have_an_account_with_us']     = $this->language->get('if_you_have_an_account_with_us');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['firstname'])) {
            $data['error_firstname'] = $this->error['firstname'];
        } else {
            $data['error_firstname'] = '';
        }

        if (isset($this->error['lastname'])) {
            $data['error_lastname'] = $this->error['lastname'];
        } else {
            $data['error_lastname'] = '';
        }

        if (isset($this->error['email'])) {
            $data['error_email'] = $this->error['email'];
        } else {
            $data['error_email'] = '';
        }


        if (isset($this->error['repeatemail'])) {
            $data['error_email_confirm'] = $this->error['repeatemail'];
        } else {
            $data['error_email_confirm'] = '';
        }

        if (isset($this->error['fax'])) {
            $data['error_fax_phones'] = $this->error['fax'];
        } else {
            $data['error_fax_phones'] = '';
        }

        if (isset($this->error['custom_field'])) {
            $data['error_custom_field'] = $this->error['custom_field'];
        } else {
            $data['error_custom_field'] = array();
        }

        if (isset($this->error['password'])) {
            $data['error_password'] = $this->error['password'];
        } else {
            $data['error_password'] = '';
        }

        $data['action'] = $this->url->link('account/register', '', true);

        $data['customer_groups'] = array();

        if (is_array($this->config->get('config_customer_group_display'))) {

            $this->load->model('account/customer_group');
            $customer_groups = $this->model_account_customer_group->getCustomerGroups();


            foreach ($customer_groups as $customer_group) {

                if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
                    $data['customer_groups'][] = $customer_group;
                }
            }

        }



        if (isset($this->request->post['customer_group_id'])) {
            $data['customer_group_id'] = $this->request->post['customer_group_id'];
        } else {
            $data['customer_group_id'] = $this->config->get('config_customer_group_id');
        }

        if (isset($this->request->post['firstname'])) {
            $data['firstname'] = $this->request->post['firstname'];
        } else {
            $data['firstname'] = '';
        }

        if (isset($this->request->post['lastname'])) {
            $data['lastname'] = $this->request->post['lastname'];
        } else {
            $data['lastname'] = '';
        }

        if (isset($this->request->post['email'])) {
            $data['email'] = $this->request->post['email'];
        } else {
            $data['email'] = '';
        }


        if (isset($this->request->post['repeatemail'])) {
            $data['repeatemail'] = $this->request->post['repeatemail'];
        } else {
            $data['repeatemail'] = '';
        }

        if (isset($this->request->post['fax'])) {
            $data['fax'] = $this->request->post['fax'];
        } else {
            $data['fax'] = '';
        }

        $this->load->model('localisation/country');
        $data['countries'] = $this->model_localisation_country->getCountries();

        // Custom Fields
        $this->load->model('account/custom_field');
        $data['custom_fields'] = $this->model_account_custom_field->getCustomFields();

        if (isset($this->request->post['custom_field'])) {

            if (isset($this->request->post['custom_field']['account'])) {
                $account_custom_field = $this->request->post['custom_field']['account'];
            } else {
                $account_custom_field = array();
            }

            if (isset($this->request->post['custom_field']['address'])) {
                $address_custom_field = $this->request->post['custom_field']['address'];
            } else {
                $address_custom_field = array();
            }

            $data['register_custom_field'] = $account_custom_field + $address_custom_field;
        } else {
            $data['register_custom_field'] = array();
        }

        if (isset($this->request->post['password'])) {
            $data['password'] = $this->request->post['password'];
        } else {
            $data['password'] = '';
        }

        // Captcha
        if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array) $this->config->get('config_captcha_page'))) {
            $data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'), $this->error);
        } else {
            $data['captcha'] = '';
        }

        if ($this->config->get('config_account_id')) {

            $this->load->model('catalog/information');
            $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

            if ($information_info) {
                $data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_account_id'), true), $information_info['title'], $information_info['title']);
            } else {
                $data['text_agree'] = '';
            }
        } else {
            $data['text_agree'] = '';
        }

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        //$data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $data['text_loading'] = $this->language->get('text_loading');
        $data['button_login'] = $this->language->get('button_login');
        //$data['button_continue'] = $this->language->get('button_continue');
        ///data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
        $this->response->setOutput($this->load->view('account/register', $data));

    }

    public function login(){

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;

		$this->load->language('account/register');
		
		
		if ($this->customer->isLogged()) {
            $this->response->redirect($this->url->link('customuserdetail/editaccount', '', true));
        }

		
        $data['registered_customers']     = $this->language->get('registered_customers');
		$data['if_you_have_an_account_with_us']     = $this->language->get('if_you_have_an_account_with_us');	
		$data['entry_email'] = $this->language->get('entry_email');
        $data['entry_password'] = $this->language->get('entry_password');
		$data['text_loading'] = $this->language->get('text_loading');
        $data['button_login'] = $this->language->get('button_login');
		$data['forget_password'] = $this->language->get('forget_password');

	
		$data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        //$data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/custom_login', $data));
	}

    public function login_login() {

        $json = array();
        //$this->language->load('customuserdetail/quicksignup');
        $this->load->language('customuserdetail/quicksignup');
        $this->load->model('account/customer');
        if ($this->customer->isLogged()) {
            $json['islogged'] = true;
        } else if (isset($this->request->post)) {
            if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
                $json['error'] = $this->language->get('error_login');
            }
            $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
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
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function validate_phone_number($phone) {

        if (preg_match('/^[0-9+-. \s]+$/', $phone)) {
            return 1;
        } else {
            return 0;
        }
    }



    private function validate() {

        if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
            $this->error['firstname'] = $this->language->get('error_firstname');
        }



        if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
            $this->error['lastname'] = $this->language->get('error_lastname');
        }

        if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
            $this->error['email'] = $this->language->get('error_email');
        }

        if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
            $this->error['warning'] = $this->language->get('error_exists');
        }


        if ($this->request->post['repeatemail'] != $this->request->post['email']) {
            $this->error['repeatemail'] = $this->language->get('error_email_confirm');
        }

        if ((utf8_strlen(trim($this->request->post['fax'])) < 1) || (utf8_strlen(trim($this->request->post['fax'])) > 32)) {
            $this->error['fax'] = $this->language->get('error_fax_phones');
        }

        $phonenum = $this->validate_phone_number($this->request->post['fax']);
        //echo $phonenum;
        if ($phonenum == 0) {
            $this->error['fax'] = $this->language->get('error_fax_phones');
        }

        // Customer Group

        if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
            $customer_group_id = $this->request->post['customer_group_id'];
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        // Custom field validation
        $this->load->model('account/custom_field');


        $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);


		//This code in not in use, it was default of open cart
        foreach ($custom_fields as $custom_field)
		{
            if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']]))
			{
                $this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
            } elseif (($custom_field['type'] == 'text' && !empty($custom_field['validation'])) && !filter_var($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']], FILTER_VALIDATE_REGEXP, array('options' => array('regexp' => $custom_field['validation']))))
			{
                $this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field_validate'), $custom_field['name']);
            }
        }
		//Un-used code ends here

        if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20))
		{
            $this->error['password'] = $this->language->get('error_password');
        }


        // Captcha

        if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array) $this->config->get('config_captcha_page'))) {

            $captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');



            if ($captcha) {

                $this->error['captcha'] = $captcha;

            }

        }



        // Agree to terms

        if ($this->config->get('config_account_id')) {

            $this->load->model('catalog/information');



            $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));



            /* if ($information_info && !isset($this->request->post['agree'])) {

              $this->error['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);

              } */

        }



        return !$this->error;

    }



    public function customfield() {

        $json = array();



        $this->load->model('account/custom_field');



        // Customer Group

        if (isset($this->request->get['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->get['customer_group_id'], $this->config->get('config_customer_group_display'))) {

            $customer_group_id = $this->request->get['customer_group_id'];

        } else {

            $customer_group_id = $this->config->get('config_customer_group_id');

        }



        $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);



        foreach ($custom_fields as $custom_field) {

            $json[] = array(

                'custom_field_id' => $custom_field['custom_field_id'],

                'required' => $custom_field['required']

            );

        }



        $this->response->addHeader('Content-Type: application/json');

        $this->response->setOutput(json_encode($json));

    }



}

