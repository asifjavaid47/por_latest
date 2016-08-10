<?php
class ModelCustomuserdetailCompanydetail extends Model {
	public function get_address($cid) {
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$cid."'");
		
		return $query;
	}
	
	public function add_compant_detail($cid , $post_data , $banner , $logo){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$cid."'");
		$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$cid."'");
		if($query1->num_rows > 0){
				$this->db->query("UPDATE " . DB_PREFIX . "companydetail_lc SET   company_name = '" . $this->db->escape($post_data['company_name']) . "' ,company_address = '" . $this->db->escape($post_data['company_address']) . "' , company_doornumber = '".$this->db->escape(isset($post_data['company_doornumber'])?$this->db->escape($post_data['company_doornumber']):'') ."'  , company_floor = '".$this->db->escape(isset($post_data['company_floor'])?$this->db->escape($post_data['company_floor']):'') ."' , company_apartment = '".$this->db->escape(isset($post_data['company_apartment'])?$this->db->escape($post_data['company_apartment']):'') ."'  , postcode = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."', 	country_id = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."',zone_id = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."' , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."' , 	company_logo = '".$this->db->escape(isset($logo)?$this->db->escape($logo):'') ."'   , 	company_banner = '".$this->db->escape(isset($banner)?$this->db->escape($banner):'') ."'  WHERE customer_id = '" . (int)$cid . "'");
		}else{
		        $this->db->query("INSERT INTO ".DB_PREFIX."companydetail_lc SET customer_id = '".(int)$cid."' , vendor_id = '".$this->db->escape($query->row['id']) ."'  , company_name = '" . $this->db->escape($post_data['company_name']) . "' ,company_address = '" . $this->db->escape($post_data['company_address']) . "' , company_doornumber = '".$this->db->escape(isset($post_data['company_doornumber'])?$this->db->escape($post_data['company_doornumber']):'') ."'  , company_floor = '".$this->db->escape(isset($post_data['company_floor'])?$this->db->escape($post_data['company_floor']):'') ."' , company_apartment = '".$this->db->escape(isset($post_data['company_apartment'])?$this->db->escape($post_data['company_apartment']):'') ."'   , postcode = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."', 	country_id = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."', zone_id = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."'   , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."'  , 	company_logo = '".$this->db->escape(isset($logo)?$this->db->escape($logo):'') ."'   , 	company_banner = '".$this->db->escape(isset($banner)?$this->db->escape($banner):'') ."' ");
		}
		
		$qry = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."' and get_from = 'company detail'");		
		
		if($qry->num_rows > 0){
		}else{
			
			if(!empty($post_data['company_doornumber'])){
				
				
				$check_for_use_as_vendor = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."' and get_from = 'vendor detail'");
				if(!empty($check_for_use_as_vendor->row['door_number']))
				{
					$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET  use_as = ' Delivery Address,'  WHERE customer_id = '" . (int)$cid . "' and get_from = 'user detail'  ");
				}
				else
				{
					$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET  use_as = ' Delivery Address, Contact Address,'  WHERE customer_id = '" . (int)$cid . "' and get_from = 'user detail'  ");
				}
				
				
				               $this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET address = '".$this->db->escape(isset($post_data['company_address'])?$this->db->escape($post_data['company_address']):'') ."'  , new_address = '".$this->db->escape(isset($post_data['address_1'])?$this->db->escape($post_data['address_1']):'') ."' , door_number = '".$this->db->escape(isset($post_data['company_doornumber'])?$this->db->escape($post_data['company_doornumber']):'') ."'   , floor = '".$this->db->escape(isset($post_data['company_floor'])?$this->db->escape($post_data['company_floor']):'') ."'  , apartment = '".$this->db->escape(isset($post_data['company_apartment'])?$this->db->escape($post_data['company_apartment']):'') ."'  , 	postcode = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."'  , 	city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."'  , 	country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."'  , 	province = '".$this->db->escape(isset($post_data['zone_id'])?$this->db->escape($post_data['zone_id']):'') ."' , use_as = ' Company Address,' ,get_from = 'company detail' ,  customer_id = '" . (int)$cid . "' ");

			}else{
			}
 		}
	}


	public function get_province($zone_id) {		
		$query = $this->db->query("SELECT * FROM provincias WHERE  id= '".$zone_id."'");
		return $query;
	}
	
	public function get_citys1($zone_id) {		
		$query = $this->db->query("SELECT * FROM localidades WHERE  id= '".$zone_id."'");
		return $query;
	}


	public function get_country($country_id) {		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."country WHERE  country_id= '".$country_id."'");
		return $query;
	}

	public function get_new_province($zone_id) {		
		$query = $this->db->query("SELECT * FROM provincias WHERE  id = '".$zone_id."'");
		return $query;
	}
	
	public function get_new_city($zone_id) {		
		$query = $this->db->query("SELECT * FROM localidades WHERE  id= '".$zone_id."'");
		return $query;
	}

	public function get_new_country($country_id) {		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."country WHERE  country_id= '".$country_id."'");
		return $query;
	}



	
	
	public function get_new_address_vendor($cid){
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$cid."'");
		return $query;
	}
	
	public function save_companylogo($logo , $cid){
				
		$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$cid."'");
		if($query1->num_rows > 0){
				$this->db->query("UPDATE  ".DB_PREFIX."companydetail_lc SET 	company_logo = '".$logo."'  WHERE customer_id = '".(int)$cid ."'  ");
		}else{
				$this->db->query("INSERT INTO  ".DB_PREFIX."companydetail_lc SET 	company_logo = '".$logo."' , customer_id = '".$cid."'  ");
		}
	}

	

	public function save_companybanner($banner , $cid){
				
		$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$cid."'");
		if($query1->num_rows > 0){
				$this->db->query("UPDATE  ".DB_PREFIX."companydetail_lc SET 	company_banner = '".$banner."'  WHERE customer_id = '".(int)$cid ."'  ");
		}else{
				$this->db->query("INSERT INTO  ".DB_PREFIX."companydetail_lc SET 	company_banner = '".$banner."' , customer_id = '".$cid."'  ");
		}
	}


		public function getImages($cid){
		 
		 $query = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$cid."'");
		 return $query;
	   }	
}