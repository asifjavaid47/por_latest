<?php
class Controllerproductsaleoffs extends Controller {

    private $error = array();

    public function index()
	{
		$this->document->setTitle("xcantidad.com - Conviene más");
		// define template file
        if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/saleoffs.tpl'))
		{
			$this->template = $this->config->get('config_template') . '/template/product/saleoffs.tpl';
        }
		else
		{
            $this->template = 'default/template/product/saleoffs.tpl';
        }

        $data['title'] = $this->document->getTitle();
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $data['action'] = $this->url->link('product/saleoffs', '', true);

        $this->response->setOutput($this->load->view('product/saleoffs', $data));
    }
	
	public function get_sale_off_products()
	{
		$this->load->model('Homepage/Home');
		$this->load->model('tool/image');
		$product_all_details = $this->model_Homepage_Home->get_sale_off_products();
		$number_of_products = sizeof($product_all_details['products_details']);
		for($i=0; $i<$number_of_products; $i++)
		{
			$this_image = $product_all_details['products_details'][$i]['image'];
			$product_all_details['product_images'][$i] = $this->model_tool_image->resize($this_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
		}
		echo json_encode($product_all_details);
	}
}
?>