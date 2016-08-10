<?php  
class ControllerCustomuserdetailEditaccount extends Controller {
	
	private $error = array();
	
	public function index() {
        $this->document->setTitle("Edit Account");
	
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->load->language('customuserdetail/editaccount');
	 	if (!$this->customer->isLogged()) {     
			   $this->response->redirect($this->url->link('account/register/login', '', 'SSL'));
	    }
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

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		  $this->load->model('customuserdetail/editaccount');
		  if (null !== $this->customer->isLogged()) { 
				 $cid = $this->customer->getId();
				 $get_basic_detail = $this->model_customuserdetail_editaccount->display_basic_detail($cid); 
				 $get_basic_detail_tax_id = $this->model_customuserdetail_editaccount->display_basic_detail_tax_id($cid); 
				 $get_contact_detail = $this->model_customuserdetail_editaccount->display_contact_detail($cid);
				 $get_company_detail = $this->model_customuserdetail_editaccount->display_company_detail($cid); 
		  }


	$data['get_basic_detail'] = $get_basic_detail;
	$data['get_tax_id'] = $get_basic_detail_tax_id;
	
	$data['get_contact_detail'] = $get_contact_detail;
	$data['get_company_detail'] = $get_company_detail;
	$data['edit_account'] = $this->language->get('edit_account');
	$data['basic_detail'] = $this->language->get('basic_detail');
	$data['name'] = $this->language->get('name');
	$data['surname'] = $this->language->get('surname');
	$data['main_email'] = $this->language->get('main_email');
	$data['phone'] = $this->language->get('phone');
	$data['tax_id'] = $this->language->get('tax_id');
	$data['contact_details'] = $this->language->get('contact_details');
	$data['contact_name'] = $this->language->get('contact_name');
	$data['contact_phone'] = $this->language->get('contact_phone');
	$data['contact_email'] = $this->language->get('contact_email');
	$data['company_details'] = $this->language->get('company_details');
	
	$data['company_name'] = $this->language->get('company_name');
	$data['logo'] = $this->language->get('logo');
	$data['banner'] = $this->language->get('banner');
	$data['modify'] = $this->language->get('modify');
	$this->response->setOutput($this->load->view('customuserdetail/editaccount', $data));
}
	public function save_name(){  
		$name = $this->request->post['name'];
		$this->load->model('customuserdetail/editaccount');
		echo $cid = $this->customer->getId();
		$get_company_detail = $this->model_customuserdetail_editaccount->update_name($name , $cid); 
  }

	public function save_surename(){  
		$surename = $this->request->post['surename'];
		$this->load->model('customuserdetail/editaccount');
		$cid = $this->customer->getId();
		$get_company_detail = $this->model_customuserdetail_editaccount->update_surename($surename , $cid); 
	}

	public function save_newemail(){
	  		if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
			echo "Not Valid";
			return false;
		}
		
			$this->load->model('account/customer');
            $email = $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email']);
			if($email == 1){
				echo "already available";
				return false;
			}
			if($this->request->post['repeat_newemail'] == ''){
				echo "required";
				return false;
			}
			if ($this->request->post['repeat_newemail'] != $this->request->post['email']) {
				echo "not match";
				return false;
			}
			
			echo "done";
			$this->load->model('customuserdetail/editaccount');
			$cid = $this->customer->getId();
			$get_company_detail = $this->model_customuserdetail_editaccount->update_email($this->request->post['email'] , $cid); 
  }

		public function update_phone(){
		
				$phone = $this->request->post['phone'];
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_phone($phone , $cid); 
		}

	public function update_taxid()
	{
		$taxid = $this->request->post['taxid'];
		
		$status = $this->validatetax_id(str_replace("-", "", $taxid));

		if($status==0)
		{
			echo $status;
			exit;
		}
		else
		{
			$this->load->model('customuserdetail/editaccount');
			$cid = $this->customer->getId();
			
			$record_for_tax_id = $this->model_customuserdetail_editaccount->check_taxid_for_uniqueness($taxid);
			
			if($record_for_tax_id->rows[0]['number_of_tax_ids'] > 0)
			{
				$status = 2;
				echo $status;
				exit;
			}
			else
			{
				$get_company_detail = $this->model_customuserdetail_editaccount->update_taxid($taxid , $cid);
				$status = 1;
				echo $status;
				exit;
			}
		}
	}
		
