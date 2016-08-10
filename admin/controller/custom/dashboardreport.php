<?php

class ControllerCustomDashboardreport extends Controller {

    public function index() {
        error_reporting(1);
        $this->load->model('custom/reportlist');
        $this->load->model('custom/category');
        $this->document->setTitle("Report List");
        if (isset($_GET['token'])) {
            $token = '&token=' . $_GET['token'];
        } else {
            $token = "";
        }
        $data['addQuesAction'] = $this->url->link('custom/dashboardreport/addquestions' . $token);
        $data['addanswerAction'] = $this->url->link('custom/dashboardreport/addAnswer' . $token);
        $data['ask_suc'] = '';
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/custom/dashboardreport.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/custom/dashboardreport.tpl';
        } else {
            $this->template = 'default/template/custom/dashboardreport.tpl';
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
        if (isset($this->request->get['rpt'])) {
            $report_id = $this->request->get['rpt'];
        } else {
            $report_id = 0;
        }
        if (isset($this->request->get['cust'])) {
            $buyer_id = $this->request->get['cust'];
        } else {
            $buyer_id = 0;
        }
        $que_ans = $this->model_custom_reportlist->get_ans_question($product_id, $buyer_id);
        $data['que_ans_results'] = $que_ans;
        $data['reported_products'] = $this->model_custom_reportlist->reported_single_product($report_id);
        $data['reported_address'] = $this->model_custom_reportlist->reported_seller_address_single_user($data['reported_products']['seller_id']);
        $data['reported_user'] = $this->model_custom_reportlist->get_repoter_user($buyer_id);
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('custom/dashboardreport', $data));
    }

    public function addQuestions() {

        $this->load->model('custom/category');
        $data['ask_suc'] = '';
        $this->load->model('user/user');
        $user_info = $this->model_user_user->getUser($this->session->data['user_id']);

        if ($user_info['user_id']) {
            $adminname = $user_info['firstname'] . " " . $user_info['lastname'];
            $prod_id = $this->request->post['product_id'];
            $question = $this->request->post['commentbox'];
            $page_uri = $this->request->post['page_uri'];
            $buyer_id = $this->request->post['buyer_id'];
            $question_id_submit = $this->request->post['question_id_submit'];
            if ($question_id_submit == 'notset') {
                $this->db->query("INSERT INTO oc_question (customer_id,product_id,report_id,to_show)VALUES('" . $this->db->escape($buyer_id) . "','" . $prod_id . "','1','0')");
                $question_id_submit = $this->db->getLastId();
            }
            $datetime = date("Y-m-d H:i:s");
            $addData = array(
                'customer_id' => $buyer_id,
                'question_id' => $question_id_submit,
                'answer' => $question,
                'date_time' => $datetime,
                'report_id' => 1,
                'vendor_id' => $this->session->data['user_id'],
                'a_role' => 'admin'
            );
            $data['seller_id'] = $this->model_custom_category->getsellerids($prod_id);
            $data['reporter_email'] = $this->model_custom_category->getreporter_email($prod_id);
            $data['seller_email'] = $this->model_custom_category->get_seller_email($data['seller_id']);
            $data['buyer_email'] = $this->model_custom_category->get_buyer_email($buyer_id);
            $this->sendemail($data['buyer_email'], $prod_id, $question, 'question', $adminname, $buyer_id);
            $this->sendemail($data['seller_email'], $prod_id, $question, 'question', $adminname, $buyer_id);
            $this->model_custom_category->getsellerid($prod_id);
            $this->model_custom_category->add_answer($addData);
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        } else {
            $page_uri = $this->request->post['page_uri'];
            echo '<script>alert("Signin Please!")</script>';
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        }
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

    public function addAnswer() {
        $this->load->model('catalog/category');
        $answer = $this->request->post['answer'];
        $vendor_id = $this->request->post['vendor_id'];
        $addData = array(
            'question_id' => $questions_ids,
            'vendor_id' => $vendor_id,
            'answer' => $answer,
        );
        $page_uri = $this->request->post['page_uris'];
        $getcustomeremail = $this->model_catalog_category->getcustomeremail($this->request->post['customers_ids']);
        $this->sendemail($getcustomeremail->row['email'], $this->request->post['products_ids'], $answer, 'answer');
        $this->model_catalog_category->add_answer($addData);

        header('Location: ' . urldecode($page_uri) . '#que');
        exit();
    }

    public function block_products() {
        $this->load->model('custom/reportlist');
        $product_id = $this->request->post['product_id'];
        $this->model_custom_reportlist->blockproducts($product_id);
    }

    public function close_products() {
        $this->load->model('custom/reportlist');
        $product_id = $this->request->post['product_id'];
        $this->model_custom_reportlist->closeproducts($product_id);
    }

    public function block_user() {
        $this->load->model('custom/reportlist');
        $product_id = $this->request->post['product_id'];
        $seller_id = $this->model_custom_reportlist->getseller_id_to_block($product_id);
        $customer_id = $this->model_custom_reportlist->seller_id_user_block($seller_id);
        $this->model_custom_reportlist->user_block($customer_id);
    }

    public function ranking_point() {
        $this->load->model('custom/reportlist');
        $data['points'] = $this->request->post['ranking_point'];
        $data['customer_id'] = $this->request->post['customer_id'];
        $this->model_custom_reportlist->ranking_point($data);
    }

    public function sendemail($emailToSeller, $prodict_id, $question_or_answer, $flag, $adminname, $buyer_id) {
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        
        if ($flag == 'question') {
            $message = sprintf('Ask question by Admin' . $adminname . ': ' . $question_or_answer) . "\n\n";

            $message .= 'http://porcantidad.com/download/index.php?route=dashboard/dashboardreport&xds=' . $prodict_id . '&cust=' . $buyer_id . "\n\n";
        } else {
            $message = sprintf('Reply From Admin: ' . $question_or_answer) . "\n\n";
            $message .= $server . 'index.php?route=dashboard/dashboardreport&xds=' . $prodict_id . '&cust=' . $buyer_id . "\n\n";
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
        if ($flag == 'question') {
            $mail->setSubject("Admin Comment");
        } else {
            $mail->setSubject("Seller Answer");
        }
        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
        $mail->send();
    }

}

?>