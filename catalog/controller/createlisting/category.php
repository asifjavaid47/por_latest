<?php

class ControllerCreatelistingCategory extends Controller
{
	
	private $error = array();
	
	public function test()
	{
		echo 'test';
	}
	
	public function index()
	{
		
		$this->load->language('customuserdetail/userdetail');
		$data['error_userdet_address_1'] = $this->language->get('error_userdet_address_1');
		$data['error_userdet_vendor_doornumber'] = $this->language->get('error_userdet_vendor_doornumber');
		$data['zipcode_labl'] = $this->language->get('zipcode_labl');
		$data['text_select'] = $this->language->get('text_select');
		$data['error_userdet_country'] = $this->language->get('error_userdet_country');
		$data['province_labl'] = $this->language->get('province_labl');
		$data['error_userdet_country'] = $this->language->get('error_userdet_country');
		$data['city_labl'] = $this->language->get('city_labl');
		$data['error_userdet_city'] = $this->language->get('error_userdet_city');
		
		$this->document->setTitle("xcantidad.com - Conviene más");
		
		$this->load->model('createlisting/category');
		
		$check_vendor_id = $this->model_createlisting_category->get_vendor_id();
		
		if($check_vendor_id->num_rows == 0){
			$this->response->redirect($this->url->link('account/register', '', 'SSL'));
		}
		// define template file
		if(file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/createlisting/category.tpl')){
			$this->template = $this->config->get('config_template').'/template/createlisting/category.tpl';
		} else{
			$this->template = 'default/template/createlisting/category.tpl';
		}
		
		if($this->request->server['HTTPS']){
			$server = $this->config->get('config_ssl');
		} else{
			$server = $this->config->get('config_url');
		}
		if(($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()){
			if(null !== $this->customer->isLogged()){
				$cid = $this->customer->getId();
			}
			$this->response->redirect($this->url->link('createlisting/category', 'param=10', 'SSL'));
		}
		
		$data['title'] = $this->document->getTitle();
		$data['base'] = $server;
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		$data['action'] = $this->url->link('createlisting/category', '', true);
		
		$data['get_category'] = $this->model_createlisting_category->get_category();
		
		if(isset($this->request->post['country_id'])){
			$data['country_id'] = (int)$this->request->post['country_id'];
		} elseif(isset($this->session->data['shipping_address']['country_id'])){
			$data['country_id'] = $this->session->data['shipping_address']['country_id'];
		} else{
			$data['country_id'] = $this->config->get('config_country_id');
		}
		
		$this->load->model('localisation/country');
		$data['countries'] = $this->model_localisation_country->getCountries();
		
		$this->load->model('customuserdetail/userdetail');
		$data['provience'] = $this->model_customuserdetail_userdetail->get_provence();
		
		$cid = $this->customer->getId();
		$check_address = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."'");
		$data['check_address'] = $check_address->rows;
		
		if(!empty($data['check_address'])){
			foreach($data['check_address'] as $add_val){
				if(strpos($add_val['use_as'], 'Delivery Address') !== false){
					
					if($add_val['address'] != ''){
						$data['adrs'] = $add_val['address'];
					} else{
						$data['adrs'] = $add_val['new_address'];
					}
					break;
				} else if(strpos($add_val['use_as'], 'Contact Address') !== false){
					
					if($add_val['address'] != ''){
						$data['adrs'] = $add_val['address'];
					} else{
						$data['adrs'] = $add_val['new_address'];
					}
					
					break;
				} else if(strpos($add_val['use_as'], 'Company Address') !== false){
					
					if($add_val['address'] != ''){
						$data['adrs'] = $add_val['address'];
					} else{
						$data['adrs'] = $add_val['new_address'];
					}
					
					break;
				} else{
					if($add_val['address'] != ''){
						$data['adrs'] = $add_val['address'];
					} else{
						$data['adrs'] = $add_val['new_address'];
					}
					
				}
			}
		} else{
			$data['adrs'] = '';
		}
		
		$data['current_customer_id'] = $this->customer->getId();
		
		$this->load->model('customuserdetail/vendordetail');
		
		$cid = $this->customer->getId();
		$get_customer_id_sees = $this->model_createlisting_category->getAllAddress($cid);
		
		$store_address = array();
		if(!empty($get_customer_id_sees)){
			foreach($get_customer_id_sees as $custaddr){
				$get_province = $this->model_customuserdetail_vendordetail->get_province($custaddr['province']);
				$get_city = $this->model_customuserdetail_vendordetail->get_citys($custaddr['city']);
				$get_country = $this->model_customuserdetail_vendordetail->get_country($custaddr['country']);
				
				$address = !empty($custaddr['new_address'])? $custaddr['new_address']:$custaddr['address'];
				$door_number = !empty($custaddr['door_number'])? $custaddr['door_number']:'';
				$floor = !empty($custaddr['floor'])? ", floor ".$custaddr['floor']:'';
				$apartment = !empty($custaddr['apartment'])? $custaddr['apartment']:'';
				$city = !empty($get_city->row['localidad'])? $get_city->row['localidad']:'';
				$provinces = !empty($get_province->row['provincia'])? $get_province->row['provincia']:'';
				$countrys = !empty($get_country->row['name'])? $get_country->row['name']:'';
				
				$complete_addre = $address." ".$door_number.$floor.$apartment.","." ".$city.", ".$provinces.", ".$countrys;
				$store_address[$custaddr['id']] = $complete_addre;
			}
			$data['get_address'] = $store_address;
		} else{
			$data['get_address'] = '';
		}
		
		$this->response->setOutput($this->load->view('createlisting/category', $data));
	}
	
