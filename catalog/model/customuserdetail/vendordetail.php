<?php
class ModelCustomuserdetailVendordetail extends Model {
	public function get_address($cid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$cid."'");
		return $query;
	}
	
	public function add_vendor_detail($cid , $post_data){
		$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$cid."'");
		if($query1->num_rows > 0){
				$this->db->query("UPDATE " . DB_PREFIX . "vendordetail_lc SET    v_name = '" . $this->db->escape($post_data['name']) . "', v_phone = '".$this->db->escape($post_data['phone'])."', v_email = '".$post_data['email']."' , v_address = '".$post_data['sec_address']."'  , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."'   , vendor_door_number = '".$this->db->escape(isset($post_data['vendor_doornumber'])?$this->db->escape($post_data['vendor_doornumber']):'') ."', vendor_floor = '".$this->db->escape(isset($post_data['vendor_floor'])?$this->db->escape($post_data['vendor_floor']):'') ."', 	vendor_apartment = '".$this->db->escape(isset($post_data['vendor_apartment'])?$this->db->escape($post_data['vendor_apartment']):'') ."', zip_code = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."' , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."' , province = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."' ,   vendor_information = '".$this->db->escape(isset($post_data['vendor_information'])?$this->db->escape($post_data['vendor_information']):'') ."' WHERE customer_id = '" . (int)$cid . "'");
		}else{
$this->db->query("INSERT INTO ".DB_PREFIX."vendordetail_lc SET customer_id = '".(int)$cid."' , v_name = '".$this->db->escape($post_data['name'])."', v_phone = '".$this->db->escape($post_data['phone'])."', v_email = '".$post_data['email']."' , v_address = '".$post_data['sec_address']."'  , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."'  , vendor_door_number = '".$this->db->escape(isset($post_data['vendor_doornumber'])?$this->db->escape($post_data['vendor_doornumber']):'') ."', vendor_floor = '".$this->db->escape(isset($post_data['vendor_floor'])?$this->db->escape($post_data['vendor_floor']):'') ."', 	vendor_apartment = '".$this->db->escape(isset($post_data['vendor_apartment'])?$this->db->escape($post_data['vendor_apartment']):'') ."', zip_code = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."' , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."' , province = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."'  , vendor_information = '".$this->db->escape(isset($post_data['vendor_information'])?$this->db->escape($post_data['vendor_information']):'') ."'  ");
		}
		
		
		
		$qry = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."' and get_from = 'vendor detail'");		
		
				if(!empty($post_data['country_id'])){
			$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET  use_as = ' Delivery Address, Company Address,'  WHERE customer_id = '" . (int)$cid . "' and get_from = 'user detail'  ");
					$this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET customer_id = '".(int)$cid."' , address = '".$post_data['sec_address']."'  , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."'   , door_number = '".$this->db->escape(isset($post_data['vendor_doornumber'])?$this->db->escape($post_data['vendor_doornumber']):'') ."', 	floor = '".$this->db->escape(isset($post_data['vendor_floor'])?$this->db->escape($post_data['vendor_floor']):'') ."', 	apartment = '".$this->db->escape(isset($post_data['vendor_apartment'])?$this->db->escape($post_data['vendor_apartment']):'') ."', postcode = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."' , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."' , province = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."' , use_as = ' Contact Address,' , get_from = 'vendor detail'   ");
			}else{
			}

	
	}

	public function get_province($zone_id) {		
		$query = $this->db->query("SELECT * FROM provincias WHERE  id= '".$zone_id."'");
		return $query;
	}

	public function get_citys($zone_id) {		
		$query = $this->db->query("SELECT * FROM localidades WHERE  id= '".$zone_id."'");
		return $query;
	}

	public function get_country($country_id) {		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."country WHERE  country_id= '".$country_id."'");
		return $query;
	}
}