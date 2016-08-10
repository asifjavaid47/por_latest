<?php

class ControllerCustomuserdetailUserdetail extends Controller {

    private $error = array();

    public function index() {
        // set title of the page
        $this->document->setTitle("User Detail");

        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');


        $this->load->language('customuserdetail/userdetail');

        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/register/login', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/customuserdetail/userdetail.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/customuserdetail/userdetail.tpl';
        } else {
            $this->template = 'default/template/customuserdetail/userdetail.tpl';
        }

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['title'] = $this->document->getTitle();
        $data['base'] = $server;
        $data['address_labl'] = $this->language->get('address_labl');
        $data['zipcode_labl'] = $this->language->get('zipcode_labl');
        $data['city_labl'] = $this->language->get('city_labl');
        $data['country_labl'] = $this->language->get('country_labl');
        $data['province_labl'] = $this->language->get('province_labl');
        $data['tax_id_labl'] = $this->language->get('tax_id_labl');
        $data['text_select'] = $this->language->get('text_select');
        $data['text_none'] = $this->language->get('text_none');

        $data['user_street_labl'] = $this->language->get('user_street_labl');
        $data['user_number_labl'] = $this->language->get('user_number_labl');
		$data['user_optional_labl'] = $this->language->get('user_optional_labl');
        $data['user_zip_labl'] = $this->language->get('user_zip_labl');
		
        $data['user_country_labl'] = $this->language->get('user_country_labl');
        $data['user_providce_labl'] = $this->language->get('user_providce_labl');
        $data['user_city_labl'] = $this->language->get('user_city_labl');
        $data['user_tax_labl'] = $this->language->get('user_tax_labl');
 
        $data['user_no_number_checkbox'] = $this->language->get('user_no_number_checkbox');
		$data['user_zip_not_know'] = $this->language->get('user_zip_not_know');
		$data['user_madatory_text'] = $this->language->get('user_madatory_text');
		$data['user_detail_heading'] = $this->language->get('user_detail_heading');

        $data['user_left_myaccount'] = $this->language->get('user_left_myaccount');
		$data['user_left_editact'] = $this->language->get('user_left_editact');
		$data['user_lefft_pass'] = $this->language->get('user_lefft_pass');
		$data['user_left_address'] = $this->language->get('user_left_address');
		
		$data['tab_vendorname'] = $this->language->get('tab_vendorname');
		$data['tab_companydetail'] = $this->language->get('tab_companydetail');
		
		$data['btn_nextstep'] = $this->language->get('btn_nextstep');
		$data['link_contlater'] = $this->language->get('link_contlater');
				
		$data['error_userdet_address_1'] = $this->language->get('error_userdet_address_1');
		$data['error_userdet_city'] = $this->language->get('error_userdet_city');
		$data['error_userdet_postcode'] = $this->language->get('error_userdet_postcode');
		$data['error_userdet_doornumber'] = $this->language->get('error_userdet_doornumber');
		$data['error_userdet_country'] = $this->language->get('error_userdet_country');
		$data['error_userdet_taxid'] = $this->language->get('error_userdet_taxid');
		$data['error_userdet_taxid_already_exists'] =  $this->language->get('error_userdet_taxid_already_exists');
		 
		/*vendor start*/

        $data['step_vendor_head_labl'] = $this->language->get('step_vendor_head_labl');
        $data['step_vendor_sub_cation_labl'] = $this->language->get('step_vendor_sub_cation_labl');
		$data['step_vendor_name_ex'] = $this->language->get('step_vendor_name_ex');
		$data['step_vendor_user_reg_txt'] = $this->language->get('step_vendor_user_reg_txt');
		$data['step_vendor_load_info_txt'] = $this->language->get('step_vendor_load_info_txt');
		$data['step_vendor_phonee_ex'] = $this->language->get('step_vendor_phonee_ex');
		$data['step_vendor_email_ex'] = $this->language->get('step_vendor_email_ex');
		$data['step_vendor_address_text_option'] = $this->language->get('step_vendor_address_text_option');
		$data['step_vendor_new_address_text'] = $this->language->get('step_vendor_new_address_text');
		$data['step_vendor_street_ex'] = $this->language->get('step_vendor_street_ex');
		$data['step_vendor_street_ex'] = $this->language->get('step_vendor_street_ex');
		$data['step_vendor_country_ex'] = $this->language->get('step_vendor_country_ex');
		
