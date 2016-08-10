<?php  
class ControllerHomepagehome extends Controller {
  public function index() {
    // set title of the page
    $this->document->setTitle("Xcantidad.com - Conviene más");
     
    // define template file
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/homepage/home.tpl')) {
      $this->template = $this->config->get('config_template') . '/template/homepage/home.tpl';
    } else {
      $this->template = 'default/template/homepage/home.tpl';
    }
     
$data['column_left'] = $this->load->controller('common/column_left');
$data['column_right'] = $this->load->controller('common/column_right');
$data['content_top'] = $this->load->controller('common/content_top');
$data['content_bottom'] = $this->load->controller('common/content_bottom');
$data['footer'] = $this->load->controller('common/footer');
$data['header'] = $this->load->controller('common/header');
     
    // set data to the variable
 $this->response->setOutput($this->load->view('homepage/home', $data));

  }
}
?>