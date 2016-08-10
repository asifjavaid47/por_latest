<?php

class ModelDashboardReportlist extends Model {

    public function reported_products() {
        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp   INNER JOIN `oc_product_description` pd 
    ON rp.`product_id` = pd.`product_id` INNER JOIN oc_product op ON rp.`product_id`=op.`product_id`");
        return $query->rows;
    }

    public function questioner_email($question_id) {

        $query = $this->db->query("SELECT * FROM oc_customer  WHERE customer_id = (SELECT customer_id FROM oc_question WHERE question_id ='" . $question_id . "');");
        return $query->row;
    }

    public function reported_single_product($report_id) {

        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_product op ON rp.`product_id`=op.`product_id`INNER JOIN `oc_product_description` pd ON rp.`product_id`=pd.`product_id`
  WHERE rp.`report_id`='" . $report_id . "' GROUP BY rp.`product_id`");
        return $query->row;
    }

    public function add_answer($info) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "answer (question_id,vendor_id,answer,a_role) VALUES (" . (int) $info['question_id'] . ", " . $this->db->escape($info['vendor_id']) . " , '" . $this->db->escape($info['answer']) . "', '" . $this->db->escape($info['a_role']) . "' )");
    }

    public function reported_seller_address() {
//        $query = $this->db->query("SELECT rp.`product_id`,ov.`customer_id`,ad.address,ov.`v_name`,ov.`v_email`,ov.`v_phone` FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id`");
        $query = $this->db->query("SELECT rp.reporter_id,oc.`customer_id`, ov.`v_name`,oc.`telephone`,oc.`email`,ov.`v_address` FROM oc_reporting_lc rp INNER JOIN oc_customer oc ON oc.`customer_id` = rp.`reporter_id`INNER JOIN oc_vendordetail_lc ov ON rp.`reporter_id`=ov.`customer_id` ");
        return $query->rows;
    }

    public function reported_seller_address_single_user($seller_id) {
        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id` WHERE rp.`seller_id`='" . $seller_id . "' GROUP BY rp.product_id");
        return $query->row;
    }

    public function blockproducts($product_id) {
        $this->db->query("UPDATE oc_product SET `status`= 0 WHERE product_id='" . $product_id . "'");
    }

    public function getQuestionAnswer($product_id) {
        //$q = $this->db->query("select q.question_id, q.question, q.date_time, (select CONCAT(firstname, ' ', lastname) from oc_customer where customer_id = q.customer_id) as cust_name, a.vendor_id, a.answer, a.date_time as a_date_time from oc_question q left join oc_answer a on q.question_id = a.question_id where q.product_id = $product_id ");

        $all_questions = $this->db->query("select * from oc_question where report_id='1' AND product_id = $product_id");
        $questions_answers = array();
        for ($i = 0; $i < $all_questions->num_rows; $i++) {
            $answers_data = $this->db->query("select * from oc_answer where question_id = " . $all_questions->rows[$i]['question_id']);
            $questions_answers['questions'][$i] = $all_questions->rows[$i]['question'];
            $questions_answers['q_datetime'][$i] = $all_questions->rows[$i]['date_time'];
            $questions_answers['customer_id'][$i] = $all_questions->rows[$i]['customer_id'];
            $questions_answers['q_role'][$i] = $all_questions->rows[$i]['q_role'];
            $questions_answers['question_id'][$i] = $all_questions->rows[$i]['question_id'];


            if (!empty($answers_data)) {
                for ($k = 0; $k < $answers_data->num_rows; $k++) {
                    $questions_answers['answers'][$i][$k] = $answers_data->rows[$k]['answer'];
                    $questions_answers['a_datetime'][$i][$k] = $answers_data->rows[$k]['date_time'];
                    $questions_answers['a_role'][$i][$k] = $answers_data->rows[$k]['a_role'];
                    //$questions_answers['customer_id'][$i][$k] = $answers_data->rows[$k]['customer_id'];
                }
            }
        }
        return $questions_answers;
    }

    public function getseller_id_to_block() {

        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` WHERE product_id='208' GROUP BY seller_id");
        return $query->row['seller_id'];
    }

    public function seller_id_user_block($block_id) {

        $query = $this->db->query("SELECT ad.`customer_id` FROM`oc_reporting_lc` rp  INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id` = ov.`id` INNER JOIN `oc_address_lc` ad  ON ad.`customer_id` = ov.`customer_id` WHERE rp.`seller_id` = '" . $block_id . "' GROUP BY rp.product_id ");
        return $query->row['customer_id'];
    }

    public function user_block($block_id) {

        $this->db->query("UPDATE `oc_customer` SET `status`=0 WHERE customer_id='" . $block_id . "'");
    }

    public function get_ans_question($product_id, $cust_id) {

        $this_product_questions = $this->db->query("select * from oc_question where product_id=" . $product_id . " AND report_id=1 AND customer_id='" . $cust_id . "'");
        $questions_ids = array();
        $total_data = array();
        $total_times_ran = 0;
        for ($i = 0; $i < $this_product_questions->num_rows; $i++) {
            $questions_ids[$i] = $this_product_questions->rows[$i]['question_id'];
            $total_data[$i] = $this_product_questions->rows[$i];
            $total_times_ran++;
        }
        if (!empty($questions_ids)) {
            $this_product_answers = $this->db->query("SELECT * FROM oc_answer WHERE question_id IN (" . implode(',', $questions_ids) . ")");

            for ($i = 0; $i < $this_product_answers->num_rows; $i++) {
                $total_data[$total_times_ran] = $this_product_answers->rows[$i];
                $total_times_ran++;
            }
        }
        for ($i = 0; $i < sizeof($total_data); $i++) {
            $date = new DateTime($total_data[$i]['date_time']);
            $timestamp = $date->getTimestamp();
            $total_data[$i]['timestamp'] = $timestamp;
        }

        usort($total_data, function($a, $b) {
            return $a['timestamp'] - $b['timestamp'];
        });

        return $total_data;

//       $query= $this->db->query("SELECT * FROM oc_question oq LEFT  JOIN oc_answer an ON oq.`question_id`=an.`question_id`  WHERE oq.product_id='258' ORDER BY oq.`date_time`");
        //return $query->rows;
    }

    public function get_repoter_user($reporter_id) {

        $query = $this->db->query("SELECT * FROM oc_vendordetail_lc WHERE customer_id='" . $this->db->escape($reporter_id) . "'");
        return $query->row;
    }

    public function buyer_email($buyer_email) {

        $query = $this->db->query("SELECT email FROM oc_customer WHERE customer_id='" . $this->db->escape($buyer_email) . "'");

        return $query->row;
    }

    public function getUser($user_id) {
        $query = $this->db->query("SELECT *, (SELECT ug.name FROM `" . DB_PREFIX . "user_group` ug WHERE ug.user_group_id = u.user_group_id) AS user_group FROM `" . DB_PREFIX . "user` u WHERE u.user_id = '" . (int) $user_id . "'");

        return $query->row;
    }

}