	private function validate()
	{
		if((utf8_strlen(trim($this->request->post['new_address'])) < 3) || (utf8_strlen(trim($this->request->post['new_address'])) > 128)){
			$this->error['new_address'] = $this->language->get('error_new_address');
		}
		
		return !$this->error;
	}
	
	public function check_category()
	{
		$this->load->model('createlisting/category');
		$get_sub_category = $this->model_createlisting_category->check_sub_cat($this->request->post);
		
		foreach($get_sub_category->rows as $key => $val){
			echo '<option value="'.$val['category_id'].'">'.$val['name'].'</option>';
		}
	}
	
	public function check_second_sub_category()
	{
		
		$this->load->model('createlisting/category');
		$get_sub_category = $this->model_createlisting_category->check_sec_sub_cat($this->request->post);
		
		foreach($get_sub_category->rows as $key => $val){
			echo '<option value="'.$val['category_id'].'">'.$val['name'].'</option>';
		}
	}
	
	public function check_third_sub_category()
	{
		
		$this->load->model('createlisting/category');
		$get_sub_category = $this->model_createlisting_category->check_third_sub_cat($this->request->post);
		
		foreach($get_sub_category->rows as $key => $val){
			echo '<option value="'.$val['category_id'].'">'.$val['name'].'</option>';
		}
	}
	
	public function check_forth_sub_category()
	{
		
		$this->load->model('createlisting/category');
		$get_sub_category = $this->model_createlisting_category->check_four_sub_cat($this->request->post);
		
		foreach($get_sub_category->rows as $key => $val){
			echo '<option value="'.$val['category_id'].'">'.$val['name'].'</option>';
		}
	}
	
	public function product_sku()
	{
		$this->load->model('createlisting/category');
		$check_sku = $this->model_createlisting_category->check_sku($this->request->post);
		if($check_sku->num_rows > 0){
			echo '1';
		} else{
			echo '0';
		}
	}
	
	public function upload_product_main_img()
	{
		
		$data['product_main_image'] = '';
		
		$uploads_dir = 'image/catalog/';
		$rand = rand(5, 15);;
		
		if(isset($_FILES["file"]) && is_uploaded_file($this->request->files['file']['tmp_name'])){
			
			$handle = fopen($this->request->files['file']['tmp_name'], "rw");
			$moveto = microtime().'_'.$rand.$this->request->files['file']['name'];
			move_uploaded_file($this->request->files['file']['tmp_name'], $uploads_dir.$moveto);
			$data['product_main_image'] = $this->request->files['file']['name'];
			
			fclose($handle);
		} else{
			$data['product_main_image'] = array();
		}
		
		echo $image_path = "catalog/".$moveto;
		$this->resize(100, 100, $moveto);
		$this->resize(40, 40, $moveto);
	}
	
	/**
	 * Image resize
	 * @param int $width
	 * @param int $height
	 */
	function resize($width, $height, $image_name)
	{
		/* Get original image x y*/
		
		list($w, $h) = getimagesize($_SERVER['DOCUMENT_ROOT'].dirname($_SERVER['PHP_SELF']).'/image/catalog/'.$image_name);
		
		/* calculate new image size with ratio */
		$ratio = max($width / $w, $height / $h);
		$h = ceil($height / $ratio);
		$x = ($w - $width / $ratio) / 2;
		$w = ceil($width / $ratio);
		/* new file name */
		
		$get_extension = pathinfo($image_name, PATHINFO_EXTENSION);
		$explode_from_extention = explode(".".$get_extension, $image_name);
		$path = 'image/cache/catalog/'.$explode_from_extention[0].'-'.$width.'x'.$height.'.'.$get_extension;
		
		/* read binary data from image file */
		$imgString = file_get_contents($_SERVER['DOCUMENT_ROOT'].dirname($_SERVER['PHP_SELF']).'/image/catalog/'.$image_name);
		/* create image from string */
		$image = imagecreatefromstring($imgString);
		$tmp = imagecreatetruecolor($width, $height);
		imagecopyresampled($tmp, $image, 0, 0, $x, 0, $width, $height, $w, $h);
		/* Save image */
		switch($_FILES['file']['type']){
			case 'image/jpeg':
				imagejpeg($tmp, $path, 100);
				break;
			case 'image/png':
				imagepng($tmp, $path, 0);
				break;
			case 'image/gif':
				imagegif($tmp, $path);
				break;
			default:
				exit;
				break;
		}
		return $path;
		/* cleanup memory */
		imagedestroy($image);
		imagedestroy($tmp);
	}
	
