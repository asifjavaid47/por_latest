<?php

class ControllerCustomReportlist extends Controller {

    public function index() {
        //error_reporting(0);
        $this->load->model('custom/reportlist');
        $this->document->setTitle("Report List");
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/custom/reportlist.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/custom/reportlist.tpl';
        } else {
            $this->template = 'default/template/custom/reportlist.tpl';
        }
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        if (isset($this->request->get['orderby'])) {

            $orderby = $this->request->get['orderby'];
        } else {
            $orderby = "ASC";
        }
        $data['reported_products'] = $this->model_custom_reportlist->reported_products($orderby);
       
       
        for($i=0; $i<sizeof($data['reported_products']);$i++){
            
            $reported_data_now =  $this->model_custom_reportlist->reported_seller_address($data['reported_products'][$i]['reporter_id']);
            $data['reported_data']['products'][$i] = $data['reported_products'][$i];
            $data['reported_data']['addresses'][$i] = $reported_data_now[0];
            
        }
//         echo '<pre>';
//        print_r($data['reported_data']);
//        exit;
//        echo "<pre>";
//        print_r($reported_products);
//        exit; 
        
//         $data['reported_user'] = $this->model_custom_reportlist->get_repoter_user($data['reported_products']['reporter_id']); 
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $this->response->setOutput($this->load->view('custom/reportlist', $data));
    }

    public function search() {
        $this->load->model("custom/reportlist");
        if (isset($this->request->post['status'])) {
            $filter_array['status'] = $this->request->post['status'];
        } else {
            $filter_array['status'] = $_SESSION['status'];
        }
        if (isset($this->request->post['seller_name'])) {

            $filter_array['seller_name'] = $this->request->post['seller_name'];
        } else {

            $filter_array['seller_name'] = $_SESSION['seller_name'];
        }
        if (isset($this->request->post['issuetype'])) {

            $filter_array['issuetype'] = $this->request->post['issuetype'];
        } else {

            $filter_array['issuetype'] = $_SESSION['issuetype'];
        }
        if (isset($this->request->post['user_ranking'])) {

            $filter_array['user_ranking'] = $this->request->post['user_ranking'];
        } else {
            $filter_array['user_ranking'] = $_SESSION['user_ranking'];
        }
        if (isset($this->request->get['orderby'])) {
            $filter_array['orderby'] = $this->request->get['orderby'];
        } else {
            $filter_array['orderby'] = "DESC";
        }
        $data['reported_products'] = $this->model_custom_reportlist->search_reported_prodcuts($filter_array);
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $this->response->setOutput($this->load->view('custom/reportlist2', $data));
    }

}

?>