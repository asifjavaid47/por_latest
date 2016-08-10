<?php
class ControllerProductUpdateListingType extends Controller
{
	public function index()
	{
		$this->load->language('product/category');
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');		
		
		$current_timestamp = time();
		$one_day_before_timestamp = time() + (3 * 24 * 60 * 60);
		
		$query = $this->db->query("UPDATE oc_product SET listing_type = 2 where listing_type = 3 AND UNIX_TIMESTAMP(date_added) < ".$one_day_before_timestamp);
	}
}