<?php

class ControllerCommonHome extends Controller {

    public function index() {
        // set title of the page
        //$this->document->setTitle("My Custom Page");
        // define template file
          $this->load->model('catalog/category');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/homepage/home.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/homepage/home.tpl';
        } else {
            $this->template = 'default/template/homepage/home.tpl';
        }
        //asif code start
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        } 
        $data['base'] = $server;
        $ip_address = $_SERVER['REMOTE_ADDR'];
        
		//get the banners defined for the homepage
		$this_banner = $this->db->query("SELECT * from oc_banner_lc");
		$data['homepgae_banners'] = $this_banner->rows;
		
        
        $data['most_categories'] = $this->model_catalog_category->most_visted_categories($ip_address);
        $data['popular_categories'] = $this->model_catalog_category->sller_products();
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        // set data to the variable
        //$this->data['my_custom_text'] = "This is my custom page.";
        $this->response->setOutput($this->load->view('homepage/home', $data));
    }

    public function get_sale_off_products() {
        $this->load->model('Homepage/Home');
        $this->load->model('tool/image');
		$product_all_details = array();
        $product_all_details = $this->model_Homepage_Home->get_sale_off_products();
        if(!empty($product_all_details))
		{
			$number_of_products = sizeof($product_all_details['products_details']);
			for ($i = 0; $i < $number_of_products; $i++)
			{
				if(isset($product_all_details['products_details'][$i]['image']))
				{
					$this_image = $product_all_details['products_details'][$i]['image'];
					$product_all_details['product_images'][$i] = $this->model_tool_image->resize($this_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}
				else
				{
					$product_all_details['product_images'][$i] = '';
				}
			}
		}
		
        echo json_encode($product_all_details);
    }

    public function get_recommended_products() {
        $this->load->model('Homepage/Home');
        $this->load->model('tool/image');
        $product_all_details = $this->model_Homepage_Home->get_recommended_products();
        if($product_all_details == null || $product_all_details == []){
            json_encode([]);
            return;
        }
        $number_of_products = sizeof($product_all_details['products_details']);
        for ($i = 0; $i < $number_of_products; $i++)
		{
			if(isset($product_all_details['products_details'][$i]['image']))
			{
				$this_image = $product_all_details['products_details'][$i]['image'];
				$product_all_details['product_images'][$i] = $this->model_tool_image->resize($this_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));				
			}
			else
			{
				$product_all_details['product_images'][$i] = '';
			}
        }
        echo json_encode($product_all_details);
    }

    public function get_latest_products() {
        $this->load->model('Homepage/Home');
        $this->load->model('tool/image');
        $product_all_details = $this->model_Homepage_Home->get_latest_products();
        $number_of_products = sizeof($product_all_details['products_details']);
        for ($i = 0; $i < $number_of_products; $i++)
		{
			if(isset($product_all_details['products_details'][$i]['image']))
			{
				$this_image = $product_all_details['products_details'][$i]['image'];
				$product_all_details['product_images'][$i] = $this->model_tool_image->resize($this_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
			}
			else
			{
				$product_all_details['product_images'][$i] = '';
			}
		}
        echo json_encode($product_all_details);
    }

}
