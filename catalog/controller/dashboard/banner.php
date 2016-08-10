<?php  
Class ControllerDashboardBanner extends Controller
{
	public function change_banner_clicks()
	{
		$banner_id = $this->request->post['banner_id'];
		$this_banner = $this->db->query("SELECT banner_clicks from oc_banner_lc where banner_id  = ".$banner_id);
		$banner_clicks = $this_banner->row['banner_clicks'] + 1;
		if($this->db->query("UPDATE oc_banner_lc SET banner_clicks = " .$banner_clicks. " where banner_id  = ".$banner_id))
		{
			echo 'updated';
		}
	}
	
	public function change_banner_prints()
	{
		$current_banners = $this->db->query("SELECT banner_id, banner_prints from oc_banner_lc where banner_assigned_id  = 'banner1' OR banner_assigned_id  = 'banner2' OR banner_assigned_id  = 'carosal_banner' ");
		for($i=0; $i<$current_banners->num_rows; $i++)
		{
			$current_banner_print_counter = $current_banners->rows[$i]['banner_prints'] + 1;
			$current_banner_id = $current_banners->rows[$i]['banner_id'];
			if($this->db->query("UPDATE oc_banner_lc SET banner_prints = " .$current_banner_print_counter. " where banner_id  = ".$current_banner_id))
			{
				echo 'updated';
			}
		}
		print_r($current_banners);
	}
}
?>