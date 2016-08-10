<?php

class ControllerDashboardReportlist extends Controller {

    private $error = array();

    public function index() {
        $this->load->model('dashboard/reportlist');
        $this->document->setTitle("Report List");
        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/register', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/reportlist.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/dashboard/reportlist.tpl';
        } else {
            $this->template = 'default/template/dashboard/reportlist.tpl';
        }

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {            //print_r($this->request->post);
        }
        $data['reported_products']=  $this->model_dashboard_reportlist->reported_products();
        $data['reported_address']=  $this->model_dashboard_reportlist->reported_seller_address();
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('dashboard/reportlist',$data));
    }
    private function validate() {
        if ((utf8_strlen(trim($this->request->post['new_address'])) < 3) || (utf8_strlen(trim($this->request->post['new_address'])) > 128)) {
            $this->error['new_address'] = $this->language->get('error_new_address');
        }
        if ((utf8_strlen(trim($this->request->post['address_doornumber'])) < 3) || (utf8_strlen(trim($this->request->post['address_doornumber'])) > 128)) {
            $this->error['address_doornumber'] = $this->language->get('error_door_number');
        }
        /* 		if($this->request->post['new_address_condition1'] == 1){
          if ((utf8_strlen(trim($this->request->post['company_doornumber'])) < 1 || utf8_strlen(trim($this->request->post['company_doornumber'])) > 10)) {
          $this->error['company_doornumber'] = $this->language->get('error_userdet_company_doornumber');
          }
          }
         */
        return !$this->error;
    }
}

?>