<?php

class ControllerDashboardProduct extends Controller {

    private $error = array();

    public function index() {
		
		//echo  $cid = $this->customer->getId();
        $this->document->setTitle("Product Dashboard");
        $this->load->language('customuserdetail/addressdetail');
		$this->load->model('dashboard/product');

        if (!$this->customer->isLogged())
		{
            $this->response->redirect($this->url->link('account/register/login', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/product.tpl'))
		{
            $this->template = $this->config->get('config_template') . '/template/dashboard/product.tpl';
        } 
		else 
		{
            $this->template = 'default/template/dashboard/product.tpl';
        }

        if ($this->request->server['HTTPS']) 
		{
            $server = $this->config->get('config_ssl');
        } 
		else 
		{
            $server = $this->config->get('config_url');
        }
		
		$data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		$data['header1'] = $this->load->controller('common/header1');
        $data['base'] = $server;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) 
		{
		    $this->load->model('customuserdetail/addressbook');
            $get_customer_id_sees = $this->model_customuserdetail_addressbook->add_new_address($this->request->post, $cid);
            $this->response->redirect($this->url->link('customuserdetail/addressbook', 'param=10', 'SSL'));
        }
		
		$this->load->model('createlisting/category');
        $vendor_id = $this->model_createlisting_category->get_vendor_id();
		
        $data['product'] = $this->model_dashboard_product->getAllProduct($vendor_id->row['id']);
		$data['pause_product'] = $this->model_dashboard_product->getAllPauseProduct($vendor_id->row['id']);
		$data['finalize_product'] = $this->model_dashboard_product->getAllFinalizeProduct($vendor_id->row['id']);
		
        $this->response->setOutput($this->load->view('dashboard/product', $data));
    }
	
	public function updateProductType(){
		
		$this->load->model('dashboard/product');
        $vendor_id = $this->model_dashboard_product->UpdateProductType($this->request->post);
	}
	

	public function updateProductStock(){
		
		$this->load->model('dashboard/product');
        $vendor_id = $this->model_dashboard_product->UpdateProductStock($this->request->post);
	}

	public function updateSinglePrice(){
		
		$this->load->model('dashboard/product');
        $vendor_id = $this->model_dashboard_product->UpdateSinglePrice($this->request->post);
	}
	
	public function updateTierPrice(){
		
		$this->load->model('dashboard/product');
        $vendor_id = $this->model_dashboard_product->UpdateTierPrice($this->request->post);
	}



	public function deleteTierPrice(){
		
		$this->load->model('dashboard/product');
        $this->model_dashboard_product->DeleteTierPrice($this->request->post);
	}

	public function addTierPrice(){
		
		$this->load->model('dashboard/product');
        $vendor_id = $this->model_dashboard_product->AddTierPrice($this->request->post);
		echo json_encode($vendor_id);
	}

	public function pauseproduct(){
		
		$this->load->model('dashboard/product');
        $this->model_dashboard_product->PauseProduct($this->request->post);
	}
	
	
	public function finalizeproduct(){
		
		$this->load->model('dashboard/product');
        $this->model_dashboard_product->FinalizeProduct($this->request->post);
	}
	

	public function activeproduct(){
		
		$this->load->model('dashboard/product');
        $this->model_dashboard_product->ActiveProduct($this->request->post);
	}
	
	public function changeprice(){

		$this->load->model('dashboard/product');
        $this->model_dashboard_product->changePrice($this->request->post);		
	}


	public function getProductStockZero(){
  
        if ($this->request->server['HTTPS']) 
		{
            $server = $this->config->get('config_ssl');
        } 
		else 
		{
            $server = $this->config->get('config_url');
        }		
        $base = $server;
		
		$this->load->model('createlisting/category');
        $vendor_id = $this->model_createlisting_category->get_vendor_id();
		$vendor_id = (array)$vendor_id;
		$vendor_id = $vendor_id['rows'][0]['id'];
		//echo $vendor_id;
		
		$this->load->model('dashboard/product');
        $get_zero_stockItem = $this->model_dashboard_product->get_all_product_stock_zero($vendor_id);
		//echo "<pre>";
		//print_r($get_zero_stockItem);
		//exit;
		if(isset($get_zero_stockItem))
		{
			foreach($get_zero_stockItem as $zero_stock)
			{
				$check_email_status = $zero_stock['stock_email'];
				
				if( $check_email_status != 0 )
				{
					//echo "ok";
					echo $zero_stock['zero_stock_from'];
					//exit;
					$get_saleOff_Days = new DateTime($zero_stock['zero_stock_from']);
					$date_added_timestamp = $get_saleOff_Days->getTimestamp();

					$current_timestamp = time();
					$days_after_added_product_timestamp = $current_timestamp - $date_added_timestamp;
					$days_after_added_product = (($days_after_added_product_timestamp / 60) / 60 ) / 24;
					$remaining_days = round(1 - $days_after_added_product);
					$remaining_days = $remaining_days;
					//echo $remaining_days;
					
					 if($remaining_days <= 0 )
					 {
						$get_zero_stockItem = $this->model_dashboard_product->zero_stock_pause($zero_stock['product_id']);
					 }
				}
				else
				{
				  //$cid = $this->customer->getId();
				  $this->model_dashboard_product->sendemail($zero_stock['seller_id'] , $zero_stock['product_id'] , $zero_stock['name'] , $base);
				  //echo "Done";					
				}
			}
			
		}
		
		$get_zero_stockItem = $this->model_dashboard_product->stock_zero_update($vendor_id);
		//echo "<pre>";
		//$this->model_dashboard_product->sendemail();
	
		
		
	}



    private function validate() {
        if ((utf8_strlen(trim($this->request->post['new_address'])) < 3) || (utf8_strlen(trim($this->request->post['new_address'])) > 128)) {
            $this->error['new_address'] = $this->language->get('error_new_address');
        }
        if ((utf8_strlen(trim($this->request->post['address_doornumber'])) < 3) || (utf8_strlen(trim($this->request->post['address_doornumber'])) > 128)) {
            $this->error['address_doornumber'] = $this->language->get('error_door_number');
        }
        return !$this->error;
    }

}

?>