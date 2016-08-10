<?php
class ModelCustomuserdetailUserdetail extends Model {
	public function get_customer_id_session($cid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."customer WHERE  email= '".$email."'");
		return $query;
	}
	
	public function add_data_address_table($cid , $post_data){

		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."customer WHERE  customer_id= '".$cid."'");
		$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$cid."'");
		
		if($query1->num_rows > 0){
				$this->db->query("UPDATE " . DB_PREFIX . "address SET firstname = '" . $this->db->escape($query->rows[0]['firstname']) . "', lastname = '" . $this->db->escape($query->rows[0]['lastname']) . "',  address_1 = '" . $this->db->escape($post_data['address_1']) . "' , city = '" . $this->db->escape($post_data['city']) . "', postcode = '" . $this->db->escape($post_data['postcode']) . "', door_number = '".$this->db->escape(isset($post_data['doornumber'])?$this->db->escape($post_data['doornumber']):'') ."'  ,  floor = '".$this->db->escape(isset($post_data['floor'])?$this->db->escape($post_data['floor']):'') ."' ,  apartment = '".$this->db->escape(isset($post_data['apartment'])?$this->db->escape($post_data['apartment']):'') ."' , country_id = '" . (int)$post_data['country_id'] . "', zone_id = '" . (int)$post_data['provience_id'] . "' , lc_tax_id = '" .$this->db->escape(isset($post_data['tax_id'])?$this->db->escape($post_data['tax_id']):'')."'  WHERE customer_id = '" . (int)$cid . "'");
		}else{
			
		        $this->db->query("INSERT INTO ".DB_PREFIX."address SET customer_id = '" . (int)$query->rows[0]['customer_id'] . "', firstname = '" . $this->db->escape($query->rows[0]['firstname']) . "', lastname = '" . $this->db->escape($query->rows[0]['lastname']) . "',  address_1 = '" . $this->db->escape($post_data['address_1']) . "' , city = '" . $this->db->escape($post_data['city']) . "', postcode = '" . $this->db->escape($post_data['postcode']) . "' , door_number = '".$this->db->escape(isset($post_data['doornumber'])?$this->db->escape($post_data['doornumber']):'') ."'  ,  floor = '".$this->db->escape(isset($post_data['floor'])?$this->db->escape($post_data['floor']):'') ."' ,  apartment = '".$this->db->escape(isset($post_data['apartment'])?$this->db->escape($post_data['apartment']):'') ."' , country_id = '" . (int)$post_data['country_id'] . "', zone_id = '" . (int)$post_data['provience_id'] . "' , lc_tax_id = '" .$this->db->escape(isset($post_data['tax_id'])?$this->db->escape($post_data['tax_id']):'')."'  ");
			
		}
		
		
        $qry = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."' and get_from = 'user detail'");		
		
		if($qry->num_rows > 0){
$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET address = '".$this->db->escape($post_data['address_1'])."' , city = '".$this->db->escape($post_data['city'])."', postcode = '".$this->db->escape($post_data['postcode'])."', door_number = '".$this->db->escape(isset($post_data['doornumber'])?$this->db->escape($post_data['doornumber']):'')."'  ,  floor = '".$this->db->escape(isset($post_data['floor'])?$this->db->escape($post_data['floor']):'') ."' ,  apartment = '".$this->db->escape(isset($post_data['apartment'])?$this->db->escape($post_data['apartment']):'') ."' , country = '" . (int)$post_data['country_id'] . "', province = '" . (int)$post_data['provience_id'] . "'  WHERE customer_id = '" . (int)$cid . "' and get_from = 'user detail'  ");
		}else{
		        $this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET customer_id = '". (int)$cid ."'  ,  address = '" . $this->db->escape($post_data['address_1']) . "' , city = '" . $this->db->escape($post_data['city']) . "', postcode = '" . $this->db->escape($post_data['postcode']) . "' , door_number = '".$this->db->escape(isset($post_data['doornumber'])?$this->db->escape($post_data['doornumber']):'')."'  ,  floor = '".$this->db->escape(isset($post_data['floor'])?$this->db->escape($post_data['floor']):'') ."' ,  apartment = '".$this->db->escape(isset($post_data['apartment'])?$this->db->escape($post_data['apartment']):'') ."' , country = '" . (int)$post_data['country_id'] . "', province = '" . (int)$post_data['provience_id'] . "' , use_as = ' Delivery Address, Contact Address, Company Address,' ,  get_from = 'user detail'  ");
		}
		
	}
        public function get_provence(){
            $query = $this->db->query("SELECT * FROM   provincias");

		return $query->rows;
        }
	
	public function getcities($country_id) {   
		 $query = $this->db->query("SELECT * FROM localidades  WHERE id_privincia = '" . (int)$country_id . "'");
		return $query->rows;
	}
}