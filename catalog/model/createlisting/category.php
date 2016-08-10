<?php

class ModelCreatelistingCategory extends Model
{
	
	public function check_vendor($ic)
	{
	}
	
	public function get_category()
	{
		$query = $this->db->query("SELECT a.* , b.*
									FROM oc_category as a 
									JOIN  oc_category_description as b
									ON 
									a.category_id=b.category_id
									where a.parent_id = 0 and b.language_id  = 1
									order by b.category_id asc
		");
		
		return $query;
	}
	
	public function check_sub_cat($id)
	{
		
		$query = $this->db->query("SELECT a.* , b.*
										FROM oc_category as a 
										JOIN  oc_category_description as b
										ON 
										a.category_id=b.category_id
										where a.parent_id = ".$id['id']." and b.language_id  = 1
										order by b.category_id asc
			");
		
		return $query;
		
	}
	
	public function check_sec_sub_cat($id)
	{
		
		$query = $this->db->query("SELECT a.* , b.*
										FROM oc_category as a 
										JOIN  oc_category_description as b
										ON 
										a.category_id=b.category_id
										where a.parent_id = ".$id['id']." and b.language_id  = 1
										order by b.category_id asc
			");
		
		return $query;
	}
	
	public function check_third_sub_cat($id)
	{
		$query = $this->db->query("SELECT a.* , b.*
										FROM oc_category as a 
										JOIN  oc_category_description as b
										ON 
										a.category_id=b.category_id
										where a.parent_id = ".$id['id']." and b.language_id  = 1
										order by b.category_id asc
			");
		
		return $query;
	}
	
	
	public function check_four_sub_cat($id)
	{
		
		$query = $this->db->query("SELECT a.* , b.*
										FROM oc_category as a 
										JOIN  oc_category_description as b
										ON 
										a.category_id=b.category_id
										where a.parent_id = ".$id['id']." and b.language_id  = 1
										order by b.category_id asc
			");
		
		return $query;
	}
	
	
	public function check_sku($sku)
	{
		$query = $this->db->query("SELECT sku FROM ".DB_PREFIX."product where sku = '".$sku['product_sku']."'");
		
		return $query;
	}
	
	
	public function get_vendor_id()
	{
		
		$cid = $this->customer->getId();
		$query = $this->db->query("SELECT id FROM ".DB_PREFIX."vendordetail_lc WHERE  customer_id= '".$cid."'");
		
		return $query;
		
	}
	
	
	public function add_vendor_product($vendor_id, $info)
	{
		
		if($info['product_sku'] != ''){
			$query = $this->db->query("SELECT sku FROM ".DB_PREFIX."product where sku = '".$info['product_sku']."'");
			if($query->num_rows > 0){
				if($info['flag_product_id'] != 0){
					$skunumber = $info['product_sku'];
				} else{
					do{
						$random_sku = mt_rand(111111111, 999999999);
						$query1 = $this->db->query("SELECT sku FROM ".DB_PREFIX."product where sku = '".$random_sku."'");
						$skunumber = $random_sku;
					} while($query1->num_rows > 0);
				}
			} else{
				$skunumber = $info['product_sku'];
			}
		} else{
			do{
				$random_sku = mt_rand(111111111, 999999999);
				$query1 = $this->db->query("SELECT sku FROM ".DB_PREFIX."product where sku = '".$random_sku."'");
				$skunumber = $random_sku;
			} while($query1->num_rows > 0);
		}
		$product_main_image = $info['prod_main_img']? $info['prod_main_img']:'cache/placeholder-228x228.png';
		$price_format = number_format($info['price_one'], 4, '.', '');
		
		$stock_status = 7;
		$prod_status = 1;
		$language_id = 1;
		
		if($info['flag_product_id']){
			
			$this->db->query("UPDATE ".DB_PREFIX."address_lc SET locationid = 0   where  customer_id =  ".(int)$info['customer_id']." and  locationid = 1");
			$this->db->query("UPDATE ".DB_PREFIX."address_lc SET locationid = 1   where  customer_id =  ".(int)$info['customer_id']." and id =  ".(int)$info['location_id']."  ");
			
			
			$this->db->query("UPDATE ".DB_PREFIX."product SET seller_id = ".(int)$vendor_id." , model = '".$this->db->escape($info['prod_title'])."'  , sku =  '".$this->db->escape($skunumber)."' , product_condition = '".$this->db->escape($info['prod_condition'])."' , price = ".$this->db->escape($price_format).", image = '".$this->db->escape($product_main_image)."' , stock_status_id = ".$stock_status." , quantity =  ".$this->db->escape($info['avail_stock'])." , minimum =  ".$this->db->escape($info['minimum_buy'])." , status = ".$prod_status." , date_modified = '".$this->db->escape(date('Y-m-d H:i:s'))."' , address_id = ".$this->db->escape($info['location_id'])."  where product_id = ".$info['flag_product_id']." ");
			$this->db->query("UPDATE ".DB_PREFIX."product_description SET  name = '".$this->db->escape($info['prod_title'])."'  , description =  '".$this->db->escape(htmlspecialchars($info['prod_desc']))."' , tag = '".$this->db->escape(isset($info['prod_tags'])? $this->db->escape($info['prod_tags']):'')."'  where product_id = ".$info['flag_product_id']." ");
			
			$this->db->query("delete from ".DB_PREFIX."product_discount where product_id = ".$info['flag_product_id']." ");
			
			
			for($i = 0; $i < 4; $i++){
				$priority = 1;
				if($i == 0){
					if($info['qty_two'] != '' && $info['price_two'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$info['flag_product_id'].", ".$this->db->escape($info['qty_two']).", ".$priority.", ".$this->db->escape($info['price_two'])." )");
					}
				}
				
				if($i == 1){
					if($info['qty_three'] != '' && $info['price_three'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$info['flag_product_id'].", ".$this->db->escape($info['qty_three']).", ".$priority.", ".$this->db->escape($info['price_three'])." )");
					}
				}
				
				if($i == 2){
					if($info['qty_four'] != '' && $info['price_four'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$info['flag_product_id'].", ".$this->db->escape($info['qty_four']).", ".$priority.", ".$this->db->escape($info['price_four'])." )");
					}
				}
				if($i == 3){
					if($info['qty_five'] != '' && $info['price_five'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$info['flag_product_id'].", ".$this->db->escape($info['qty_five']).", ".$priority.", ".$this->db->escape($info['price_five'])." )");
					}
				}
			}
			$this->db->query("delete from ".DB_PREFIX."product_image where product_id = ".(int)$info['flag_product_id']." ");
			
			if(isset($info['store_product_image'])){
				foreach($info['store_product_image'] as $val){
					$this->db->query("INSERT INTO ".DB_PREFIX."product_image (product_id,image) VALUES (".(int)$info['flag_product_id'].", '".$this->db->escape($val)."' )");
				}
			}
			
			$this->db->query("delete from payment_method_and_discount_lc where product_id = ".(int)$info['flag_product_id']." ");
			
			$cash_payment = $info['cash_checkbox_value']? $info['cash_checkbox_value']:'';
			$wire_payment = $info['wire_checkbox_value']? $info['wire_checkbox_value']:'';
			$credit_payment = $info['credit_checkbox_value']? $info['credit_checkbox_value']:'';
			
			$cash_discount = $info['cash_discount']? $info['cash_discount']:'';
			$wire_discount = $info['wire_discount']? $info['wire_discount']:'';
			$credit_discount = $info['credit_card_discount']? $info['credit_card_discount']:'';
			
			$this->db->query("INSERT INTO payment_method_and_discount_lc (cash_payment,wire_payment,credit_card_payment,cash_discount,wire_discount , credit_card_discount , product_id , vendor_id ) VALUES ('".$this->db->escape($cash_payment)."', '".$this->db->escape($wire_payment)."', '".$this->db->escape($credit_payment)."' , '".$this->db->escape($cash_discount)."'   , '".$this->db->escape($wire_discount)."' , '".$this->db->escape($credit_discount)."' , ".(int)$info['flag_product_id']."   , ".(int)$vendor_id." )");
			
			
			$this->db->query("delete from shipping_method_lc where product_id = ".(int)$info['flag_product_id']." ");
			
			$new_vendor_shipping = $info['new_vendor_shipping']? $info['new_vendor_shipping']:'';
			$new_buyer_shipping = $info['new_buyer_shipping']? $info['new_buyer_shipping']:'';
			$new_xenvios_shipping = $info['new_xenvios_shipping']? $info['new_xenvios_shipping']:'';
			
			$zone_delivery = $info['zone_delivery']? $info['zone_delivery']:'';
			$porcantidad_pay_shipping_checkbox = $info['porcantidad_pay_shipping_checkbox']? $info['porcantidad_pay_shipping_checkbox']:'';
			
			$input_shipping_width = $info['input_shipping_width']? $info['input_shipping_width']:'';
			$option_shipping_width = $info['option_shipping_width']? $info['option_shipping_width']:'';
			$input_shipping_height = $info['input_shipping_height']? $info['input_shipping_height']:'';
			$option_shipping_height = $info['option_shipping_height']? $info['option_shipping_height']:'';
			$input_shipping_depth = $info['input_shipping_depth']? $info['input_shipping_depth']:'';
			$option_shipping_depth = $info['option_shipping_depth']? $info['option_shipping_depth']:'';
			$input_shipping_weight = $info['input_shipping_weight']? $info['input_shipping_weight']:'';
			$option_shipping_weight = $info['option_shipping_weight']? $info['option_shipping_weight']:'';
			$this->db->query("INSERT INTO shipping_method_lc (vendor , buyer , xenvios , zone_delivery , width , height , depth , weight , width_attr , height_attr , depth_attr , weight_attr ,	porcantidad_vendor_shipping , product_id , vendor_id) VALUES ('".$this->db->escape($new_vendor_shipping)."', '".$this->db->escape($new_buyer_shipping)."', '".$this->db->escape($new_xenvios_shipping)."', '".$this->db->escape($zone_delivery)."'  , '".$this->db->escape($input_shipping_width)."', '".$this->db->escape($input_shipping_height)."' , '".$this->db->escape($input_shipping_depth)."'   , '".$this->db->escape($input_shipping_weight)."'      , '".$this->db->escape($option_shipping_width)."'    , '".$this->db->escape($option_shipping_height)."'   , '".$this->db->escape($option_shipping_depth)."'   , '".$this->db->escape($option_shipping_weight)."' , '".$this->db->escape($porcantidad_pay_shipping_checkbox)."' ,  ".(int)$info['flag_product_id']."   , ".(int)$vendor_id." )");
			$this->db->query("UPDATE ".DB_PREFIX."product_to_category SET   category_id = ".(int)$info['cat_id']."  where product_id = ".(int)$info['flag_product_id']." ");
			
			echo $info['flag_product_id'];
			
		} else{
			
			$this->db->query("UPDATE ".DB_PREFIX."address_lc SET locationid = 0   where  customer_id =  ".(int)$info['customer_id']." and  locationid = 1");
			$this->db->query("UPDATE ".DB_PREFIX."address_lc SET locationid = 1   where  customer_id =  ".(int)$info['customer_id']." and id =  ".(int)$info['location_id']."  ");
			
			$this->db->query("INSERT INTO ".DB_PREFIX."product (seller_id,model,sku,product_condition,price,image,stock_status_id,quantity, date_available, minimum, status, date_added, approve , listing_type , address_id) VALUES (".(int)$vendor_id." ,  '".$this->db->escape($info['prod_title'])."' , '".$this->db->escape($skunumber)."' , '".$this->db->escape($info['prod_condition'])."', ".$this->db->escape($price_format).", '".$this->db->escape($product_main_image)."', ".$stock_status.",".$this->db->escape($info['avail_stock']).", '".$this->db->escape(date('Y-m-d'))."' , ".$this->db->escape($info['minimum_buy'])." , ".$prod_status." , '".$this->db->escape(date('Y-m-d H:i:s'))."' ,".$prod_status." , '1'  ,  address_id = ".$this->db->escape($info['location_id']).")");
			$last_id = $this->db->getLastId();
			
			$this->db->query("INSERT INTO ".DB_PREFIX."product_description (product_id,language_id,name,description,tag ) VALUES (".(int)$last_id.",".$this->db->escape($language_id).", '".$this->db->escape($info['prod_title'])."', '".$this->db->escape(htmlspecialchars($info['prod_desc']))."' , '".$this->db->escape(isset($info['prod_tags'])? $this->db->escape($info['prod_tags']):'')."'    )");
			
			
			for($i = 0; $i < 4; $i++){
				$priority = 1;
				if($i == 0){
					if($info['qty_two'] != '' && $info['price_two'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$last_id.", ".$this->db->escape($info['qty_two']).", ".$priority.", ".$this->db->escape($info['price_two'])." )");
					}
				}
				
				if($i == 1){
					if($info['qty_three'] != '' && $info['price_three'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$last_id.", ".$this->db->escape($info['qty_three']).", ".$priority.", ".$this->db->escape($info['price_three'])." )");
					}
				}
				
				if($i == 2){
					if($info['qty_four'] != '' && $info['price_four'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$last_id.", ".$this->db->escape($info['qty_four']).", ".$priority.", ".$this->db->escape($info['price_four'])." )");
					}
				}
				if($i == 3){
					if($info['qty_five'] != '' && $info['price_five'] != ''){
						$this->db->query("INSERT INTO ".DB_PREFIX."product_discount (product_id,quantity,priority,price) VALUES (".(int)$last_id.", ".$this->db->escape($info['qty_five']).", ".$priority.", ".$this->db->escape($info['price_five'])." )");
					}
				}
			}
			
			
			if(isset($info['store_product_image'])){
				foreach($info['store_product_image'] as $val){
					$this->db->query("INSERT INTO ".DB_PREFIX."product_image (product_id,image) VALUES (".(int)$last_id.", '".$this->db->escape($val)."' )");
				}
			}
			
			$cash_payment = $info['cash_checkbox_value']? $info['cash_checkbox_value']:'';
			$wire_payment = $info['wire_checkbox_value']? $info['wire_checkbox_value']:'';
			$credit_payment = $info['credit_checkbox_value']? $info['credit_checkbox_value']:'';
			
			
			
			$cash_discount = $info['cash_discount']? $info['cash_discount']:'';
			$wire_discount = $info['wire_discount']? $info['wire_discount']:'';
			$credit_discount = $info['credit_card_discount']? $info['credit_card_discount']:'';
			
			$query_to_execute = "INSERT INTO payment_method_and_discount_lc (cash_payment,wire_payment,credit_card_payment,cash_discount,wire_discount , credit_card_discount , product_id , vendor_id) VALUES ('".$this->db->escape($cash_payment)."', '".$this->db->escape($wire_payment)."', '".$this->db->escape($credit_payment)."' , '".$this->db->escape($cash_discount)."'   , '".$this->db->escape($wire_discount)."' , '".$this->db->escape($credit_discount)."' , ".(int)$last_id."   , ".(int)$vendor_id.")";
			
			 
			
			$new_vendor_shipping = $info['new_vendor_shipping']? $info['new_vendor_shipping']:'';
			$new_buyer_shipping = $info['new_buyer_shipping']? $info['new_buyer_shipping']:'';
			$new_xenvios_shipping = $info['new_xenvios_shipping']? $info['new_xenvios_shipping']:'';
			
			$zone_delivery = $info['zone_delivery']? $info['zone_delivery']:'';
			$porcantidad_pay_shipping_checkbox = $info['porcantidad_pay_shipping_checkbox']? $info['porcantidad_pay_shipping_checkbox']:'';
			
			$input_shipping_width = $info['input_shipping_width']? $info['input_shipping_width']:'';
			$option_shipping_width = $info['option_shipping_width']? $info['option_shipping_width']:'';
			$input_shipping_height = $info['input_shipping_height']? $info['input_shipping_height']:'';
			$option_shipping_height = $info['option_shipping_height']? $info['option_shipping_height']:'';
			$input_shipping_depth = $info['input_shipping_depth']? $info['input_shipping_depth']:'';
			$option_shipping_depth = $info['option_shipping_depth']? $info['option_shipping_depth']:'';
			$input_shipping_weight = $info['input_shipping_weight']? $info['input_shipping_weight']:'';
			$option_shipping_weight = $info['option_shipping_weight']? $info['option_shipping_weight']:'';
			$product_warranty = $info['product_warranty'];
			
			
			$this->db->query("INSERT INTO shipping_method_lc (vendor,buyer,xenvios,zone_delivery , width , height , depth , weight , width_attr , height_attr , depth_attr , weight_attr ,	porcantidad_vendor_shipping , product_id , vendor_id, product_warranty) VALUES ('".$this->db->escape($new_vendor_shipping)."', '".$this->db->escape($new_buyer_shipping)."', '".$this->db->escape($new_xenvios_shipping)."', '".$this->db->escape($zone_delivery)."'  , '".$this->db->escape($input_shipping_width)."', '".$this->db->escape($input_shipping_height)."' , '".$this->db->escape($input_shipping_depth)."'   , '".$this->db->escape($input_shipping_weight)."'      , '".$this->db->escape($option_shipping_width)."'    , '".$this->db->escape($option_shipping_height)."'   , '".$this->db->escape($option_shipping_depth)."'   , '".$this->db->escape($option_shipping_weight)."' , '".$this->db->escape($porcantidad_pay_shipping_checkbox)."' ,  ".(int)$last_id."   , ".(int)$vendor_id.", '".$this->db->escape($product_warranty)."' )");
			$this->db->query("INSERT INTO ".DB_PREFIX."product_to_category (product_id,category_id) VALUES ( ".(int)$last_id."   , ".(int)$info['cat_id']." )");
			
			$this->db->query("INSERT INTO ".DB_PREFIX."product_to_store (product_id,store_id) VALUES ( ".(int)$last_id."   ,0 )");
			
			/*if(isset($info['attributes'])){
				foreach($info['attributes'] as $val){
					$this->db->query("INSERT INTO oc_product_attribute (`product_id`,`attribute_id`,`language_id`) VALUES (".(int)$last_id.", ".$val.", 1)");
				}
			}*/
			
			
			echo $last_id;
		}
	}
	
	public function product_listing_id($post)
	{
		$this->db->query("UPDATE ".DB_PREFIX."product SET listing_type = '".$post['listing_type_id']."' WHERE product_id = '".$post['prod_id']."'");
	}
	
	public function getAllAddress($cid)
	{
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc where customer_id = '".$cid."'");
		
		return $query->rows;
	}
	
	public function getAddNewAddress($lastid)
	{
		
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."address_lc where id = ".$lastid." ");
		
		return $query->rows;
	}
	
}