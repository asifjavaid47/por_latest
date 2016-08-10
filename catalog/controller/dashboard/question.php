<?php

class ControllerDashboardQuestion extends Controller {

    public function index() {
        $this->load->model('dashboard/question');
        $this->load->model('catalog/category');
        $this->document->setTitle("Questions");

        $data['addQuesAction'] = $this->url->link('dashboard/question/addQuestion');
        $data['ask_suc'] = '';

        $data['addanswerAction'] = $this->url->link('Productdetails/productdtls/addAnswer');
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
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/question.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/dashboard/question.tpl';
        } else {
            $this->template = 'default/template/dashboard/question.tpl';
        }
        $ans_que_pro = array();
        $cid = $this->customer->getId();
          $res = $this->model_dashboard_question->userproducts($cid);
      
        //$que =  $this->model_dashboard_question->get_ans_question();

//        for ($i = 0; $i < sizeof($res); $i++) {
//            $que = $this->model_dashboard_question->get_ans_question($res[$i]['product_id']);
//            if (!empty($que)) {
//                $res[$i]['ans_que'] = $que;
//            }
//        }

        $question_ans_arr= array();
        for($i=0; $i<sizeof($res); $i++){
            //echo $data['user_prodcuts'][$i]['product_id'];   
            if(isset($res[$i]['seller_id'])){
            $seller_name = $this->db->query("select v_name from oc_vendordetail_lc where id = ".$res[$i]['seller_id']);
            
            $result=$this->getQuestionAnswer( $res[$i]['product_id']);
            $res[$i]['seller_name']=$seller_name->row['v_name'];
            $res[$i]['ans_que']=$result;
            //$question_ans_arr['other_data'][$i]=$data['user_prodcuts'][$i];
        
            }
            }
        $data["user_pro_que_ans"]=$res;
       
//        echo '<pre>';
//        print_r($res);
//        exit;
        
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['header1'] = $this->load->controller('common/header1');
        $this->response->setOutput($this->load->view('dashboard/question', $data));
    }

    public function getQuestionAnswer($product_id) {
        
        $cid = $this->customer->getId();
        $all_questions = $this->db->query("select ocq.*, oc.firstname, oc.lastname from oc_question ocq INNER JOIN oc_customer oc ON ocq.customer_id=oc.customer_id where ocq.product_id = $product_id AND ocq.report_id=0 AND ocq.customer_id = ".$cid. " ORDER BY ocq.date_time ASC");
        $questions_answers_data= array();
        $questions_answers = array();
        for ($i = 0; $i < $all_questions->num_rows; $i++)
        {
            $answers_data = $this->db->query("select * from oc_answer ocn  where  ocn.question_id = " . $all_questions->rows[$i]['question_id']);
            
            $questions_answers_data['questions'][$i] = $all_questions->rows[$i];
            $questions_answers_data['answers'][$i] = $answers_data->rows;
//            $questions_answers['questions'][$i] = $all_questions->rows[$i]['question'];
//            $questions_answers['q_datetime'][$i] = $all_questions->rows[$i]['date_time'];
//            $questions_answ1ers['customer_id'][$i] = $all_questions->rows[$i]['customer_id'];
//            $questions_answers['question_id'][$i] = $all_questions->rows[$i]['question_id'];
  //          if (!empty($answers_data)) {
    //            for ($k = 0; $k < $answers_data->num_rows; $k++) {
    //                $questions_answers['answers'][$i][$k] = $answers_data->rows[$k]['answer'];
    //                $questions_answers['a_datetime'][$i][$k] = $answers_data->rows[$k]['date_time'];                                   //$questions_answers['customer_id'][$i][$k] = $answers_data->rows[$k]['customer_id'];
                }
            return $questions_answers_data;
                
        }
        
       
    

    //for qusteion answer email
    public function sendemail($emailToSeller, $prodict_id, $question_or_answer, $flag) {
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
            $message .= $server.'index.php?route=dashboard/answer';
        } else {
            $message = sprintf('Reply From Seller: ' . $question_or_answer) . "\n\n";
            $message .= $server.'index.php?route=dashboard/answer';
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

    public function addQuestion() {
        $this->load->model('catalog/category');
        $data['ask_suc'] = '';
        if ($this->customer->isLogged()) {
			//echo 'coming here'; 
            $cust_id = $this->customer->isLogged();
            $prod_id = $this->request->post['product_id'];

            $question = $this->request->post['question'];
            $page_uri = $this->request->post['page_uri'];
            $datetime = date("Y-m-d H:i:s");
            $addData = array(
                'customer_id' => $cust_id,
                'product_id' => $prod_id,
                'question' => $question,
                'date_time' => $datetime,
            );
            //echo "<pre>";print_r($addData); echo "</pre>";
            $vendorid = $this->model_catalog_category->getsellerid($addData['product_id']);
            $getselleremail = $this->model_catalog_category->getselleremail($vendorid->row['seller_id']);
            //echo $getselleremail->row['v_email'];
			$this->sendemail($getselleremail->row['v_email'], $addData['product_id'], $addData['question'], 'question');
            $this->model_catalog_category->addQuestion($addData);
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