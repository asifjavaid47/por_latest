<?php

class ModelDashboardAnswer extends Model {

    public function userproducts($id) {
//       echo "SELECT vd.`id`,op.`product_id`,pd.name,op.`image`,ss.`name` AS stock_status FROM oc_vendordetail_lc vd INNER JOIN oc_product op ON vd.id = op.`seller_id` INNER JOIN oc_product_description pd ON op.`product_id` = pd.`product_id` INNER JOIN `oc_stock_status` ss ON op.`stock_status_id` = ss.`stock_status_id` 
//WHERE vd.customer_id = '".$this->db->escape($id)."'";
//       exit;
        $query = $this->db->query("SELECT vd.`id`,op.price,vd.customer_id,op.`product_id`,pd.name,op.`image`,ss.`name` AS product_stock  FROM oc_vendordetail_lc vd INNER JOIN oc_product op ON vd.id = op.`seller_id` INNER JOIN oc_product_description pd ON op.`product_id` = pd.`product_id` INNER JOIN `oc_stock_status` ss ON op.`stock_status_id` = ss.`stock_status_id` WHERE vd.customer_id = '" . $this->db->escape($id) . "' GROUP BY op.product_id");
        if ($query->num_rows > 0) {
            return $query->rows;
        } else {
            return 0;
        }
    }
    public function test_ans($id){

        $all_questions_data = array();
        $question_result = $this->db->query("select ocq.*, occ.firstname, occ.lastname  from oc_question ocq INNER JOIN oc_customer occ on ocq.customer_id = occ.customer_id where product_id = ".$id." AND ocq.report_id=0");
        $questions_index = 0; 
        for($index=0; $index < $question_result->num_rows; $index++)
        {
            $answer_result = $this->db->query("select * from oc_answer where question_id = ".$question_result->rows[$index]['question_id']);
            if($answer_result->num_rows < 1)
            {
                $all_questions_data[$questions_index] = $question_result->rows[$index];
                $questions_index++;
            }
        }
        
        return $all_questions_data;
    }

    public function get_ans_question($id) {
        $this_product_questions = $this->db->query("select * from oc_question oq INNER JOIN oc_customer oc ON  oq.`customer_id`=oc.`customer_id`  where oq.product_id='" . $id . "' And report_id=0");
        $questions_ids = array();
        $total_data = array();
        $total_times_ran = 0;
        for ($i = 0; $i < $this_product_questions->num_rows; $i++) {
            $questions_ids[$i] = $this_product_questions->rows[$i]['question_id'];
            $total_data[$i] = $this_product_questions->rows[$i];
            $total_times_ran++;
        }
        //print_r($questions_ids);
        //echo sizeof($questions_ids).'size: ';
        if (sizeof($questions_ids) > 0) {
            //exit('le bhai');
            $this_product_answers = $this->db->query("SELECT * FROM oc_answer WHERE question_id IN (" . implode(',', $questions_ids) . ")");
            for ($i = 0; $i < $this_product_answers->num_rows; $i++) {
                $total_data[$total_times_ran] = $this_product_answers->rows[$i];
                $total_times_ran++;
            }

            for ($i = 0; $i < sizeof($total_data); $i++) {
                $date = new DateTime($total_data[$i]['date_time']);
                $timestamp = $date->getTimestamp();
                $total_data[$i]['timestamp'] = $timestamp;
            }

            usort($total_data, function($a, $b) {
                return $a['timestamp'] - $b['timestamp'];
            });
        }

        return $total_data;
    }

    public function question_delete($del_question) {
        $this->db->query("DELETE FROM oc_question WHERE question_id='" . $this->db->escape($del_question) . "'");
    }

    public function get_vendor_id($customer_id) {

        $query = $this->db->query("SELECT id FROM oc_vendordetail_lc WHERE customer_id='" . $this->db->escape($customer_id) . "'");
        return $query->row['id'];
    }
public function get_buyer_email($customer_id){
   
    $query=  $this->db->query("SELECT email FROM oc_customer WHERE customer_id='".$this->db->escape($customer_id)."'");

    return $query->row;
}

    public function add_answer($addData) {
        $this->db->query("INSERT INTO oc_answer(question_id,vendor_id,answer,date_time)VALUE('".$this->db->escape($addData['question_id'])."','".$this->db->escape($addData['vendor_id'])."','".$this->db->escape($addData['answer'])."','".$this->db->escape($addData['date_time'])."')");
    }

}
