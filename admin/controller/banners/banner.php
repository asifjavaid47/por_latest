<?php  
Class ControllerBannersBanner extends Controller
{  
    public function banner_list()
	{
		// define template file
        if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/banner_list.tpl'))
		{
            $this->template = $this->config->get('config_template') . '/template/dashboard/banner_list.tpl';
        }
		else 
		{
			$this->template = 'default/template/dashboard/banner_list.tpl';
		}
		
        if($this->request->server['HTTPS'])
		{
			$server = $this->config->get('config_ssl');
        }
		else
		{
			$server = $this->config->get('config_url');
        }
		
		//GEt all banners data
		$all_banners = $this->db->query("SELECT * from oc_banner_lc");
		$data['all_banners'] = $all_banners->rows;
		
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		
		$this->response->setOutput($this->load->view('dashboard/banner_list', $data));
	}
	
	public function add_or_edit_new_banner()
	{
		$banner_html = $this->request->post['banner_html'];
		$banner_title = $this->request->post['banner_title'];
		$banner_description = $this->request->post['banner_description'];
		$the_banner_page = $this->request->post['banner_page_place'];
		$assign_banner_id = $this->request->post['assign_banner_id'];
		$new_or_modify_banners = $this->request->post['new_or_modify_banners'];
		$banner_global_id = $this->request->post['banner_global_id'];
		
		if($assign_banner_id=='banner1' OR $assign_banner_id=='banner2')
		{
			$already_displaying_banner = $this->db->query("select banner_id from oc_banner_lc where banner_assigned_id= '".$assign_banner_id."'");
			for($i=0; $i<$already_displaying_banner->num_rows; $i++)
			{
				if($this->db->query("UPDATE oc_banner_lc SET banner_assigned_id = 'no id' where banner_id = ".$already_displaying_banner->rows[$i]['banner_id']))
				{
					echo 'updated';
				}
			}
		}
		if($new_or_modify_banners == 1)
		{
			if($this->db->query("INSERT INTO oc_banner_lc (banner_title, banner_description, banner_zone_page, banner_html, banner_assigned_id) VALUES ('".$banner_title."', '".$banner_description."', '".$the_banner_page."', '".base64_encode($banner_html)."', '".$assign_banner_id."')"))
			{
				echo 'inserted successfully';
			}
		}
		else
		{
			if($this->db->query("UPDATE oc_banner_lc SET banner_title = '".$banner_title."', banner_description = '".$banner_description."', banner_zone_page = '".$the_banner_page."', banner_assigned_id = '".$assign_banner_id."', banner_html = '".base64_encode($banner_html)."' Where banner_id = ".$banner_global_id))
			{
				echo 'updated successfully';
			}
		}
	}
	
	public function get_one_banner_by_id()
	{
		$this_banner_id = $this->request->post['this_banner_id'];
		$this_banner = $this->db->query("SELECT * from oc_banner_lc where banner_id = ".$this_banner_id);
		$banner_data = array();
		$banner_data['all_data'] = $this_banner->row;
		$banner_data['banner_html'] = html_entity_decode(base64_decode($this_banner->row['banner_html']));
		echo json_encode($banner_data);
	}
	
	public function clear_banner_clicks()
	{
		$banner_id = $this->request->post['banner_id'];
		if($this->db->query("UPDATE oc_banner_lc SET banner_clicks = 0 where banner_id  = ".$banner_id))
		{
			echo 'updated';
		}
	}
	
	public function clear_banner_prints()
	{
		$banner_id = $this->request->post['banner_id'];
		if($this->db->query("UPDATE oc_banner_lc SET banner_prints = 0 where banner_id  = ".$banner_id))
		{
			echo 'updated';
		}
	}
}
?>