	public function upload_product_img()
	{
		
		$data['product_image'] = '';
		
		$uploads_dir = 'image/catalog/';
		$rand = rand(5, 15);;
		
		if(isset($_FILES["file"]) && is_uploaded_file($this->request->files['file']['tmp_name'])){
			
			$handle = fopen($this->request->files['file']['tmp_name'], "rw");
			$moveto = microtime().'_'.$rand.$this->request->files['file']['name'];
			move_uploaded_file($this->request->files['file']['tmp_name'], $uploads_dir.$moveto);
			$data['product_image'] = $this->request->files['file']['name'];
			
			fclose($handle);
		} else{
			$data['product_image'] = array();
		}
		
		echo $image_path = "catalog/".$moveto;
	}
	
	public function add_new_address()
	{
		
		
		$post_data = $this->request->post;
		$cid = $this->customer->getId();
		$this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET customer_id = '".(int)$cid."' , new_address = '".$this->db->escape(isset($post_data['address'])? $this->db->escape($post_data['address']):'')."'  , door_number = '".$this->db->escape(isset($post_data['door_number'])? $this->db->escape($post_data['door_number']):'')."' , floor = '".$this->db->escape(isset($post_data['floors_val'])? $this->db->escape($post_data['floors_val']):'')."'   , 	apartment = '".$this->db->escape(isset($post_data['apt'])? $this->db->escape($post_data['apt']):'')."' , postcode = '".$this->db->escape(isset($post_data['postcde'])? $this->db->escape($post_data['postcde']):'')."' , city = '".$this->db->escape(isset($post_data['city'])? $this->db->escape($post_data['city']):'')."' , country = '".$this->db->escape(isset($post_data['country_id'])? $this->db->escape($post_data['country_id']):'')."', province = '".$this->db->escape(isset($post_data['province'])? $this->db->escape($post_data['province']):'')."' ");
		$last_id = $this->db->getLastId();
		
		$this->load->model('createlisting/category');
		$this->load->model('customuserdetail/vendordetail');
		
		$get_customer_id_sees = $this->model_createlisting_category->getAddNewAddress($last_id);
		
		$get_province = $this->model_customuserdetail_vendordetail->get_province($get_customer_id_sees[0]['province']);
		$get_city = $this->model_customuserdetail_vendordetail->get_citys($get_customer_id_sees[0]['city']);
		$get_country = $this->model_customuserdetail_vendordetail->get_country($get_customer_id_sees[0]['country']);
		$address = !empty($get_customer_id_sees[0]['new_address'])? $get_customer_id_sees[0]['new_address']:$get_customer_id_sees[0]['address'];
		$door_number = !empty($get_customer_id_sees[0]['door_number'])? $get_customer_id_sees[0]['door_number']:'';
		$floor = !empty($get_customer_id_sees[0]['floor'])? ", floor ".$get_customer_id_sees[0]['floor']:'';
		$apartment = !empty($get_customer_id_sees[0]['apartment'])? $get_customer_id_sees[0]['apartment']:'';
		$city = !empty($get_city->row['localidad'])? $get_city->row['localidad']:'';
		$provinces = !empty($get_province->row['provincia'])? $get_province->row['provincia']:'';
		$countrys = !empty($get_country->row['name'])? $get_country->row['name']:'';
		
		$complete_addre = $address." ".$door_number.$floor.$apartment.","." ".$city.", ".$provinces.", ".$countrys;
		$store_address[$get_customer_id_sees[0]['id']] = $complete_addre;
		
		echo json_encode(array("last_id" => $last_id, "comp_addr" => $complete_addre));
	}
	
	public function product_information()
	{
		
		$this->load->model('createlisting/category');
		$get_vendor_id = $this->model_createlisting_category->get_vendor_id();
		if($get_vendor_id->num_rows > 0){
			$add_vendor_product = $this->model_createlisting_category->add_vendor_product($get_vendor_id->row['id'], $this->request->post);
		}
	}
	
	public function product_listing_update()
	{
		
		$this->load->model('createlisting/category');
		$get_vendor_id = $this->model_createlisting_category->product_listing_id($this->request->post);
	}
	
	public function check_login()
	{
		if(!$this->customer->isLogged()){
			echo 'not_logged_in';
		} else{
			echo 'logged_in';
		}
	}
}

?>