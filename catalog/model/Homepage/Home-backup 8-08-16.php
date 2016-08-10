<?php

class ModelHomepageHome extends Model
{
	public function get_sale_off_products()
	{
		$get_product_ids = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product where listing_type=3");
        $product_storage_index=0;
		$products_data = array();
		foreach($get_product_ids->rows as $row)
		{
			$product_id = $row['product_id'];
			
			//data from product table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product where product_id= ".$product_id);
			$products_data['products_details'][$product_storage_index] = $product_details->row;
			
			//data from product discounts table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount where product_id= ".$product_id." order by price DESC");
			$products_data['products_discounts'][$product_storage_index] = $product_details->rows;
			
			//data from product description table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description where product_id= ".$product_id);
			$products_data['products_description'][$product_storage_index] = $product_details->rows;
			
			$product_storage_index++;
		}
		return $products_data;
	}
	
	public function get_recommended_products()
	{
		$my_ip = $_SERVER['REMOTE_ADDR'];
		$get_product_ids = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product_to_category where category_id IN (SELECT category_id FROM " . DB_PREFIX . "userhistory_lc where ip_address = '$my_ip') LIMIT 7");
        $product_storage_index=0;
        $products_data = [];
		foreach($get_product_ids->rows as $row)
		{
			$product_id = $row['product_id'];
			
			////////data from product table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product where product_id= ".$product_id);
			$products_data['products_details'][$product_storage_index] = $product_details->row;
			
			///////////data from product discounts table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount where product_id= ".$product_id." order by price DESC");
			$products_data['products_discounts'][$product_storage_index] = $product_details->rows;
			
			////////////data from product description table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description where product_id= ".$product_id);
			$products_data['products_description'][$product_storage_index] = $product_details->rows;
			
			$product_storage_index++;
		}
		return $products_data;
	}
	
	public function get_latest_products()
	{
		$get_product_ids = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product order by product_id DESC, listing_type DESC limit 7");
        $product_storage_index=0;
		foreach($get_product_ids->rows as $row)
		{
			$product_id = $row['product_id'];
			
			//data from product table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product where product_id= ".$product_id);
			$products_data['products_details'][$product_storage_index] = $product_details->row;
			
			//data from product discounts table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount where product_id= ".$product_id." order by price DESC");
			$products_data['products_discounts'][$product_storage_index] = $product_details->rows;
			
			//data from product description table
			$product_details = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description where product_id= ".$product_id);
			$products_data['products_description'][$product_storage_index] = $product_details->rows;
			
			$product_storage_index++;
		}
		return $products_data;
	}
}
