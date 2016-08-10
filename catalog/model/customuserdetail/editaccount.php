<?php
class ModelCustomuserdetailEditaccount extends Model {
	public function display_basic_detail($cid) {
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."customer WHERE  customer_id= '".$cid."'");
		
		return $query;
	}
	

	public function display_basic_detail_tax_id($cid) {
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address WHERE  customer_id= '".$cid."'");
		
		return $query;
	}
	

	public function display_contact_detail($cid) {
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$cid."'");
		
		return $query;
	}

	public function display_company_detail($cid) {
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."companydetail_lc WHERE  customer_id= '".$cid."'");
		
		return $query;
	}


	
	public function update_name($name , $cid){
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '".$name."' WHERE customer_id = '" . (int)$cid . "'");
				$this->db->query("UPDATE " . DB_PREFIX . "address SET firstname = '".$name."' WHERE customer_id = '" . (int)$cid . "'");
	}
	public function update_surename($surename , $cid){
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET lastname = '".$surename."' WHERE customer_id = '" . (int)$cid . "'");
				$this->db->query("UPDATE " . DB_PREFIX . "address SET lastname = '".$surename."' WHERE customer_id = '" . (int)$cid . "'");
	}

	public function update_email($email , $cid){
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET email = '".$email."' WHERE customer_id = '" . (int)$cid . "'");
	}

	public function update_phone($phone , $cid){
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET 	fax = '".$phone."' WHERE customer_id = '" . (int)$cid . "'");
	}

	public function update_taxid($taxid , $cid){
				$this->db->query("UPDATE " . DB_PREFIX . "address SET 	lc_tax_id = '".$taxid."' WHERE customer_id = '" . (int)$cid . "'");
	}
	
	public function check_taxid_for_uniqueness($tax_id)
	{
		$record_for_tax_id = $this->db->query("SELECT count(*) as number_of_tax_ids FROM " . DB_PREFIX . "address WHERE lc_tax_id ='".$tax_id."'");
		return $record_for_tax_id;
	}


	public function update_contactname($v_name , $cid){

				$check_contact_name_exists = $this->db->query("SELECT count(*) as cid FROM " . DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
    			if($check_contact_name_exists->row['cid'] > 0)
				{
				   $this->db->query("UPDATE " . DB_PREFIX . "vendordetail_lc SET 	v_name = '".$v_name."' WHERE customer_id = '".(int)$cid."' ");
				}
				else
				{
					$this->db->query("INSERT INTO ".DB_PREFIX."vendordetail_lc (customer_id,v_name) VALUES (".(int)$cid.", '".$this->db->escape($v_name)."')");
				}
	}

	public function update_contactphone($v_phone , $cid){
				$check_contact_phone_exists = $this->db->query("SELECT count(*) as cid FROM " . DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
                if($check_contact_phone_exists->row['cid'] > 0)
				{
				   $this->db->query("UPDATE " . DB_PREFIX . "vendordetail_lc SET 	v_phone = '".$v_phone."' WHERE customer_id = '" . (int)$cid . "'");
				}
				else
				{
				   $this->db->query("INSERT INTO ".DB_PREFIX."vendordetail_lc (customer_id,v_phone) VALUES (".(int)$cid.", '".$this->db->escape($v_phone)."')");
				}
	}

	public function update_contactemail($v_email , $cid){
		        $check_contact_email_exists = $this->db->query("SELECT count(*) as cid FROM " . DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
                if($check_contact_email_exists->row['cid'] > 0)
				{
				    $this->db->query("UPDATE " . DB_PREFIX . "vendordetail_lc SET 	v_email = '".$v_email."' WHERE customer_id = '" . (int)$cid . "'");
				}
				else
				{
					$this->db->query("INSERT INTO ".DB_PREFIX."vendordetail_lc (customer_id,v_email) VALUES (".(int)$cid.", '".$this->db->escape($v_email)."')");
				}
	}



	public function update_companyname($company_name , $cid){
		       $check_vendor_id = $this->db->query("SELECT *  FROM ". DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
		        $check_company_name_cid = $this->db->query("SELECT count(*) as cid FROM ".DB_PREFIX."companydetail_lc WHERE customer_id = '".(int)$cid."'");
				if($check_company_name_cid->row['cid'] > 0)
				{
				    $this->db->query("UPDATE " . DB_PREFIX . "companydetail_lc SET 	company_name = '".$company_name."' ,  vendor_id =  ".(int)$check_vendor_id->row['id']." WHERE customer_id = '" . (int)$cid . "'");
				}
				else
				{
					$this->db->query("INSERT INTO ".DB_PREFIX."companydetail_lc (customer_id,company_name , vendor_id) VALUES (".(int)$cid.", '".$this->db->escape($company_name)."' , ".(int)$check_vendor_id->row['id'].")");
				}
	}

	public function update_companylogo($logo , $cid){
		        $check_vendor_id = $this->db->query("SELECT *  FROM ". DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
		     	$check_company_logo_cid = $this->db->query("SELECT count(*) as cid FROM ".DB_PREFIX."companydetail_lc WHERE customer_id = '".(int)$cid."'");
				if($check_company_logo_cid->row['cid'] > 0)
				{
				    $this->db->query("UPDATE " . DB_PREFIX . "companydetail_lc SET 	company_logo = '".$logo."' ,  vendor_id =  ".(int)$check_vendor_id->row['id']." WHERE customer_id = '" . (int)$cid . "'");
				}
				else
				{
					$this->db->query("INSERT INTO ".DB_PREFIX."companydetail_lc (customer_id,company_logo,vendor_id) VALUES (".(int)$cid.", '".$this->db->escape($logo)."' , ".(int)$check_vendor_id->row['id'].")");
				}
	}


	public function update_companybanner($banner , $cid){
				$check_vendor_id = $this->db->query("SELECT *  FROM ". DB_PREFIX . "vendordetail_lc WHERE customer_id = '".(int)$cid."'");
		     	$check_company_banner_cid = $this->db->query("SELECT count(*) as cid FROM ".DB_PREFIX."companydetail_lc WHERE customer_id = '".(int)$cid."'");
				if($check_company_banner_cid->row['cid'] > 0)
				{
				$this->db->query("UPDATE " . DB_PREFIX . "companydetail_lc SET 	company_banner = '".$banner."'  ,  vendor_id =  ".(int)$check_vendor_id->row['id']."    WHERE customer_id = '" . (int)$cid . "'");
				}
				else
				{
					$this->db->query("INSERT INTO ".DB_PREFIX."companydetail_lc (customer_id,company_banner,vendor_id) VALUES (".(int)$cid.", '".$this->db->escape($banner)."' , ".(int)$check_vendor_id->row['id'].")");
				}
	}
}