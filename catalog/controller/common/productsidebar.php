<?php
class ControllerCommonProductsidebar extends Controller {
	public function index() {

		$this->load->model('catalog/product');
		$this->load->model('tool/image');
        $this->load->model('catalog/productsidebar');
        
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;
        
        /**********Products Sidebar*************/
        /**********sidebar locations*************/
        $sidebarLocations = $this->model_catalog_productsidebar->getLocations();
        foreach($sidebarLocations as $location){
            $data['locations'][] = array(
				'location'  => $location['location'],
				'locProducts'  => $location['locProducts']
            );
        }
        /*************************/
        
        /***********Best seller Products -- starts***********/
        $data['bs_products'] = array();
        $bs_results = $this->model_catalog_product->getBestSellerProducts(3);

        if ($bs_results) {
            foreach ($bs_results as $bs_result) {
                if ($bs_result['image']) {
                    $bs_image = $this->model_tool_image->resize($bs_result['image'], '', ''); /*width and height are empty*/
                } else {
                    $bs_image = $this->model_tool_image->resize('placeholder.png', '', '');
                }

                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    $bs_price = $this->currency->format($this->tax->calculate($bs_result['price'], $bs_result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $bs_price = false;
                }

                if ((float)$bs_result['special']) {
                    $bs_special = $this->currency->format($this->tax->calculate($bs_result['special'], $bs_result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $bs_special = false;
                }

                if ($this->config->get('config_tax')) {
                    $bs_tax = $this->currency->format((float)$bs_result['special'] ? $bs_result['special'] : $bs_result['price'], $this->session->data['currency']);
                } else {
                    $bs_tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $bs_rating = $bs_result['rating'];
                } else {
                    $bs_rating = false;
                }

                $data['bs_products'][] = array(
                    'product_id'  => $bs_result['product_id'],
                    'thumb'       => $bs_image,
                    'name'        => $bs_result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($bs_result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                    'price'       => $bs_price,
                    'special'     => $bs_special,
                    'tax'         => $bs_tax,
                    'rating'      => $bs_rating,
                    'href'        => $this->url->link('product/product', 'product_id=' . $bs_result['product_id'])
                );
            }
        }
        /***********Best seller Products -- ends***********/
        /***********Products sidebar -- ends***********/

		return $this->load->view('common/productsidebar', $data);
	}
}
