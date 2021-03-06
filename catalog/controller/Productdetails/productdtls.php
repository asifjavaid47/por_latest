<?php

class ControllerProductdetailsproductdtls extends Controller {

    public function index()
	{
		error_reporting(E_ALL);
ini_set('display_errors', 1);
        $this->load->model('catalog/product');

        $data['addQuesAction'] = $this->url->link('Productdetails/productdtls/addQuestion');
        $data['ask_suc'] = '';

        $data['addanswerAction'] = $this->url->link('Productdetails/productdtls/addAnswer');

        /*         * ***add question check*** */
        if ($this->customer->isLogged()) {
            $cust_id = $this->customer->isLogged();
            $data['cust_id'] = $cust_id;
        } else {
            $data['cust_id'] = 0;
        }
        /*         * ***** */

        /*         * *****displaying questions and asnswers**** */
        $this->load->model('catalog/category');
        $product_id;
        if (isset($this->request->get['pxs'])) {
            $product_id = $this->request->get['pxs'];
            $categories = $this->model_catalog_product->getCategories($product_id);
            if ($categories) {
                $categories_info = $this->model_catalog_category->getCategory($categories[0]['category_id']);
                $ip_address = $_SERVER['REMOTE_ADDR'];
                $cat_id = $categories_info['category_id'];

                $this->model_catalog_category->adduser_history($cat_id, $ip_address);
            }
        } else {
            $product_id = 0;
        }
        $que_ans_results = $this->model_catalog_category->getQuestionAnswer($product_id);
        $data['que_ans_results'] = $que_ans_results;

<<<<<<< .mine
		
=======
        /****macana de rafa******/
        $data['listing_type'] = $this->model_catalog_product->getProductType($product_id)['listing_type'];
        $data['product_condition'] = $this->model_catalog_product->getProductCondition($product_id)['product_condition'];
        /****macana de rafa******/

>>>>>>> .r423
        /*         * ****vendor info-aa***** */
        $vendor_rec = $this->model_catalog_product->getVendor($product_id);
        if ($vendor_rec) {
            $seller_id = $vendor_rec['seller_id'];
            $data['firstname'] = $vendor_rec['firstname'];
            $data['lastname'] = $vendor_rec['lastname'];
            $data['date_added'] = $vendor_rec['date_added'];
        } else {
            $seller_id = 0;
            $data['firstname'] = '';
            $data['lastname'] = '';
            $data['date_added'] = '2016-04-01';
        }
        /*         * ****aa-end****** */


        /*         * *****review-aa****** */
        $this->load->language('product/product');

        $data['entry_qty'] = $this->language->get('entry_qty');
        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_review'] = $this->language->get('entry_review');
        $data['entry_rating'] = $this->language->get('entry_rating');
        $data['entry_good'] = $this->language->get('entry_good');
        $data['entry_bad'] = $this->language->get('entry_bad');
        $data['text_write'] = $this->language->get('text_write');
        $data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
        $data['text_note'] = $this->language->get('text_note');
        $data['button_continue'] = $this->language->get('button_continue');

        $this->load->model('catalog/review');

        $product_info = $this->model_catalog_product->getProduct($product_id);
	    $data['product_code'] = $product_info['product_code'];
        $data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

        $data['review_status'] = $this->config->get('config_review_status');

        if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
            $data['review_guest'] = true;
        } else {
            $data['review_guest'] = false;
        }

        if ($this->customer->isLogged()) {
            $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
        } else {
            $data['customer_name'] = '';
        }

        $data['reviews'] = sprintf($this->language->get('text_reviews'), (int) $product_info['reviews']);
        $data['rating'] = (int) $product_info['rating'];

