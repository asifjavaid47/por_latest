<?php

class ControllerCustomuserdetailAddressbook extends Controller {

    private $error = array();

    public function index() {
		
        $this->document->setTitle("Addrese book");
        $this->load->language('customuserdetail/addressdetail');
        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/register', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/customuserdetail/addressbook.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/customuserdetail/addressbook.tpl';
        } else {
            $this->template = 'default/template/customuserdetail/addressbook.tpl';
        }

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (null !== $this->customer->isLogged()) {
                $cid = $this->customer->getId();
            }
            $this->load->model('customuserdetail/addressbook');
            $get_customer_id_sees = $this->model_customuserdetail_addressbook->add_new_address($this->request->post, $cid);

            $this->response->redirect($this->url->link('customuserdetail/addressbook', 'param=10', 'SSL'));
        }
        if (isset($this->error['country_id'])) {
            $data['error_userdet_country'] = $this->error['country_id'];
        } else {
            $data['error_userdet_country'] = '';
        }
        if (isset($this->error['zone_id'])) {
            $data['error_userdet_zone'] = $this->error['zone_id'];
        } else {
            $data['error_userdet_zone'] = '';
        }
        if (isset($this->error['new_address'])) {
            $data['error_new_address'] = $this->error['new_address'];
        } else {
            $data['error_new_address'] = '';
        }
        if (isset($this->error['address_doornumber'])) {
            $data['error_door_number'] = $this->error['address_doornumber'];
        } else {
            $data['error_door_number'] = '';
        }
        $data['title'] = $this->document->getTitle();
        $data['base'] = $server;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['action'] = $this->url->link('customuserdetail/addressbook', '', true);
        $data['text_select'] = $this->language->get('text_select');
        $data['text_none'] = $this->language->get('text_none');
        if (isset($this->request->post['country_id'])) {
            $data['country_id'] = (int) $this->request->post['country_id'];
        } elseif (isset($this->session->data['shipping_address']['country_id'])) {
            $data['country_id'] = $this->session->data['shipping_address']['country_id'];
        } else {
            $data['country_id'] = $this->config->get('config_country_id');
        }

        if (isset($this->request->post['zone_id'])) {
            $data['zone_id'] = (int) $this->request->post['zone_id'];
        } elseif (isset($this->session->data['shipping_address']['zone_id'])) {
            $data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
        } else {
            $data['zone_id'] = '';
        }
        if (isset($this->request->post['new_address'])) {
            $data['new_address'] = $this->request->post['new_address'];
        } else {
            $data['new_address'] = '';
        }
        if (isset($this->request->post['address_doornumber'])) {
            $data['address_doornumber'] = $this->request->post['address_doornumber'];
        } else {
            $data['address_doornumber'] = '';
        }
        if (isset($this->request->post['address_floor'])) {
            $data['address_floor'] = $this->request->post['address_floor'];
        } else {
            $data['address_floor'] = '';
        }
        if (isset($this->request->post['address_apartment'])) {
            $data['address_apartment'] = $this->request->post['address_apartment'];
        } else {
            $data['address_apartment'] = '';
        }
        if (isset($this->request->post['postcode'])) {
            $data['postcode'] = $this->request->post['postcode'];
        } else {
            $data['postcode'] = '';
        }
        if (isset($this->request->post['city'])) {
            $data['city'] = $this->request->post['city'];
        } else {
            $data['city'] = '';
        }
        $this->load->model('localisation/country');
        $data['countries'] = $this->model_localisation_country->getCountries();
        $this->load->model('customuserdetail/addressbook');
//        for proviences
         $this->load->model('customuserdetail/userdetail');
        $data['provience'] = $this->model_customuserdetail_userdetail->get_provence();
        if (null !== $this->customer->isLogged()) {
            $cid = $this->customer->getId();
            $get_address = $this->model_customuserdetail_addressbook->get_all_address($cid);
            if ($get_address->num_rows > 0) {
                foreach ($get_address->rows as $key => $val) {
                    $get_province[] = $this->model_customuserdetail_addressbook->get_province($val['province']);
                }
                $data['get_from_province'] = $get_province;
                foreach ($get_address->rows as $key => $val) {
                    $get_city[] = $this->model_customuserdetail_addressbook->get_cty($val['city']);
                }
                $data['get_city'] = $get_city;
            }
            $data['get_from_address'] = $get_address;
        }
        $this->response->setOutput($this->load->view('customuserdetail/addressbook', $data));
    }

	public function remove_addresses()
	{
    	$this->load->model('customuserdetail/addressbook');
        $get_address = $this->model_customuserdetail_addressbook->remove_addresses($this->request->post);
	}
    public function save_use_as()
	{
    	$this->load->model('customuserdetail/addressbook');
        $get_address = $this->model_customuserdetail_addressbook->update_save_as($this->request->post);
    }
	
	
	public function get_current_address_addressbook(){
		$address_id = $this->request->post['id'];
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  id= '".$address_id."'");
		echo json_encode($query->rows);
	}

    public function update_current_address() {
        $this->load->model('customuserdetail/addressbook');
        $get_address = $this->model_customuserdetail_addressbook->update_current_address($this->request->post);
    }

    private function validate() {
        if ((utf8_strlen(trim($this->request->post['new_address'])) < 3) || (utf8_strlen(trim($this->request->post['new_address'])) > 128)) {
            $this->error['new_address'] = $this->language->get('error_new_address');
        }
        if ((utf8_strlen(trim($this->request->post['address_doornumber'])) < 3) || (utf8_strlen(trim($this->request->post['address_doornumber'])) > 128)) {
            $this->error['address_doornumber'] = $this->language->get('error_door_number');
        }
        return !$this->error;
    }
}
?>