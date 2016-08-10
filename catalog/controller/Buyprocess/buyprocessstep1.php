<?php  
class   ControllerBuyprocessbuyprocessstep1 extends Controller {
  
    public function index() {
        $this->load->model('buyprocess/buyprocess');
        $this->load->model('catalog/category');
        
        $this->document->setTitle("Buying Process");
          $this->load->language('customuserdetail/userdetail');
        
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;
        
        /*****Login Check-aa****/
        if($this->customer->isLogged()) {
            $cust_id = $this->customer->isLogged();
            $data['cust_id'] = $cust_id;
           
			$this->load->model('customuserdetail/vendordetail');
			$this->load->model('createlisting/category');
            
			$cid = $this->customer->getId();
            $get_customer_id_sees = $this->model_createlisting_category->getAllAddress($cid);
            
			$store_address =  array();
			if(!empty($get_customer_id_sees))
			{
				foreach($get_customer_id_sees as $custaddr)
				{
					$get_province = $this->model_customuserdetail_vendordetail->get_province($custaddr['province']);
					$get_city = $this->model_customuserdetail_vendordetail->get_citys($custaddr['city']);
					$get_country = $this->model_customuserdetail_vendordetail->get_country($custaddr['country']);

					$address = !empty($custaddr['new_address'])?$custaddr['new_address']:$custaddr['address'];
					$door_number = !empty($custaddr['door_number']) ?$custaddr['door_number'] : '';
					$floor = !empty($custaddr['floor']) ? ", floor " .$custaddr['floor'] : '';
					$apartment = !empty($custaddr['apartment']) ? $custaddr['apartment'] : '';
					$city = !empty($get_city->row['localidad']) ? $get_city->row['localidad'] : '';
					$provinces = !empty($get_province->row['provincia']) ? $get_province->row['provincia'] : '';
					$countrys = !empty($get_country->row['name']) ? $get_country->row['name'] : '';
					$complete_addre = $address . " " . $door_number. $floor . $apartment . "," . " " . $city . ", " . $provinces . ", " . $countrys;
					$store_address[$custaddr['id']] = $complete_addre;
				}
				$data['get_address'] = $store_address;
			}
			else
			{
				$data['get_address'] = '';
			}
		   
		   
            $addresses = $this->model_buyprocess_buyprocess->getCustomerAddresses($cust_id);
           
            $data['address_info'] = array();
            $data['country_name'] = array();
            foreach($addresses as $address_rec){
                $data['address_info'][] = array(
                    'address_id' => $address_rec['id'],
                    'address' => $address_rec['address'],
                    'new_address' => $address_rec['new_address'],
                    'door_number' => $address_rec['door_number'],
                    'floor' => $address_rec['floor'],
                    'apartment' => $address_rec['apartment'],
                    'postcode' => $address_rec['postcode'],
                    'city' => $address_rec['city'],
                    'country' => $address_rec['country'],
                    'province' => $address_rec['province'],
                    'use_as' => $address_rec['use_as'],
                );
            }

            //$data['counrty_name'] = $this->model_buyprocess_buyprocess->getCustomercity_pro($data['address_info'][0]['country']);

            $cust_rec = $this->model_buyprocess_buyprocess->getCustomer($cust_id);
            $firstname = $cust_rec['firstname'];
            $lastname = $cust_rec['lastname'];
            $email = $cust_rec['email'];
            $data['email'] = $email;
            $telephone = $cust_rec['telephone'];
            $data['telephone'] = $telephone;
        }
        else{
            $cust_id = 0;
            $data['cust_id'] = 0;
        }
        /********/
        
        /* fetch the product via product_id -aa */
        if(isset($this->request->get['pxs']))
		{
            $product_id = $this->request->get['pxs'];
            $data['product_id'] = $product_id;
        }
        else
		{
            $product_id = 0;
            $data['product_id'] = $product_id;
        }
        
        $product_rec = $this->model_buyprocess_buyprocess->getProduct($product_id);
        $product_address_data = $this->model_catalog_category->getProductCityProvinceByProductNUserId($product_id);
       
	   $data['city_province'] = $product_address_data;
        $data['is_product_selected'] = 0;
		// echo '<pre>';
        // print_r($product_rec);
		// exit;
        if($product_rec){
            if($product_rec['product_id'])
                $data['is_product_selected'] = 1;

            $this->load->model('tool/image');

            if ($product_rec['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_rec['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
            } else {
                $data['thumb'] = '';
            }
            
            
            $product_name = $product_rec['name'];
            $data['price'] = $product_rec['price'];
            $data['product_name'] = $product_name;
            
            $model = $product_rec['model'];
            
            $data['require_shipping_method'] = $product_rec['require_shipping_method'];
            $data['porcantidad_or_own_shipping'] = $product_rec['porcantidad_or_own_shipping'];
            $data['buyer_pay_or_free_shipping'] = $product_rec['buyer_pay_or_free_shipping'];
            
			$data['vendor_shipping'] = $product_rec['vendor_shipping'];
            $data['buyer_shipping'] = $product_rec['buyer_shipping'];
            $data['xenvios_shipping'] = $product_rec['xenvios_shipping'];
            
            if($product_rec['own_shipping_price'] == '')
                $data['own_shipping_price'] = 0;
            else
                $data['own_shipping_price'] = $product_rec['own_shipping_price'];
            
            if($product_rec['radius'] == '' || $product_rec['radius'] == 0)
                $data['radius'] = 1;
            else
                $data['radius'] = $product_rec['radius'];
            
            $data['vendor_id'] = $product_rec['vendor_id'];
            
            $data['cash_payment'] = $product_rec['cash_payment'];
            $data['wire_payment'] = $product_rec['wire_payment'];
            $data['credit_card_payment'] = $product_rec['credit_card_payment'];
            $data['cash_discount'] = $product_rec['cash_discount'];
            $data['wire_discount'] = $product_rec['wire_discount'];
            $data['credit_card_discount'] = $product_rec['credit_card_discount'];
            
        }
        /***********/
        
        /*******payment method-aa********/
        if(isset($this->request->get['dtmp']) && $this->request->get['dtmp'] != ''){
            $payment_method = $this->request->get['dtmp'];
            $data['payment_method'] = $payment_method;
        }
        else
        {
            $payment_method = '';
            $data['payment_method'] = '';
        }
        /***************/
        
        /* get the selected quantity-aa */
        if(isset($this->request->get['ytq'])){
            $quantity = $this->request->get['ytq'];
            $data['quantity'] = $quantity;
        }
        else{
            $quantity = 0;
            $data['quantity'] = $quantity;
        }
        /**********/
        
        /* get discount - aa */
        if(isset($this->request->get['tcsd'])){
            $discount = $this->request->get['tcsd'];
            $data['discount'] = $discount;
        }
        else{
            $discount = 0;
            $data['discount'] = $discount;
        }
        /**********/
        
	    //ESTO LO ESCRIBIO TOMAS. ES PARA CONSEGUIR EL PRODUCT ADDRESS:
	      $data['product_address_street'] = $this->model_buyprocess_buyprocess->getProductAddress($product_id)['new_address'];
	      $data['product_door_number'] = $this->model_buyprocess_buyprocess->getProductAddress($product_id)['door_number'];
	      $data['product_address_floor'] = $this->model_buyprocess_buyprocess->getProductAddress($product_id)['floor'];
	      $data['product_address_apartment'] = $this->model_buyprocess_buyprocess->getProductAddress($product_id)['apartment'];
        
        
        $unit_price = $this->model_buyprocess_buyprocess->getProductPrice($product_id, $quantity);
        $data['unit_price'] = $unit_price;
       
        $data['discount_results'] = $this->model_buyprocess_buyprocess->getProductDiscount($product_id);
        $data['orig_unit_price'] = $product_rec['price'];
        
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/buyingprocess/buyprocssstep1.tpl')) {
          $this->template = $this->config->get('config_template') . '/template/buyingprocess/buyprocssstep1.tpl';
        } else {
          $this->template = 'default/template/buyingprocess/buyprocssstep1.tpl';
        }
        $this->load->model('localisation/country');
        $data['countries'] = $this->model_localisation_country->getCountries();
        $this->load->model('customuserdetail/userdetail');
        $data['provience'] = $this->model_customuserdetail_userdetail->get_provence();
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
		
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('buyingprocess/buyprocssstep1', $data));

   }
    
    public function getShipCharges(){
        
        $this->load->model('buyprocess/buyprocess');
        
        $vendor_rec = $this->model_buyprocess_buyprocess->getVendorAddress($_POST['vendorId']);
        
        $addressFrom = $vendor_rec['new_address'].','.$vendor_rec['city'].', Pakistan';
        
       
        if($vendor_rec['new_address'] == ''){
           
            echo 0;
        }else{
        $addressTo = $_POST['shipAddress'];
        $radius = $_POST['radius'];
        $shippCharges = $_POST['shippCharges'];
        
        //Change address format
        $formattedAddrFrom = str_replace(' ','+',$addressFrom);
        $formattedAddrTo = str_replace(' ','+',$addressTo);

        //Send request and receive json data
        //AIzaSyDzOyzg6IjkmntDH5FCaR_hXsHa8eCVnnk
        $geocodeFrom = file_get_contents('https://maps.google.com/maps/api/geocode/json?key=AIzaSyBk59WW13Ia-31jOaQbuj1q1WNYCN_CwVs&address='.$formattedAddrFrom.'&sensor=false');
        $outputFrom = json_decode($geocodeFrom);
        
        $geocodeTo = file_get_contents('https://maps.google.com/maps/api/geocode/json?key=AIzaSyBk59WW13Ia-31jOaQbuj1q1WNYCN_CwVs&address='.$formattedAddrTo.'&sensor=false');
        $outputTo = json_decode($geocodeTo);
       
        //Get latitude and longitude from geo data
        $latitudeFrom = $outputFrom->results[0]->geometry->location->lat;
        $longitudeFrom = $outputFrom->results[0]->geometry->location->lng;
        $latitudeTo = $outputTo->results[0]->geometry->location->lat;
        $longitudeTo = $outputTo->results[0]->geometry->location->lng;

        //Calculate distance from latitude and longitude
        $theta = $longitudeFrom - $longitudeTo;
        $dist = sin(deg2rad($latitudeFrom)) * sin(deg2rad($latitudeTo)) +  cos(deg2rad($latitudeFrom)) * cos(deg2rad($latitudeTo)) * cos(deg2rad($theta));
       if($dist>0){
        $dist = acos($dist);
        $dist = rad2deg($dist);
        $miles = $dist * 60 * 1.1515;
        $distance = $miles * 1.609344;
        $div = $distance/$radius;
        if($div > 0 && ($div < 1 || $div == 1))
            /*echo 'From Address: '.$addressFrom.', Distance: '.$distance.', Division: '.$div.', Charges: '.$shippCharges;*/
            echo round($shippCharges);
        else
            /*echo 'From Address: '.$addressFrom.', Distance: '.$distance.', Division: '.$div.', Charges: '.($div*$shippCharges); */ echo round($div*$shippCharges);  
        
    }else{
        
        echo '0';
    }
        }
    }
    public function addOrder(){
        
        $this->load->model('buyprocess/buyprocess');
        
        $cust_id = $this->request->post['cust_id'];
        $product_id = $this->request->post['product_id'];
        $quantity = $this->request->post['quantity'];
        $unit_price = $this->request->post['unit_price'];
        $shipping_charges = $this->request->post['shipping_charges'];
        $shipping_method = $this->request->post['shipping_method'];
        $discount = $this->request->post['discount'];
        $total_amount = $this->request->post['total'];
        $vendor_id = $this->request->post['vendor_id'];
        @$address_id = $this->request->post['address_id'];
        if(!empty($address_id) && !empty($total_amount)){

            $address_rec = $this->model_buyprocess_buyprocess->getCustAddress($address_id);
            $cust_rec = $this->model_buyprocess_buyprocess->getCustomer($cust_id);
            $product_rec = $this->model_buyprocess_buyprocess->getProduct($product_id);
            
            $firstname = $cust_rec['firstname'];
            $lastname = $cust_rec['lastname'];
            $email = $cust_rec['email'];
            $telephone = $cust_rec['telephone'];

            $addData = array(
                'customer_id' => $cust_id,
                'firstname' => $firstname,
                'lastname' => $lastname,
                'email' => $email,
                'telephone' => $telephone,
                'payment_address1' => $address_rec['new_address'],
                'payment_city' => $address_rec['city'],
                'payment_postcode' => $address_rec['postcode'],
                'payment_country_id' => $address_rec['country'],
                'payment_zone_id' => $address_rec['province'],
                'shipping_firstname' => $firstname,
                'shipping_lastname' => $lastname,
                'shipping_address1' => $address_rec['new_address'],
                'shipping_city' => $address_rec['city'],
                'shipping_postcode' => $address_rec['postcode'],
                'shipping_country_id' => $address_rec['country'],
                'shipping_zone_id' => $address_rec['province'],
                'shipping_method' => $shipping_method,
                'shipping_charges' => $shipping_charges,
                'total' => $total_amount,
                'vendor_id' => $vendor_id,
                'ip' => $_SERVER['REMOTE_ADDR'],
                'product_id' => $product_id,
                'name' => $product_rec['name'],
                'model' => $product_rec['model'],
                'quantity' => $quantity,
                'price' => $unit_price,
                'discount' => $discount
            );

            $order = $this->model_buyprocess_buyprocess->addOrder($addData);
            if($order)
                /*go to next tab*/
                echo 'Success';
            else
                echo '<p style="color:orange;">Some problem ocurred, Order has not been added.</p>';

        }
        else{
            echo '<p style="color:orange;">! Either address not selected or some other problem ocurred.</p>';
        }
    }
	
    public function buy_verification_add_address()
	{
		// $this->load->model('customuserdetail/addressbook');
		// model_customeuserdetail_addressbook->buy_verification_add_address($this->request->post);
		$vendor_new_address = $this->request->post['vendor_new_address'];
		$vendor_door_number = $this->request->post['vendor_door_number'];
		$vendor_new_floor = $this->request->post['vendor_new_floor'];
		$vendor_new_apt = $this->request->post['vendor_new_apt'];
		$vendor_new_postcode = $this->request->post['vendor_new_postcode'];
		$vendor_new_country = $this->request->post['vendor_new_country'];
		$vendor_new_province = $this->request->post['vendor_new_province'];
		$vendor_new_cty = $this->request->post['vendor_new_cty'];
		$request_type = $this->request->post['request_type'];
		$modifying_address_id = $this->request->post['modifying_address_id'];
		
		$cid = $this->customer->getId();
		
		if($request_type == 1)
		{
			if($this->db->query("UPDATE ".DB_PREFIX."address_lc SET use_as='Delivery Address', new_address = '".$this->db->escape(isset($vendor_new_address)?$this->db->escape($vendor_new_address):'') ."'  , door_number = '".$this->db->escape(isset($vendor_door_number)?$this->db->escape($vendor_door_number):'') ."' , floor = '".$this->db->escape(isset($vendor_new_floor)?$this->db->escape($vendor_new_floor):'') ."'   , 	apartment = '".$this->db->escape(isset($vendor_new_apt)?$this->db->escape($vendor_new_apt):'') ."' , postcode = '".$this->db->escape(isset($vendor_new_postcode)?$this->db->escape($vendor_new_postcode):'') ."' , city = '".$this->db->escape(isset($vendor_new_cty)?$this->db->escape($vendor_new_cty):'') ."' , country = '".$this->db->escape(isset($vendor_new_country)?$this->db->escape($vendor_new_country):'') ."', province = '".$this->db->escape(isset($vendor_new_province)?$this->db->escape($vendor_new_province):'') ."' , get_from = 'address' where id = ".$modifying_address_id))
			{
				$all_new_data = array();
				$all_new_data['modify'] = 1;
				$all_new_data['id'] = $modifying_address_id;
				$all_new_data['new_address'] = $vendor_new_address;
				$all_new_data['city'] = $vendor_new_cty;
				$all_new_data['country'] = 'Pakistan';
				echo json_encode($all_new_data);
			}
			else
			{
				echo 'not_updated';
			}
		}
		else
		{
			if($this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET use_as='Delivery Address', customer_id = '".(int)$cid."' , new_address = '".$this->db->escape(isset($vendor_new_address)?$this->db->escape($vendor_new_address):'') ."'  , door_number = '".$this->db->escape(isset($vendor_door_number)?$this->db->escape($vendor_door_number):'') ."' , floor = '".$this->db->escape(isset($vendor_new_floor)?$this->db->escape($vendor_new_floor):'') ."'   , 	apartment = '".$this->db->escape(isset($vendor_new_apt)?$this->db->escape($vendor_new_apt):'') ."' , postcode = '".$this->db->escape(isset($vendor_new_postcode)?$this->db->escape($vendor_new_postcode):'') ."' , city = '".$this->db->escape(isset($vendor_new_cty)?$this->db->escape($vendor_new_cty):'') ."' , country = '".$this->db->escape(isset($vendor_new_country)?$this->db->escape($vendor_new_country):'') ."', province = '".$this->db->escape(isset($vendor_new_province)?$this->db->escape($vendor_new_province):'') ."' , get_from = 'address'   "))
			{
				$all_new_data = array();
				$all_new_data['modify'] = 0;
				$all_new_data['id'] = $this->db->getLastId();
				$all_new_data['new_address'] = $vendor_new_address;
				$all_new_data['city'] = $vendor_new_cty;
				$all_new_data['country'] = 'Pakistan';
				echo json_encode($all_new_data);
			}
			else
			{
				echo 'not_inserted';
			}
		}
	}
	
	public function get_address_to_modify()
	{
		
		$modify_address_id = $this->request->post['modify_address_id'];
		
		$query_data = $this->db->query("select * from ".DB_PREFIX."address_lc where id = ".$modify_address_id);
		echo json_encode($query_data->row);
	}
	
	public function get_vendor_details()
	{
		$product_id = $this->request->post['product_id_final'];
		
		$get_seller_id = $this->db->query("select * from ".DB_PREFIX."product where product_id = ".$product_id);
		$query_data = $this->db->query("select * from ".DB_PREFIX."vendordetail_lc where id = ".$get_seller_id->row['seller_id']);
		echo json_encode($query_data->row);
	}
}
?>