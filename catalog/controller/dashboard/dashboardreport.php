<?php

class ControllerDashboardDashboardreport extends Controller {

    public function index() {
        error_reporting(0);
        $this->load->model('catalog/category');
        $this->load->model('dashboard/reportlist');
        $this->document->setTitle("Report List");
        $data['addQuesAction'] = $this->url->link('dashboard/dashboardreport/addquestions');
        $data['addanswerAction'] = $this->url->link('dashboard/dashboardreport/addAnswer');
        $data['ask_suc'] = '';
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;
        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/register/login', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/dashboardreport.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/dashboard/dashboardreport.tpl';
        } else {
            $this->template = 'default/template/dashboard/dashboardreport.tpl';
        }
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        if (isset($this->request->get['xds'])) {
            $product_id = $this->request->get['xds'];
        } else {
            $product_id = 0;
        }
        if (isset($this->request->get['cust'])) {
            $buyer_id = $this->request->get['cust'];
        } else {
            $product_id = 0;
        }
        if (isset($this->request->get['rpt'])) {
            $report_id = $this->request->get['rpt'];
        } else {
            $report_id = 0;
        }

        $custmr_id = $this->customer->isLogged();
        if ($custmr_id) {

            $data['check_vendor_id'] = $this->model_catalog_category->get_vendor_id($this->customer->isLogged());
        } else {
            $data['check_vendor_id'] = '';
        }
        $que_ans = $this->model_dashboard_reportlist->get_ans_question($product_id, $buyer_id);
        $data['que_ans_results'] = $que_ans;
        $data['reported_products'] = $this->model_dashboard_reportlist->reported_single_product($report_id);
        $data['reported_address'] = $this->model_dashboard_reportlist->reported_seller_address_single_user($data['reported_products']['seller_id']);
        $data['reported_user'] = $this->model_dashboard_reportlist->get_repoter_user($data['reported_products']['reporter_id']);
        $data['buyer_id'] = $buyer_id;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('dashboard/dashboardreport', $data));
    }

    public function addQuestions() {
        error_reporting(E_ALL);
     ini_set('display_errors', TRUE);
        $this->load->model('catalog/category');
        $data['ask_suc'] = '';
        if ($this->customer->isLogged()) {
            $cust_id = $this->customer->isLogged();
            $prod_id = $this->request->post['product_id'];
            $report_id = $this->request->post['report_id'];
            $buyer_id = $this->request->post['buyer_id'];
            $user_customer_id = $this->request->post['seller_customer_id'];
            $question = $this->request->post['commentbox'];
            $is_admin = $this->request->post['is_admin'];
            $page_uri = $this->request->post['page_uri'];
            $question_id_submit = $this->request->post['question_id_submit'];
            $current_product_vendor = $this->request->post['current_product_vendor'];
            $login_vendor = $this->request->post['login_vendor'];
            if ($current_product_vendor == $login_vendor) {
                if ($question_id_submit == 'notset') {
                    $this->db->query("INSERT INTO oc_question (customer_id,product_id,report_id,to_show)VALUES('" . $this->db->escape($buyer_id) . "','" . $this->db->escape($prod_id) . "','1','0')");
                    $question_id_submit = $this->db->getLastId();
                }
                $this->addAnswer($question_id_submit, $question, $current_product_vendor, $page_uri, $prod_id, $buyer_id, $is_admin, $report_id);
            } else {
                
                $datetime = date("Y-m-d H:i:s");
                $addData = array
                    (
                    'customer_id' => $buyer_id,
                    'product_id' => $prod_id,
                    'question' => $question,
                    'date_time' => $datetime,
                    'report_id' => 1,
                    'q_role' => 'buyer'
                );
              
                $data['seller_id'] = $this->model_catalog_category->getsellerids($prod_id);
                $data['seller_email'] = $this->model_catalog_category->get_seller_email($data['seller_id']);
                $this->sendemail($data['seller_email'], $prod_id, $question, 'question', $buyer_id, $subject = "", $report_id);
                $this->model_catalog_category->test_question($addData);
                header('Location: ' . urldecode($page_uri) . '#que');
               
            }
            exit();
        } else {
            $page_uri = $this->request->post['page_uri'];
           // echo '<script>alert("Signin Please!")</script>';
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        }
    }

    public function addAnswer($question_id_submit, $question, $current_product_vendor, $page_uri, $prod_id, $buyer_id = "", $is_admin, $report_id) {
        $this->load->model('catalog/category');
        $this->load->model('dashboard/reportlist');
        $questions_ids = $question_id_submit;
        $answer = $question;
        $vendor_id = $current_product_vendor;
        if ($vendor_id == 1) {
            $subject = "Comment from Admin";
        } else {

            $subject = "Reply From seller";
        }
        //$datetime = date("Y-m-d H:i:s"); 
        $addData = array(
            'question_id' => $questions_ids,
            'vendor_id' => $vendor_id,
            'answer' => $answer,
            'a_role' => "seller",
        );
        
        // for ask when seller know about the product report reason
        $buyer_email = $this->model_dashboard_reportlist->buyer_email($buyer_id);
        $this->sendemail($buyer_email, $prod_id, $answer, 'answer', $buyer_id, $subject, $report_id);
        $this->model_dashboard_reportlist->add_answer($addData);
        header('Location: ' . urldecode($page_uri) . '#que');
        //exit();
    }

    public function getQuestionAnswer($product_id) {
        $all_questions = $this->db->query("select * from oc_question where product_id = $product_id AND report_id=1 ");
        $questions_answers = array();
        for ($i = 0; $i < $all_questions->num_rows; $i++) {
            $answers_data = $this->db->query("select * from oc_answer where report_id=1 AND question_id = " . $all_questions->rows[$i]['question_id']);
            $questions_answers['questions'][$i] = $all_questions->rows[$i]['question'];
            $questions_answers['q_datetime'][$i] = $all_questions->rows[$i]['date_time'];
            $questions_answers['customer_id'][$i] = $all_questions->rows[$i]['customer_id'];
            $questions_answers['question_id'][$i] = $all_questions->rows[$i]['question_id'];
            if (!empty($answers_data)) {
                for ($k = 0; $k < $answers_data->num_rows; $k++) {
                    $questions_answers['answers'][$i][$k] = $answers_data->rows[$k]['answer'];
                    $questions_answers['a_datetime'][$i][$k] = $answers_data->rows[$k]['date_time'];                                   //$questions_answers['customer_id'][$i][$k] = $answers_data->rows[$k]['customer_id'];
                }
            }
        }
        return $questions_answers;
    }

    public function block_products() {
        $this->load->model('dashboard/reportlist');
        $product_id = $this->request->post['product_id'];
        $this->model_dashboard_reportlist->blockproducts($product_id);
    }
    public function block_user() {
        $this->load->model('dashboard/reportlist');
        $product_id = $this->request->post['product_id'];
        $seller_id = $this->model_dashboard_reportlist->getseller_id_to_block($product_id);
        $customer_id = $this->model_dashboard_reportlist->seller_id_user_block($seller_id);
        $this->model_dashboard_reportlist->user_block($customer_id);
    }
    public function sendemail($emailToSeller, $prodict_id, $question_or_answer, $flag, $buyer_id, $subject = "", $report_id) {
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['site_url'] = $server;
        if ($flag == 'question') {
            $message = sprintf('Ask question by customer: ' . $question_or_answer) . "\n\n";
            $message .= $server . 'index.php?route=dashboard/dashboardreport&xds=' . $prodict_id . '&cust=' . $buyer_id . '&rpt=' . $report_id . "\n\n";
        } else {

            $message = sprintf($subject . ": " . $question_or_answer) . "\n\n";
            $message .= $server . 'index.php?route=dashboard/dashboardreport&xds=' . $prodict_id . '&cust=' . $buyer_id . '&rpt=' . $report_id . "\n\n";
        }

        $email_to = $emailToSeller;
        $mail = new Mail();
        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->parameter = $this->config->get('config_mail_parameter');
        $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
        $mail->smtp_username = $this->config->get('config_mail_smtp_username');
        $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
        $mail->smtp_port = $this->config->get('config_mail_smtp_port');
        $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
        $mail->setTo($email_to);
        $mail->setFrom($this->config->get('config_name'));
        $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
        if ($subject = "Comment from Admin") {
            $mail->setSubject("Admin Comment");
        }
        if ($flag == 'question') {
            $mail->setSubject("Customer QUestion");
        } else {
            $mail->setSubject("Seller Answer");
        }
        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
        $mail->send();
    }

}

?>