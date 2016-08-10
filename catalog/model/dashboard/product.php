<?php
class ModelDashboardProduct extends Model {



	public function getAllProduct($vid) 
	{
		$query = $this->db->query("select * from ".DB_PREFIX."product as prod inner join ".DB_PREFIX."product_description pd on prod.product_id = pd.product_id where prod.seller_id= ".$vid." and pd.language_id = 1 and prod.product_status = 1 ");
		return $query->rows;
	}  
	
	public function get_all_product_stock_zero($vid)
	{
		//$query = $this->db->query("select * from ".DB_PREFIX."product as prod inner join ".DB_PREFIX."product_description pd on prod.product_id = pd.product_id where prod.seller_id= ".$vid." and pd.language_id = 1 and prod.product_status = 1 and prod.quantity <= 0  ");
		$query = $this->db->query("select * from ".DB_PREFIX."product as prod inner join ".DB_PREFIX."product_description pd on prod.product_id = pd.product_id where pd.language_id = 1 and prod.product_status = 1 and prod.quantity <= 0  ");
		return $query->rows;		
	}

	public function getDiscountPrice($pid) 
	{
		$query = $this->db->query("select * from ".DB_PREFIX."product_discount where product_id  = ".$pid." ");
		return $query->rows;
	}

	public function UpdateProductType($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET listing_type = '".$info['product_type']."' WHERE product_id = ".(int)$info['product_id']." ");
	}

	public function UpdateProductStock($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = '".$info['stock']."' WHERE product_id = ".(int)$info['product_id']." ");
	}

	public function UpdateSinglePrice($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET price = '".$info['sngl_prc']."' WHERE product_id = ".(int)$info['product_id']." ");
	}

	public function UpdateTierPrice($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product_discount SET price = '".$info['tier_prc']."' ,  quantity = ".$info['qty_tier_val']."	WHERE product_discount_id = ".(int)$info['product_discount_id']." ");
	}

	public function DeleteTierPrice($info)
	{
		$this->db->query("delete from ".DB_PREFIX."product_discount WHERE product_discount_id = ".(int)$info['product_discount_id']." ");
	}

	public function AddTierPrice($info)
	{
		$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,customer_group_id, quantity,price) VALUES ( ".(int)$info['prod_id']."   ,0 , ".$info['new_qty']." , ".$info['new_prc']." )");
		$last_id = $this->db->getLastId();
		$query = $this->db->query("select * from ".DB_PREFIX."product_discount where product_discount_id  = ".$last_id." ");
		return $query->rows;

	}

	
	public function getAllPauseProduct($vid) 
	{
		$query_res = $this->db->query("select * from ".DB_PREFIX."product as prod inner join ".DB_PREFIX."product_description pd on prod.product_id = pd.product_id where prod.seller_id= ".$vid." and pd.language_id = 1 and prod.product_status = 2 ");
		return $query_res->rows;
	}

	public function getAllFinalizeProduct($vid) 
	{
		$query = $this->db->query("select * from ".DB_PREFIX."product as prod inner join ".DB_PREFIX."product_description pd on prod.product_id = pd.product_id where prod.seller_id= ".$vid." and pd.language_id = 1 and prod.product_status = 3 ");
		return $query->rows;
	}

	public function ActiveProduct($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET product_status = '1' WHERE product_id = ".(int)$info['active_product']." ");
	}

	public function PauseProduct($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET product_status = '2' WHERE product_id = ".(int)$info['pause_product']." ");
	}

	public function FinalizeProduct($info)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "product SET product_status = '3' WHERE product_id = ".(int)$info['finalize_product']." ");
	}

	public function changePrice($info)
	{
		$query = $this->db->query("select product_id , price from ".DB_PREFIX."product where product_id = ".(int)$info['procuctid']." ");
		//print_r($query->rows[0]['price']);
		$percentage = $info['percentage'];
		$get_perc_price = $query->rows[0]['price'] * $percentage / 100;
		$get_perc_price = $get_perc_price + $query->rows[0]['price'];
		$this->db->query("UPDATE " . DB_PREFIX . "product SET price = '".$get_perc_price."' WHERE product_id = ".(int)$info['procuctid']." ");
		
		$product_discount = $this->db->query("select* from ".DB_PREFIX."product_discount where product_id = ".(int)$info['procuctid']." ");
		$product_discount = $product_discount->rows;
		//print_r($product_discount);
		foreach($product_discount as $updatePrice){

				$get_perc_price = $updatePrice['price'] * $percentage / 100;
				$get_perc_price = $get_perc_price + $updatePrice['price'];
				$this->db->query("UPDATE " . DB_PREFIX . "product_discount SET price = '".$get_perc_price."' WHERE product_discount_id = ".(int)$updatePrice['product_discount_id']." ");
		}
		
	}

	
		  
    public function sendemail($seller_id , $prodict_id , $name , $base) 
	{
		//echo $prodict_id;
		
		$query = $this->db->query("select customer_id from oc_vendordetail_lc where id = ".(int)$seller_id." ");
		$cusotomer_id = $query->rows[0]['customer_id'];
		
	
		
		$query = $this->db->query("select email from ".DB_PREFIX."customer where customer_id = ".(int)$cusotomer_id." ");
		$email = $query->rows[0]['email'];
		$date = date('Y-m-d H:i:s');
	
		//echo "UPDATE oc_product SET zero_stock_from = '2016-12-12 09:09:09', stock_email = 1231 WHERE product_id = ".(int)$prodict_id;
		
		$this->db->query("UPDATE oc_product SET zero_stock_from = '".$date."', stock_email = 12 WHERE product_id = ".(int)$prodict_id);
				
		$message = sprintf('warning, your publication');
		$message .= "<a href='".$base."index.php?route=Productdetails/productdtls&zamr=$40&xqtn=50&pxs=".$prodict_id."'> ".$name." </a>";
		$message .= 'has no more stock. Your publication will be pause in 1 day.';
		
	    //$email_to = $emailToSeller; //"bilalahmadue@gmail.com";//
        $email_to = $email;//"bilalahmadue@gmail.com";// $emailToSeller; //
        $mail = new Mail();
		
        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->parameter = $this->config->get('config_mail_parameter');
        $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
        $mail->smtp_username = $this->config->get('config_mail_smtp_username');
        $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
        $mail->smtp_port = $this->config->get('config_mail_smtp_port');
        $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
        $mail->setTo($email_to);
        $mail->setFrom($this->config->get('config_name'));
        $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
        
		$mail->setSubject("Customer QUestion");
        $mail->setHtml($message);
		//$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
        $mail->send();
    }


	public function zero_stock_pause($pid)
	{
		$this->db->query("UPDATE ".DB_PREFIX."product SET product_status = '2' , status = 0 WHERE product_id = ".(int)$pid." ");
	}


	public function stock_zero_update()
	{
		$query = $this->db->query("select * from ".DB_PREFIX."product where stock_email = 12 and quantity > 0 ");
		$res = $query->rows;
		//echo "ok";
		//echo "<pre>";
		//print_r($res);
		//exit;
		if($res)
		{
			foreach($res as $r)
			{
				$this->db->query("UPDATE " . DB_PREFIX . "product  SET  status = 1 , product_status = '1' , stock_email = 0 ,   zero_stock_from = '0000-00-00 00-00-00'  WHERE product_id = ".(int)$r['product_id']." ");
			}
			
		}
				
	}





	
}