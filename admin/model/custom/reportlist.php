<?php

class ModelCustomReportlist extends Model {

    public function reported_products($orderby) {
//        echo "SELECT  * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id` = ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id` = ov.`customer_id`  INNER JOIN `oc_product_description` pd ON rp.`product_id` = pd.`product_id`  INNER JOIN `oc_product` op ON rp.`product_id` = op.`product_id` 
// ORDER BY rp.`date_time` $orderby";
//        exit;
        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN `oc_product_description` pd ON rp.`product_id` = pd.`product_id` INNER JOIN oc_product op ON rp.`product_id` = op.`product_id` ORDER BY rp.`date_time` $orderby ");
        return $query->rows;
    }

    public function reported_single_product($report_id) {
        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_product op ON rp.`product_id`=op.`product_id`INNER JOIN `oc_product_description` pd ON rp.`product_id`=pd.`product_id`
  WHERE rp.`report_id`='" . $report_id. "'  GROUP BY rp.`product_id`");
        return $query->row;
    }

    public function reported_seller_address($reporter_id) {
        
//        $sql = "SELECT rp.`product_id`,ov.`customer_id`,ad.address,ov.`v_name`,ov.`v_email`,ov.`v_phone` FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id`";
        $sql = "SELECT rp.reporter_id, oc.`customer_id`, ov.v_name,oc.`lastname`,oc.`telephone`, oc.`email`, ov.`v_address`FROM oc_reporting_lc rp  INNER JOIN oc_customer oc ON oc.`customer_id` = rp.`reporter_id`INNER JOIN oc_vendordetail_lc ov ON rp.`reporter_id`=ov.`customer_id`  WHERE rp.`reporter_id`='".$reporter_id."'  "; 

        $query = $this->db->query($sql);
        return $query->rows;
        
    }

//    public function reported_seller_address_single_user($seller_id) {
//
////        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id`  WHERE rp.`seller_id`='" . $seller_id . "' GROUP BY rp.product_id");
////        return $query->row;
//    
//        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id` INNER JOIN user_ranking ur ON ov.`customer_id`=ur.`customer_id` WHERE rp.`seller_id`='" . $seller_id . "' GROUP BY rp.product_id");
//        return $query->row;
//    }

    public function reported_seller_address_single_user($seller_id) {
//        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id`  WHERE rp.`seller_id`='" . $seller_id . "' GROUP BY rp.product_id");
//        return $query->row;
        $qe = $this->db->query("SELECT * FROM oc_vendordetail_lc vd  INNER JOIN user_ranking ur ON vd.`customer_id`=ur.`customer_id` WHERE vd.id='" . $seller_id . "' ");

        $count = $this->db->countAffected();
        if ($count > 0) {
            
        } else {

            $we = $this->db->query("SELECT vd.customer_id FROM oc_vendordetail_lc vd   WHERE vd.id='" . $seller_id . "' ");
            $this->db->query("INSERT INTO user_ranking (customer_id,ranking)VALUES('" . $we->row['customer_id'] . "','100') ");
        }

        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id` INNER JOIN user_ranking ur ON ov.`customer_id`=ur.`customer_id` WHERE rp.`seller_id`='" . $seller_id . "' GROUP BY rp.product_id");
        return $query->row;
    }

    public function user_ranking($user_ranking) {

        $query = $this->db->query("SELECT * FROM user_ranking WHERE customer_id='" . $user_ranking . "'");

        $id_num_rows = $this->db->countAffected();

        if ($id_num_rows) {
            return $query->row;
        } else {

            return 0;
        }
    }

    public function blockproducts($product_id) {
        $this->db->query("UPDATE oc_product SET `status`= 0 WHERE product_id='" . $product_id . "'");
    }

    public function closeproducts($product_id) {

        $this->db->query("UPDATE `oc_reporting_lc` SET `product_status`= 0 WHERE product_id='" . $product_id . "'");
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
                    //$questions_answers['customer_id'][$i][$k] = $answers_data->rows[$k]['customer_id'];
                }
            }
        }
        return $questions_answers;
    }

    public function getseller_id_to_block($product_id) {

        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` WHERE product_id='" . $product_id . "' GROUP BY seller_id");
        return $query->row['seller_id'];
    }

