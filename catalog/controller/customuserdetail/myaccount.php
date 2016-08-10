<?php  
class ControllerCustomuserdetailMyaccount extends Controller {
	
	private $error = array();
	
  public function index() {
    // set title of the page
    $this->document->setTitle("Myaccount");
	
	$this->load->language('customuserdetail/myaccount');

	if (!$this->customer->isLogged()) {     
			   $this->response->redirect($this->url->link('account/register', '', 'SSL'));
	}
	
	 
    // define template file
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/customuserdetail/myaccount.tpl')) {
      $this->template = $this->config->get('config_template') . '/template/customuserdetail/myaccount.tpl';
    } else {
      $this->template = 'default/template/customuserdetail/myaccount.tpl';
    }
	$data['footer'] = $this->load->controller('common/footer');
	$data['header'] = $this->load->controller('common/header');
     $data['my_custom_text'] = $this->load->controller('this is my account');
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
  
  
     $data['my_account'] = $this->language->get('my_account');
     $data['edit_account'] = $this->language->get('edit_account');
     $data['password'] = $this->language->get('password');
     $data['address_book'] = $this->language->get('address_book');
     $data['my_account_details'] = $this->language->get('my_account_details');
 $this->response->setOutput($this->load->view('customuserdetail/myaccount', $data));

  }
}		  
?>