		$data['step_vendor_province_ex'] = $this->language->get('step_vendor_province_ex');
		$data['step_vendor_cty_ex'] = $this->language->get('step_vendor_cty_ex');
		$data['step_vendor_existing_address_txt'] = $this->language->get('step_vendor_existing_address_txt');
		$data['step_vendor_cust_info_txt'] = $this->language->get('step_vendor_cust_info_txt');
		$data['step_vendor_purchase_txt'] = $this->language->get('step_vendor_purchase_txt');
		$data['step_vendor_purchase_ex_txt'] = $this->language->get('step_vendor_purchase_ex_txt');
		$data['step_vendor_txt_left'] = $this->language->get('step_vendor_txt_left');
		$data['step_vendor_finish_later'] = $this->language->get('step_vendor_finish_later');
		$data['step_vendor_door_num_ex'] = $this->language->get('step_vendor_door_num_ex');
		
		$data['address_labl'] = $this->language->get('address_labl');
		$data['zipcode_labl'] = $this->language->get('zipcode_labl');
		$data['city_labl'] = $this->language->get('city_labl');
		$data['country_labl'] = $this->language->get('country_labl');
		$data['province_labl'] = $this->language->get('province_labl');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		
		$data['error_userdet_name'] = $this->language->get('error_userdet_name');
		$data['error_userdet_phone'] = $this->language->get('error_userdet_phone');
		$data['error_userdet_email'] = $this->language->get('error_userdet_email');
		
		$data['error_userdet_address_1'] = $this->language->get('error_userdet_address_1');
		$data['error_userdet_vendor_doornumber'] = $this->language->get('error_userdet_vendor_doornumber');
		$data['error_userdet_country'] = $this->language->get('error_userdet_country');
		$data['error_userdet_city'] = $this->language->get('error_userdet_city');
	
		/*vendor end*/

        /*company start*/
		
		$data['address_labl'] =  $this->language->get('address_labl');
		$data['zipcode_labl'] =  $this->language->get('zipcode_labl');
		$data['city_labl'] =  $this->language->get('city_labl');
		$data['country_labl'] =  $this->language->get('country_labl');
		$data['province_labl'] =  $this->language->get('province_labl');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
	
		$data['company_name_labl'] =  $this->language->get('company_name_labl');
		$data['company_address_labl'] =  $this->language->get('company_address_labl');
		$data['company_logo_labl'] =  $this->language->get('company_logo_labl');
		$data['company_banner_labl'] =  $this->language->get('company_banner_labl');
	
        $data['error_userdet_companyname'] =  $this->language->get('company_banner_labl');
		
		$data['error_userdet_address_1'] =  $this->language->get('error_userdet_address_1');
		$data['error_userdet_company_doornumber'] =  $this->language->get('error_userdet_company_doornumber');
		$data['error_userdet_country'] =  $this->language->get('error_userdet_country');
		$data['error_userdet_city'] =  $this->language->get('error_userdet_city');
		$data['error_userdet_companyname'] =  $this->language->get('company_banner_labl');
		$data['error_userdet_companyname'] =  $this->language->get('company_banner_labl');
		$data['error_userdet_companyname'] =  $this->language->get('company_banner_labl');
		$data['error_userdet_companyname'] =  $this->language->get('company_banner_labl');
		$data['step_company_head_labl'] = $this->language->get('step_company_head_labl');
		$data['step_company_sub_caption'] = $this->language->get('step_company_sub_caption');
		$data['step_company_co_name_ex'] = $this->language->get('step_company_co_name_ex');
		$data['step_company_cont_add_txt'] = $this->language->get('step_company_cont_add_txt');
		$data['step_company_new_add_txt'] = $this->language->get('step_company_new_add_txt');
		$data['step_company_street_ex'] = $this->language->get('step_company_street_ex');
		$data['step_company_exis_add'] = $this->language->get('step_company_exis_add');
		