    public function seller_id_user_block($block_id) {
        $query = $this->db->query("SELECT ad.`customer_id` FROM`oc_reporting_lc` rp  INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id` = ov.`id` INNER JOIN `oc_address_lc` ad  ON ad.`customer_id` = ov.`customer_id` WHERE rp.`seller_id` = '" . $block_id . "' GROUP BY rp.product_id ");
        return $query->row['customer_id'];
    }

    public function user_block($block_id) {

        $this->db->query("UPDATE `oc_customer` SET `status`=0 WHERE customer_id='" . $block_id . "'");
    }

    public function search_reported_prodcuts($filter_array) {
        $orderby = $filter_array['orderby'];
        if (!empty($filter_array['seller_name'])) {
            $serach_byname = "AND ov.`v_name` LIKE '%" . $filter_array['seller_name'] . "%'";
        } else {
            $serach_byname = "";
        }
        if (!empty($filter_array['issuetype'])) {

            $issue_type = "AND rp.`type_of_issue`='" . $filter_array['issuetype'] . "'";
        } else {

            $issue_type = "";
        }
        if (!empty($filter_array['user_ranking'])) {

            $renk = "INNER JOIN user_ranking ur ON ov.`customer_id`=ur.`customer_id`";
        } else {

            $renk = "";
        }
        if (!empty($filter_array['user_ranking'])) {

            $renk_grater = 'AND ur.`ranking` > "' . $filter_array['user_ranking'] . '"';
        } else {

            $renk_grater = "";
        }

        $sql = "SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov ON rp.`seller_id` = ov.`id` INNER JOIN `oc_address_lc` ad  ON ad.`customer_id` = ov.`customer_id` INNER JOIN `oc_product_description` pd ON rp.`product_id`=pd.`product_id` $renk INNER JOIN `oc_product` op ON rp.`product_id` = op.`product_id` WHERE  rp.`product_status`='" . $filter_array['status'] . "' $renk_grater $serach_byname $issue_type   GROUP BY rp.`product_id` ORDER BY rp.`date_time` $orderby  ";
        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function ranking_point($points) {
        $this->db->query("UPDATE `user_ranking` SET `ranking`= '" . $points['points'] . "' WHERE customer_id='" . $points['customer_id'] . "'");
    }

    public function get_repoter_user($reporter_id) {

//        $query = $this->db->query("SELECT * FROM oc_vendordetail_lc WHERE customer_id='" . $this->db->escape($reporter_id) . "'");
        $query = $this->db->query("SELECT oc.`customer_id`,oc.`email`,oc.`telephone`,vd.`v_address`,vd.`v_name` FROM oc_customer oc INNER JOIN oc_vendordetail_lc vd ON oc.`customer_id`=vd.`customer_id` WHERE oc.customer_id='".$this->db->escape($reporter_id)."'");
        return $query->row;
    }

    public function get_ans_question($product_id,$cust_id) {
        //$this_product_questions = $this->db->query("select * from oc_question where product_id=" . $product_id);
        $this_product_questions = $this->db->query("select * from oc_question where product_id=" . $product_id . " AND report_id=1 AND customer_id='" . $cust_id ."'");
//        echo "select * from oc_question where product_id=" . $product_id . " AND report_id=1 AND customer_id='" . $cust_id ."'";
//        exit;
        $questions_ids = array();
        $total_data = array();
        $total_times_ran = 0;
        for ($i = 0; $i < $this_product_questions->num_rows; $i++) {
            $questions_ids[$i] = $this_product_questions->rows[$i]['question_id'];
            $total_data[$i] = $this_product_questions->rows[$i];
            $total_times_ran++;
        }
        if(!empty($questions_ids)){
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
    }

}
