<?php  
class ControllerCustomuserdetailthankyou extends Controller {
	
	private $error = array();
	
  public function index() {
       // set title of the page
        $this->document->setTitle("Thanks Page");
	
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		// define template file
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/customuserdetail/editaccount.tpl')) {
		  $this->template = $this->config->get('config_template') . '/template/customuserdetail/editaccount.tpl';
		} else {
		  $this->template = 'default/template/customuserdetail/editaccount.tpl';
		}
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
     	
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['msg'] = "You are successfully registered";
      $this->response->setOutput($this->load->view('customuserdetail/thankyou', $data));

  }
}
?>