function validatetax_id($cuit)
{
	
	if (!is_numeric($cuit))
	{
		return 0;
	}

	if (strlen($cuit) != 11)
	{
		return 0;
	}

	$prefijo = (int) substr($cuit, 0,2);
	if(!in_array($prefijo, array(20,23,24,27,30,33,34)))
	{
		return 0;
	}
	$cadena = str_split($cuit);
	$result = $cadena[0]*5;
	$result += $cadena[1]*4;
	$result += $cadena[2]*3;
	$result += $cadena[3]*2;
	$result += $cadena[4]*7;
	$result += $cadena[5]*6;
	$result += $cadena[6]*5;
	$result += $cadena[7]*4;
	$result += $cadena[8]*3;
	$result += $cadena[9]*2;

	$div = intval($result/11);
	$resto = $result - ($div*11);

	if($resto==0)
	{
		if($resto==$cadena[10])
		{
			return 1;
		}
		else
		{
			return 1;
		}
	}
	elseif($resto==1)
	{
		if($cadena[10]==9 AND $cadena[0]==2 AND $cadena[1]==3)
		{
			return 1;
		}
		elseif($cadena[10]==4 AND $cadena[0]==2 AND $cadena[1]==3)
		{
			return 1;
		}
	}
	elseif($cadena[10]==(11-$resto))
	{
		return 1;
	}else
	{
		return 0;
	}
}
		public function save_contact_name(){
		  
				$contactname = $this->request->post['contactname'];
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_contactname($contactname , $cid); 
		}
		
		
		public function save_contact_phone(){
		  
				$contactphone = $this->request->post['contactphone'];
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_contactphone($contactphone , $cid); 
		}
		
		
		public function save_contact_email(){
		  
				  
			    if ((utf8_strlen($this->request->post['contactemail']) > 96) || !filter_var($this->request->post['contactemail'], FILTER_VALIDATE_EMAIL)) {
					echo "Not Valid";
					return false;
				}

				$updatecontactemail = $this->request->post['contactemail'];
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_contactemail($updatecontactemail , $cid); 
		}
		
		public function save_company_name(){
		  
				$companyname = $this->request->post['companyname'];
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_companyname($companyname , $cid); 
		}
		
		public function updatelogo(){
			$data['company_logo'] ='';
	
			$uploads_dir = 'image/companylogo/'; 
			$rand = rand(5, 15);;
			
			if (isset($_FILES["company_logo"] ) && is_uploaded_file($this->request->files['company_logo']['tmp_name'])) {
				$handle = fopen($this->request->files['company_logo']['tmp_name'] , "rw");
				$moveto = microtime().'_'.$rand.$this->request->files['company_logo']['name'];
				  move_uploaded_file($this->request->files['company_logo']['tmp_name'],$uploads_dir.$moveto);
				  $data['company_logo'] = $this->request->files['company_logo']['name'];
				
				fclose($handle);
			} else {
				$data['company_logo'] = array();
			}
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_companylogo($moveto, $cid); 
				
				echo json_encode(array('logoname'=>$data['company_logo'],'encryptedname'=>$moveto));
			
		}

		public function updatebanner(){
			$data['company_banner'] ='';
			$uploads_dir = 'image/companybanner/'; 
			$rand = rand(5, 15);;
			
			if (isset($_FILES["company_banner"] ) && is_uploaded_file($this->request->files['company_banner']['tmp_name'])) {
				$handle = fopen($this->request->files['company_banner']['tmp_name'] , "rw");
				$moveto = microtime().'_'.$rand.$this->request->files['company_banner']['name'];
				  move_uploaded_file($this->request->files['company_banner']['tmp_name'],$uploads_dir.$moveto);
				  $data['company_banner'] = $this->request->files['company_banner']['name'];
				
				fclose($handle);
			} else {
				$data['company_banner'] = array();
			}
				$this->load->model('customuserdetail/editaccount');
				$cid = $this->customer->getId();
				$get_company_detail = $this->model_customuserdetail_editaccount->update_companybanner($moveto, $cid); 
				
				echo json_encode(array('bannername'=>$data['company_banner'],'encryptedbanner'=>$moveto));
			
		}



  	private function validate() {
		if ((utf8_strlen(trim($this->request->post['name'])) < 2) || (utf8_strlen(trim($this->request->post['name'])) > 128)) {
			$this->error['name'] = $this->language->get('error_userdet_name');
		}

	   if ((utf8_strlen($this->request->post['phone']) < 3) || (utf8_strlen($this->request->post['phone']) > 32)) {
			$this->error['phone'] = $this->language->get('error_userdet_phone');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
			$this->error['email'] = $this->language->get('error_userdet_email');
		}

		if($this->request->post['new_address_condition'] == 1){
			if ((utf8_strlen(trim($this->request->post['vendor_doornumber'])) < 1 || utf8_strlen(trim($this->request->post['vendor_doornumber'])) > 10)) {
				$this->error['vendor_doornumber'] = $this->language->get('error_userdet_vendor_doornumber');
			}
		}


       return !$this->error;

	}
}
?>