		$data['step_company_logo'] = $this->language->get('step_company_logo');
		$data['step_company_logo_size'] = $this->language->get('step_company_logo_size');
		$data['step_company_banner'] = $this->language->get('step_company_banner');
		$data['step_company_banner_size'] = $this->language->get('step_company_banner_size');
		$data['step_finish_txt'] = $this->language->get('step_finish_txt');
		/*company end*/
			if (isset($this->request->post['country_id'])) {
				$data['country_id'] = (int) $this->request->post['country_id'];
			} elseif (isset($this->session->data['shipping_address']['country_id'])) {
				$data['country_id'] = $this->session->data['shipping_address']['country_id'];
			} else {
				$data['country_id'] = $this->config->get('config_country_id');
			}
	
			$this->load->model('localisation/country');
			$data['countries'] = $this->model_localisation_country->getCountries();
			
			$this->load->model('customuserdetail/userdetail');
			$data['provience'] = $this->model_customuserdetail_userdetail->get_provence();

        $data['action'] = $this->url->link('customuserdetail/userdetail', '', true);
        $data['my_custom_text'] = "This is custom user detail.";
 
        $this->response->setOutput($this->load->view('customuserdetail/userdetail', $data));
    }
	
	public function user_detail(){
		        $this->load->model('customuserdetail/userdetail');

				if (null !== $this->customer->isLogged()) {
					$cid = $this->customer->getId();
				}
				$data['get_customer_id'] = $cid;
				$get_customer_id_sees = $this->model_customuserdetail_userdetail->add_data_address_table($data['get_customer_id'], $this->request->post);
	}
	
	public function get_user_address_in_vendor(){
		$this->load->model('customuserdetail/vendordetail');
        if (null !== $this->customer->isLogged()) {
            $cid = $this->customer->getId();
            $get_customer_id_sees = $this->model_customuserdetail_vendordetail->get_address($cid);
			
			$get_province = $this->model_customuserdetail_vendordetail->get_province($get_customer_id_sees->row['zone_id']);
			$get_city = $this->model_customuserdetail_vendordetail->get_citys($get_customer_id_sees->row['city']);
            $get_country = $this->model_customuserdetail_vendordetail->get_country($get_customer_id_sees->row['country_id']);
            $door_number = isset($get_customer_id_sees->row['door_number']) ? $get_customer_id_sees->row['door_number'] : '';
            $floor = isset($get_customer_id_sees->row['floor']) ? $get_customer_id_sees->row['floor'] : '';
            $apartment = isset($get_customer_id_sees->row['apartment']) ? $get_customer_id_sees->row['apartment'] : '';
            $city = isset($get_city->row['localidad']) ? $get_city->row['localidad'] : '';
            $provinces = isset($get_province->row['provincia']) ? $get_province->row['provincia'] : '';
            $countrys = isset($get_country->row['name']) ? $get_country->row['name'] : '';

            $data['get_address'] = $get_customer_id_sees->row['address_1'] . " " . $door_number . "," . " " . "floor " . $floor . $apartment . "," . " " . $city . ", " . $provinces . ", " . $countrys;
            echo $data['get_address'];
        }
    }
	public function get_user_vendor_address_in_company(){
		
			    $this->load->model('customuserdetail/companydetail');
		$this->load->model('customuserdetail/userdetail');
        $data['provience'] = $this->model_customuserdetail_userdetail->get_provence();

	if (null !==  $this->customer->isLogged()) { 
				 $cid = $this->customer->getId();
					$get_customer_id_sees = $this->model_customuserdetail_companydetail->get_address($cid);
					$get_province = $this->model_customuserdetail_companydetail->get_province($get_customer_id_sees->row['zone_id']);
					$get_city = $this->model_customuserdetail_companydetail->get_citys1($get_customer_id_sees->row['city']);
					
					$get_country = $this->model_customuserdetail_companydetail->get_country($get_customer_id_sees->row['country_id']);
					$get_customer_vendor_address = $this->model_customuserdetail_companydetail->get_new_address_vendor($cid);
					$get_new_province = $this->model_customuserdetail_companydetail->get_new_province($get_customer_vendor_address->row['province']);
					$get_new_city = $this->model_customuserdetail_companydetail->get_new_city($get_customer_vendor_address->row['city']);
					$get_new_country = $this->model_customuserdetail_companydetail->get_new_country($get_customer_vendor_address->row['country']);
					if($get_customer_vendor_address->num_rows > 0){
						$data['vendor_new_address'] = $get_customer_vendor_address;
						$data['get_new_province'] = $get_new_province;
						$data['get_new_city'] = $get_new_city;
						$data['get_new_country'] = $get_new_country;
					}
						
        $data['get_address'] = $get_customer_id_sees;
		$data['get_province'] = $get_province;
		$data['get_city'] = $get_city;
		$data['get_country'] = $get_country;
	  }
		   $address = isset($get_customer_id_sees->row['address_1'])?$get_customer_id_sees->row['address_1']:'';
		   $door_number = isset($get_customer_id_sees->row['door_number'])?$get_customer_id_sees->row['door_number']:'';               

              if(!empty($get_customer_id_sees->row['floor'])){
                 $floor = ', floor '.$get_customer_id_sees->row['floor']." ";
              }else{
                 $floor = '';
              }
               
               $apartment = isset($get_customer_id_sees->row['apartment'])?$get_customer_id_sees->row['apartment']:'';
               
               
               $city = isset($get_city->row['localidad'])?$get_city->row['localidad']:'';
               
               $province = isset($get_province->row['provincia'])?$get_province->row['provincia']:'';
               $countrys = isset($get_country->row['name'])?$get_country->row['name']:'';
          
               $new_address = isset($get_customer_vendor_address->row['new_address'])?$get_customer_vendor_address->row['new_address']:$get_customer_vendor_address->row['v_address'];
               
               $new_door_number = isset($get_customer_vendor_address->row['vendor_door_number'])?$get_customer_vendor_address->row['vendor_door_number']:'';
                              
              if(!empty($get_customer_vendor_address->row['floor'])){
                 $new_floor = ', floor '.$get_customer_vendor_address->row['floor']." ";
              }else{
                 $new_floor = '';
              }

               
               $new_apartment = isset($get_customer_vendor_address->row['vendor_apartment'])?$get_customer_vendor_address->row['vendor_apartment']:'';
               $new_city = isset($get_new_city->row['localidad'])?$get_new_city->row['localidad']:'';
               
               $new_province = isset($get_new_province->row['provincia'])?$get_new_province->row['provincia']:'';
               $new_country = isset($get_new_country->row['name'])?$get_new_country->row['name']:'';
               
               if(isset($get_customer_vendor_address->row['new_address'])){
                    $complete_address_n =  $new_address." ". $new_door_number." ".$new_floor .$new_apartment.","." ".$new_city.", ".$new_province.", ".$new_country;
               }
			   $complete_address_v =  $get_customer_vendor_address->row['v_address'];
			   $addsr = $address." ". $door_number." ".$floor .$apartment.","." ".$city.", ".$province.", ".$countrys;
				
				if($get_customer_vendor_address->row['zip_code'] !=''){
				      $complete_address =  $complete_address_n;
				}else{
					 $complete_address = $complete_address_v;
				}
				$oneaddress =  isset ($complete_address)?$complete_address:''; 
			     echo  json_encode(array('0'=>$addsr , '1'=>$oneaddress));
	}
	
	public function vendordetail(){
		
		    if (null !== $this->customer->isLogged()) {
                $cid = $this->customer->getId();
	        }

            $this->load->model('customuserdetail/vendordetail');
            $get_customer_id_sees = $this->model_customuserdetail_vendordetail->add_vendor_detail($cid, $this->request->post);
    }
	public function companydetail(){
			if (null !== $this->customer->isLogged()) { 
				 $cid = $this->customer->getId();
			}
			$this->load->model('customuserdetail/companydetail');
			$get_customer_id_sees = $this->model_customuserdetail_companydetail->add_compant_detail($cid , $this->request->post , $this->request->post['company_banner'] ,$this->request->post['company_logo'] );
	}
    public function check_taxid(){
		
		$this->load->language('customuserdetail/userdetail');
		
		$cuits = $this->request->post['tax_id'];
        $status = $this->validatecuit(str_replace("-", "", $cuits));

        if ($status == 0) {
			echo 'not valid';
        } else if ($status == 1) {
            $this->load->model('customuserdetail/editaccount');
            $record_for_tax_id = $this->model_customuserdetail_editaccount->check_taxid_for_uniqueness($cuits);
			if ($record_for_tax_id->rows[0]['number_of_tax_ids'] > 0) {
				echo 'already exists';
			}
        }
	}
    public function cities_lc() {
        $json = array();

        $this->load->model('customuserdetail/userdetail');

        $country_info = $this->model_customuserdetail_userdetail->getcities($this->request->post['city_id']);
        $a = $country_info;
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($a));
    }
    function validatecuit($cuit) {

        if (!is_numeric($cuit)) {
            return 0;
        }

        if (strlen($cuit) != 11) {
            return 0;
        }

        $prefijo = (int) substr($cuit, 0, 2);
        if (!in_array($prefijo, array(20, 23, 24, 27, 30, 33, 34))) {
            return 0;
        }
        $cadena = str_split($cuit);

        $result = $cadena[0] * 5;
        $result += $cadena[1] * 4;
        $result += $cadena[2] * 3;
        $result += $cadena[3] * 2;
        $result += $cadena[4] * 7;
        $result += $cadena[5] * 6;
        $result += $cadena[6] * 5;
        $result += $cadena[7] * 4;
        $result += $cadena[8] * 3;
        $result += $cadena[9] * 2;

        $div = intval($result / 11);
        $resto = $result - ($div * 11);

        if ($resto == 0) {
            if ($resto == $cadena[10]) {
                return 1;
            } else {
                return 0;
            }
        } elseif ($resto == 1) {
            if ($cadena[10] == 9 AND $cadena[0] == 2 AND $cadena[1] == 3) {
                return 1;
            } elseif ($cadena[10] == 4 AND $cadena[0] == 2 AND $cadena[1] == 3) {
                return 1;
            }
        } elseif ($cadena[10] == (11 - $resto)) {
            return 1;
        } else {
            return 0;
        }
    }

    private function validate() {

        if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128)) {
            $this->error['address_1'] = $this->language->get('error_userdet_address_1');
        }

        if ((utf8_strlen(trim($this->request->post['city'])) < 1) || (utf8_strlen(trim($this->request->post['city'])) > 128)) {
            $this->error['city'] = $this->language->get('error_userdet_city');
        }

        $this->load->model('localisation/country');
        $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

        if ((utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
            $this->error['postcode'] = $this->language->get('error_userdet_postcode');
        }



        if ((utf8_strlen(trim($this->request->post['doornumber'])) < 1 || utf8_strlen(trim($this->request->post['doornumber'])) > 10)) {
            $this->error['doornumber'] = $this->language->get('error_userdet_doornumber');
        }


        if ($this->request->post['country_id'] == '') {
            $this->error['country'] = $this->language->get('error_userdet_country');
        }
        if ((utf8_strlen(trim($this->request->post['tax_id'])) < 3) || (utf8_strlen(trim($this->request->post['tax_id'])) > 15)) {
            $this->error['tax_id'] = $this->language->get('error_userdet_taxid');
        }

        $cuits = $this->request->post['tax_id'];
        $status = $this->validatecuit(str_replace("-", "", $cuits));

        if ($status == 0) {
           echo  $this->error['tax_id'] = $this->language->get('Invalid Tax ID');
        } else if ($status == 1) {
            $this->load->model('customuserdetail/editaccount');
            $record_for_tax_id = $this->model_customuserdetail_editaccount->check_taxid_for_uniqueness($cuits);

            if ($record_for_tax_id->rows[0]['number_of_tax_ids'] > 0) {
                echo $this->error['tax_id'] = $this->language->get('This Tax ID already exist. Use an other one.');
            }
        }
        return !$this->error;
    }

}

?>