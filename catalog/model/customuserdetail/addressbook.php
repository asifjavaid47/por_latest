<?php
class ModelCustomuserdetailAddressbook extends Model {
	public function get_address($cid) {
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$cid."'");
		
		return $query;
	}
	

	public function get_province($zone_id) {		
		$query = $this->db->query("SELECT * FROM provincias WHERE  id= '".$zone_id."'");
		return $query;
	}

	public function get_cty($city_id) {		
		$query = $this->db->query("SELECT * FROM localidades WHERE  id= '".$city_id."'");
		return $query;
	}


	public function get_country($country_id) {		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."country WHERE  country_id= '".$country_id."'");
		return $query;
	}

	public function get_all_address($cid){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  customer_id= '".$cid."'");
		return $query;
	}
	

	public function add_new_address($post_data , $cid){
		   $this->db->query("INSERT INTO ".DB_PREFIX."address_lc SET customer_id = '".(int)$cid."' , new_address = '".$this->db->escape(isset($post_data['new_address'])?$this->db->escape($post_data['new_address']):'') ."'  , door_number = '".$this->db->escape(isset($post_data['address_doornumber'])?$this->db->escape($post_data['address_doornumber']):'') ."' , floor = '".$this->db->escape(isset($post_data['address_floor'])?$this->db->escape($post_data['address_floor']):'') ."'   , 	apartment = '".$this->db->escape(isset($post_data['address_apartment'])?$this->db->escape($post_data['address_apartment']):'') ."' , postcode = '".$this->db->escape(isset($post_data['postcode'])?$this->db->escape($post_data['postcode']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."' , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."', province = '".$this->db->escape(isset($post_data['proviences_id'])?$this->db->escape($post_data['proviences_id']):'') ."' , get_from = 'address'   ");
	
	}
	
	public function remove_addresses($post_data)
	{
		$id = $post_data['id'];
		$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET use_as = '' WHERE id = '".$id."'");
	}

	public function update_save_as($post_data)
	{
		$id = $post_data['id'];
		$currently_added_index = $post_data['number_of_addresses'] - 1;
		$currently_added = $post_data['address'][$currently_added_index];
		$cid = $this->customer->getId();
		$total_address = '';
			for($i=0; $i< $post_data['number_of_addresses']; $i++ )
			{
				$total_address = $total_address . $post_data['address'][$i].',';
			}
			
			$row_already_having_record = $this->db->query("Select * from " . DB_PREFIX . "address_lc WHERE customer_id = '".$cid."' AND use_as LIKE \"%".$currently_added."%\" ");
			
			$total_previous_new_address = '';
			if($row_already_having_record->num_rows > 0 )
			{
				$previous_row_id = $row_already_having_record->row['id'];
				$all_address_previous = $row_already_having_record->row['use_as'];
				$exploded_addresses = explode(',', $all_address_previous);
				$total_previous_addresses = sizeof($exploded_addresses);
				for($i =0 ; $i < $total_previous_addresses - 1 ; $i++)
				{
					if(trim($post_data['address'][$currently_added_index]) == trim($exploded_addresses[$i]))
					{
					}
					else
					{
						$total_previous_new_address = $total_previous_new_address . $exploded_addresses[$i].',';
					}
				}
					
				if($previous_row_id != $id)
				{
					$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET use_as = '".$total_previous_new_address."' WHERE id = '".$previous_row_id."'");
					$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET use_as = '".$total_address."' WHERE id = '".$id."'");
				}
			}
			else
			{
				$this->db->query("UPDATE " . DB_PREFIX . "address_lc SET use_as = '".$total_address."' WHERE id = '".$id."'");
			}
	}


	public function update_current_address($post_data){
		
		
		$query_address = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc WHERE  id= '".$post_data['id']."'");
		
		   $this->db->query("UPDATE " . DB_PREFIX . "address_lc SET new_address = '".$this->db->escape(isset($post_data['address'])?$this->db->escape($post_data['address']):'') ."'  , door_number = '".$this->db->escape(isset($post_data['door_number'])?$this->db->escape($post_data['door_number']):'') ."'  , floor = '".$this->db->escape(isset($post_data['floors_val'])?$this->db->escape($post_data['floors_val']):'') ."'  , apartment = '".$this->db->escape(isset($post_data['apt'])?$this->db->escape($post_data['apt']):'') ."'  , postcode = '".$this->db->escape(isset($post_data['postcde'])?$this->db->escape($post_data['postcde']):'') ."'  , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."'  , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."'  , 	province = '".$this->db->escape(isset($post_data['province'])?$this->db->escape($post_data['province']):'') ."'  WHERE id = '".$post_data['id']."'");
		  
		  
		//user detail update as well  
		if($query_address->row['get_from'] == 'user detail'){
			
			$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$query_address->row['customer_id']."'");
			if($query1->num_rows > 0){
				$this->db->query("UPDATE " . DB_PREFIX . "address SET   address_1 = '" . $this->db->escape($post_data['address']) . "' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."'  , postcode = '".$this->db->escape(isset($post_data['postcde'])?$this->db->escape($post_data['postcde']):'') ."'  , door_number = '".$this->db->escape(isset($post_data['door_number'])?$this->db->escape($post_data['door_number']):'') ."'  ,  floor = '".$this->db->escape(isset($post_data['floors_val'])?$this->db->escape($post_data['floors_val']):'') ."' ,  apartment = '".$this->db->escape(isset($post_data['apt'])?$this->db->escape($post_data['apt']):'') ."' , country_id = '" . (int)$post_data['country_id'] . "', zone_id = '" . (int)$post_data['province'] . "'   WHERE customer_id = '" .$query_address->row['customer_id']. "'");
			} 
		}

        // vendor detail update 
		if($query_address->row['get_from'] == 'vendor detail'){
			
			$query1 = $this->db->query("SELECT * FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$query_address->row['customer_id']."'");
		if($query1->num_rows > 0){
                 $this->db->query("UPDATE ".DB_PREFIX."vendordetail_lc SET  new_address = '".$this->db->escape(isset($post_data['address'])?$this->db->escape($post_data['address']):'') ."' , vendor_door_number = '".$this->db->escape(isset($post_data['door_number'])?$this->db->escape($post_data['door_number']):'') ."', vendor_floor = '".$this->db->escape(isset($post_data['floors_val'])?$this->db->escape($post_data['floors_val']):'') ."', vendor_apartment = '".$this->db->escape(isset($post_data['apt'])?$this->db->escape($post_data['apt']):'') ."', zip_code = '".$this->db->escape(isset($post_data['postcde'])?$this->db->escape($post_data['postcde']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."' , country = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."' , province = '".$this->db->escape(isset($post_data['province'])?$this->db->escape($post_data['province']):'') ."' WHERE customer_id = '".$query_address->row['customer_id']. "'");
		}
		}


        // company detail update 
		if($query_address->row['get_from'] == 'company detail'){
		$query2 = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$query_address->row['customer_id']."'");
		if($query2->num_rows > 0){
				$this->db->query("UPDATE " . DB_PREFIX . "companydetail_lc SET    company_doornumber = '".$this->db->escape(isset($post_data['door_number'])?$this->db->escape($post_data['door_number']):'') ."'  , company_floor = '".$this->db->escape(isset($post_data['floors_val'])?$this->db->escape($post_data['floors_val']):'') ."' , company_apartment = '".$this->db->escape(isset($post_data['apt'])?$this->db->escape($post_data['apt']):'') ."'  , postcode = '".$this->db->escape(isset($post_data['postcde'])?$this->db->escape($post_data['postcde']):'') ."' , city = '".$this->db->escape(isset($post_data['city'])?$this->db->escape($post_data['city']):'') ."', 	country_id = '".$this->db->escape(isset($post_data['country_id'])?$this->db->escape($post_data['country_id']):'') ."',zone_id = '".$this->db->escape(isset($post_data['province'])?$this->db->escape($post_data['province']):'') ."' , new_address = '".$this->db->escape(isset($post_data['address'])?$this->db->escape($post_data['address']):'') ."'  WHERE customer_id = '". $query_address->row['customer_id']."' ");
		}
		}	
	}
}