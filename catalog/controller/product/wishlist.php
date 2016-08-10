<?php
class Controllerproductwishlist extends Controller {

    private $error = array();

    public function index()
	{
		$this->document->setTitle("xcantidad.com - Conviene más");
		
		$this->load->model('Homepage/Home');
		$this->load->model('tool/image');
		
		// define template file
        if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/wishlist.tpl'))
		{
			$this->template = $this->config->get('config_template') . '/template/product/wishlist.tpl';
        }
		else
		{
            $this->template = 'default/template/product/wishlist.tpl';
        }
		
		if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        } 
        $data['base'] = $server;
        
		
		// $product_all_details = $this->model_Homepage_Home->get_wishlist_products($customer_id);
        // print_r($product_all_details);
		$data['title'] = $this->document->getTitle();
        //$data['base'] = $server;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		
        $data['action'] = $this->url->link('product/wishlist', '', true);

        $this->response->setOutput($this->load->view('product/wishlist', $data));
    }
	
	public function get_wishlist_products()
	{
		$this->load->model('Homepage/Home');
		$this->load->model('tool/image');
		$product_all_details = $this->model_Homepage_Home->get_wishlist_products();
		if(isset($product_all_details['products_details']))
		{
			$number_of_products = sizeof($product_all_details['products_details']);
			for($i=0; $i<$number_of_products; $i++)
			{
				$this_image = $product_all_details['products_details'][$i]['image'];
				$product_all_details['product_images'][$i] = $this->model_tool_image->resize($this_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
			}
			echo json_encode($product_all_details);
		}
		else
		{
			echo 0;
		}
		
		
	}
	
	public function add_to_wishlist()
	{
		$product_id = $this->request->post['product_id'];
		$customer_id = $this->customer->getId();
		if($this->db->query("insert into oc_customer_wishlist (customer_id, product_id, date_added) VALUES ($customer_id, $product_id, NOW() )"))
		{
			echo 'inserted into wishlist';
		}
		else
		{
			echo 'error inserting into wishlist';
		}
	}
	
	public function remove_from_wishlist()
	{
		$product_id = $this->request->post['product_id'];
		$customer_id = $this->customer->getId();
		if($this->db->query("delete from oc_customer_wishlist where customer_id = ".$customer_id." AND product_id = ".$product_id))
		{
			echo 'deleted wishlist';
		}
		else
		{
			echo 'error deleting wishlist';
		}
	}
}

?>