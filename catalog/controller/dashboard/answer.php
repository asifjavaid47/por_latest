<?php

class ControllerDashboardAnswer extends Controller {

    public function index() {
        $this->load->model('dashboard/answer');
        $this->load->model('catalog/category');
        $this->document->setTitle("Answers");

        //$data['addQuesAction'] = $this->url->link('dashboard/question/addQuestion');
        $data['ask_suc'] = '';
        $data['addanswerAction'] = $this->url->link('dashboard/answer/addAnswer');
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
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/answer.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/dashboard/answer.tpl';
        } else {
            $this->template = 'default/template/dashboard/answer.tpl';
        }

        $cid = $this->customer->getId();
        $res = $this->model_dashboard_answer->userproducts($cid);
        //$que =  $this->model_dashboard_question->get_ans_question();
                //$que =  $this->model_dashboard_question->get_ans_question();
//        $que = $this->model_dashboard_answer->test_ans(295);
//        exit;
        for ($i = 0; $i < sizeof($res); $i++) {
            $que = $this->model_dashboard_answer->test_ans($res[$i]['product_id']);
//            echo "Number : ".$i.'<br><br>';
//            echo '<pre>';
//            print_r($que);
//            echo '</pre>';
            if (!empty($que)) {
                $res[$i]['ans_que'] = $que;
            }
        }
        $data['user_product'] = $res;
       
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['header1'] = $this->load->controller('common/header1');
        $this->response->setOutput($this->load->view('dashboard/answer', $data));
    }

    public function getQuestionAnswer($product_id) {
        $all_questions = $this->db->query("select * from oc_question where product_id = $product_id AND report_id=0 ");
        $questions_answers = array();
        for ($i = 0; $i < $all_questions->num_rows; $i++) {
            $answers_data = $this->db->query("select * from oc_answer where report_id=0 AND question_id = " . $all_questions->rows[$i]['question_id']);
            $questions_answers['questions'][$i] = $all_questions->rows[$i]['question'];
            $questions_answers['q_datetime'][$i] = $all_questions->rows[$i]['date_time'];
            $questions_answ1ers['customer_id'][$i] = $all_questions->rows[$i]['customer_id'];
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

    //for qusteion answer email
    public function sendemail($emailToSeller, $question_or_answer, $flag) {
        if ($this->request->server['HTTPS'])
  {
            $server = $this->config->get('config_ssl');
        }
  else
  {
            $server = $this->config->get('config_url');
        }
  //echo 'coming here';
  $data['site_url'] = $server;
        //echo $this->config->get('config_mail_protocol');
        if ($flag == 'question') {
            $message = sprintf('Ask question by customer: ' . $question_or_answer) . "\n\n";
        } else {
            $message = sprintf('Reply From Seller: ' . $question_or_answer) . "\n\n";
            $message .= $server.'index.php?route=dashboard/question \n\n';
        }
        //$email_to = $emailToSeller; //"bilalahmadue@gmail.com";//
        $email_to = $emailToSeller; //"bilalahmadue@gmail.com";//
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
            $mail->setSubject("Customer QUestion");
        } else {
            $mail->setSubject("Seller Answer");
        }
        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
        $mail->send();
    }

    public function delete_question() {

        $question_id = $this->request->post['del_question_id'];
        $this->load->model('dashboard/answer');
        $this->model_dashboard_answer->question_delete($question_id);
        echo 'sussess';
    }

    public function addAnswer() {
        $this->load->model('dashboard/answer');
        if ($this->customer->isLogged()) {
            $customer_id = $this->request->post['customer_id'];
            $question_id = $this->request->post['que_of_ans_id'];
            $answer = $this->request->post['answer'];
            $page_uri = $this->request->post['page_uri'];
            $datetime = date("Y-m-d H:i:s");
            $vendor_id = $this->model_dashboard_answer->get_vendor_id($customer_id);
            
            $buyer_email = $this->model_dashboard_answer->get_buyer_email($customer_id);
            $addData = array(
                'vendor_id' => $vendor_id,
                'question_id' => $question_id,
                'answer' => $answer,
                'date_time' => $datetime,
            );
            
            $this->sendemail($buyer_email, $addData['answer'], 'answer');
            $this->model_dashboard_answer->add_answer($addData);
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        } else {
            $page_uri = $this->request->post['page_uri'];
            echo '<script>alert("Signin Please!")</script>';
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        }
    }

}

?>