        // Captcha
        if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array) $this->config->get('config_captcha_page'))) {
            $data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'));
        } else {
            $data['captcha'] = '';
        }

        $results = $this->model_catalog_product->getProductRelated($product_id);
        foreach ($results as $result) {
            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }
        }

        /*         * ***display rating - reviews**** */
        $rate_results = $this->model_catalog_review->getRatingProductId($this->request->get['pxs']);
        $star1_rating;
        $star2_rating;
        $star3_rating;
        $star4_rating;
        $star5_rating;
        foreach ($rate_results as $result) {
            $star1_rating = $result['star1_rating'];
            $star2_rating = $result['star2_rating'];
            $star3_rating = $result['star3_rating'];
            $star4_rating = $result['star4_rating'];
            $star5_rating = $result['star5_rating'];
        }
        $ratingTotal = $star1_rating + $star2_rating + $star3_rating + $star4_rating + $star5_rating;
        if ($ratingTotal != 0)
            $data['rating'] = ($star1_rating + $star2_rating * 2 + $star3_rating * 3 + $star4_rating * 4 + $star5_rating * 5) / $ratingTotal;
        else
            $data['rating'] = 0;
        /*         * ********** */
        /*         * *****review-end***** */


        // set title of the page
        $this->document->setTitle("Prodcut Details");
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/productdetail/productdtls.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/productdetail/productdtls.tpl';
        } else {
            $this->template = 'default/template/productdetail/productdtls.tpl';
        }
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        // set data to the variable
        //$this->data['my_custom_text'] = "This is my custom page.";

		$this_user_id = $this->customer->getId();
		if($this_user_id)
		{
			$vendor_id_data = $this->db->query("select id from oc_vendordetail_lc where customer_id = ".$this_user_id);
			$data['logged_in_seller'] = $vendor_id_data->row['id'];
        }
		else
		{
			$data['logged_in_seller'] = 0;
		}
		
		$custmr_id = $this->customer->isLogged();
        if ($custmr_id) {
            $data['check_vendor_id'] = $this->model_catalog_category->get_vendor_id($this->customer->isLogged());
        } else {
            $data['check_vendor_id'] = '';
        }



        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;



        if (isset($cat_id) && $cat_id != 0) {
            $category_tree = $this->model_catalog_category->get_category_tree($cat_id);
            $data['category_tree'] = $category_tree;
        }

        $this->response->setOutput($this->load->view('productdetail/productdtls', $data));
    }

    /*     * *******Review-aa********** */

    public function review() {
        $this->load->language('product/product');

        $this->load->model('catalog/review');

        $data['text_no_reviews'] = $this->language->get('text_no_reviews');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['reviews'] = array();

        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

        $results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

        foreach ($results as $result) {
            $data['reviews'][] = array(
                'author' => $result['author'],
                'text' => nl2br($result['text']),
                'rating' => (int) $result['rating'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = 5;
        $pagination->url = $this->url->link('Productdetails/productdtls/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

        $this->response->setOutput($this->load->view('product/review', $data));
    }

    public function write() {
        $this->load->language('product/product');

        $json = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }

            // Captcha
            if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array) $this->config->get('config_captcha_page'))) {
                $captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

                if ($captcha) {
                    $json['error'] = $captcha;
                }
            }

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    /*     * ******aa-end******* */

    /*     * ******Adding Question******** */

    public function addQuestion() {

        $this->load->model('catalog/category');
        $data['ask_suc'] = '';
        if ($this->customer->isLogged()) {
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
            
			//echo $vendorid->row['seller_id'];
			$getselleremail = $this->model_catalog_category->getselleremail($vendorid->row['seller_id']);
            $SendEmailToSeller = $this->sendemail($getselleremail->row['v_email'], $addData['product_id'], $addData['question'], 'question');
            //echo "<pre>";print_r($getselleremail->row['v_email']); echo "</pre>";
            //exit;
            $addQuestion = $this->model_catalog_category->addQuestion($addData);
            //echo $addQuestion;
			header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        } else {
            $page_uri = $this->request->post['page_uri'];
            echo '<script>alert("Signin Please!")</script>';
            header('Location: ' . urldecode($page_uri) . '#que');
            exit();
        }
    }
    /*     * ************** */
	
	public function sendemail($emailToSeller, $prodict_id, $question_or_answer, $flag)
	{
		if($this->request->server['HTTPS']){
			$server = $this->config->get('config_ssl');
		} else{
			$server = $this->config->get('config_url');
		}
		$data['site_url'] = $server;
		if($flag == 'question'){
			$message = sprintf('Ask question by customer: '.$question_or_answer)."\n\n";
			$message .= $server.'index.php?route=Productdetails/productdtls&zamr=$0&xqtn=1&pxs='.$prodict_id."\n\n";
		} else{
			$message = sprintf('Reply From Seller: '.$question_or_answer)."\n\n";
			$message .= $server.'/index.php?route=Productdetails/productdtls&zamr=$0&xqtn=1&pxs='.$prodict_id."\n\n";
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
		if($flag == 'question'){
			$mail->setSubject("Customer QUestion");
		} else{
			$mail->setSubject("Seller Answer");
		}
		$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
		$mail->send();
	}

    public function addAnswer() {

        $this->load->model('catalog/category');

        //echo "<pre>";print_r($this->request->post);echo "</pre>";//exit;
        //$data['ask_suc'] = '';


        $questions_ids = $this->request->post['questions_ids'];
        $answer = $this->request->post['answer'];
        $vendor_id = $this->request->post['vendor_id'];
	
	
	    //$datetime = date("Y-m-d H:i:s");
        $addData = array(
            'question_id' => $questions_ids,
            'vendor_id' => $vendor_id,
            'answer' => $answer,
        );

        $page_uri = $this->request->post['page_uris'];

        //echo "<pre>";print_r($addData); echo "</pre>";


        $getcustomeremail = $this->model_catalog_category->getcustomeremail($this->request->post['customers_ids']);
        //echo "<pre>";print_r($getcustomeremail->row['email']); echo "</pre>";
        //exit;
        $SendEmailToCustomer = $this->sendemail($getcustomeremail->row['email'], $this->request->post['products_ids'], $answer, 'answer');
        //echo "<pre>";print_r($getselleremail->row['v_email']); echo "</pre>";
        //exit;
        $addanswer = $this->model_catalog_category->add_answer($addData);

        header('Location: ' . urldecode($page_uri) . '#que');
        exit();
    }

    public function get_product_data()
	{
        //Product id to get data against
        $product_id_final = $this->request->post['product_id_final'];

        $this->load->model('catalog/category');

        $product_all_details['product_details'] = $this->model_catalog_category->getProductDetailsJoinById($product_id_final);
        $product_all_details['product_discounts'] = $this->model_catalog_category->getProductDiscountById($product_id_final);
        $product_all_details['product_images'] = $this->model_catalog_category->getProductImagesById($product_id_final);
        $product_all_details['product_sold'] = $this->model_catalog_category->getProductSoldById($product_id_final);
        $product_all_details['product_payment_types_and_discounts'] = $this->model_catalog_category->getProductPaymentMethodsById($product_id_final);

        $product_all_details['product_location'] = $this->model_catalog_category->getProductLocationByProductNUserId($product_id_final);
        $html = $product_all_details['product_details'][0]['description'];
        $product_all_details['product_description'] = html_entity_decode(htmlspecialchars_decode($html));
        $this_user_id = $this->customer->getId();
		$product_report = $this->db->query("select count(*) as reported_product from oc_reporting_lc where reporter_id = ". $this_user_id. " AND product_id = ".$product_id_final);
		
		$product_all_details['reported_by_user'] = $product_report->row['reported_product'];
		
		
		//echo html_entity_decode(htmlspecialchars_decode($html));
        //echo "<pre>";print_r( );echo "</pre>";
        //exit;

        echo json_encode($product_all_details);
    }

    public function get_product_discount() {
        $product_id_final = $this->request->post['product_id_final'];
        $this->load->model('catalog/category');
        $product_all_details = $this->model_catalog_category->getProductDiscountById($product_id_final);
        echo json_encode($product_all_details);
    }
	
	public function change_product_viewed()
	{
        $product_id = $this->request->post['product_id'];
        //$this->load->model('catalog/category');
		$product_viewed = $this->db->query('select viewed from oc_product where product_id = '.$product_id);
		$prduct_views = $product_viewed->row['viewed'] + 1;
        $product_all_details = $this->db->query('UPDATE oc_product SET viewed = '.$prduct_views. ' where product_id = '.$product_id);
    }

    public function get_product_images() {
        $product_id_final = $this->request->post['product_id_final'];
        $this->load->model('catalog/category');
        $product_all_details = $this->model_catalog_category->getProductImagesById($product_id_final);
        echo json_encode($product_all_details);
    }

    public function get_product_sold() {
        $product_id_final = $this->request->post['product_id_final'];
        $this->load->model('catalog/category');
        $product_all_details = $this->model_catalog_category->getProductSoldById($product_id_final);
        echo json_encode($product_all_details);
    }
	
	public function save_reporting()
	{
		if($this->customer->isLogged()){
			$this->load->model('catalog/category');
			$data['type_of_issue'] = $this->request->post['type_of_report'];
			$data['reporter_id'] = $this->customer->getId();
			$data['comments'] = $this->request->post['comments'];
			$data['product_id'] = $this->request->post['productid'];
			$data['seller_id'] = $this->model_catalog_category->getsellerids($data['product_id']);
			$data['seller_email'] = $this->model_catalog_category->get_seller_email($data['seller_id']);
			$reporter_email = $this->customer->getEmail();
			$reporter_name = $this->customer->getFirstName()." ".$this->customer->getLastName();
			$report_id = $this->model_catalog_category->save_reporting($data);
			$this->reported_email_to_seller($data['seller_email'], $data['product_id'], $reporter_email, $reporter_name, $data['reporter_id'], $report_id);
			echo 1;
        } else {
			echo 0;
        }
    }
	
	public function reported_email_to_seller($emailToSeller, $prodict_id, $email_of_reporter, $reportername,$buyer_id,$report_id)
	   {
		if ($this->request->server['HTTPS']){
            $server = $this->config->get('config_ssl');
        }
		else{
            $server = $this->config->get('config_url');
        }
        $message = sprintf('Your product has been reported') . "\n\n";
        $message .= sprintf('Your product has been reported by' . $reportername) . "\n\n";
        $message .= sprintf('Email:' . $email_of_reporter) . "\n\n";
		$message .= $server.'index.php?route=dashboard/dashboardreport&xds=' . $prodict_id .'&cust=' . $buyer_id .'&rpt=' . $report_id . "\n\n";
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
        $mail->setSubject("Reported Product");
        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
        $mail->send();
    }

}

?>