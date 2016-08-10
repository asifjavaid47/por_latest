<?php

class ModelDashboardQuestion extends Model {

    public function userproducts($id) {
      
                $query = $this->db->query("SELECT oq.product_id,op.image, op.seller_id, op.`price`,pd.`name`,ss.name AS product_stock  FROM oc_question oq INNER JOIN oc_product op ON oq.`product_id` = op.`product_id` INNER JOIN oc_product_description pd ON oq.`product_id` = pd.`product_id` INNER JOIN oc_stock_status ss ON op.`stock_status_id` = ss.`stock_status_id` 
WHERE oq.customer_id = '$id' GROUP BY oq.`product_id` ");
//        $query = $this->db->query("SELECT vc.id, op.`product_id`,op.`price`,pd.`name`,ss.name As product_stock FROM oc_vendordetail_lc vc INNER JOIN oc_product op ON vc.`id` = op.`seller_id` INNER JOIN oc_product_description pd ON op.`product_id`=pd.`product_id` INNER JOIN oc_stock_status ss ON op.`stock_status_id`=ss.`stock_status_id` WHERE customer_id = '274' GROUP BY op.`product_id`");
        if ($query->num_rows > 0) {
            return $query->rows;
        } else {
            return 0;
        }
    }

    public function get_ans_question($id) {
        $this_product_questions = $this->db->query("select * from oc_question where product_id='".$id."'");
        $questions_ids = array();
        $total_data = array();
        $total_times_ran = 0;
        for ($i = 0; $i < $this_product_questions->num_rows; $i++)
        {
            $questions_ids[$i] = $this_product_questions->rows[$i]['question_id'];
            $total_data[$i] = $this_product_questions->rows[$i];
            $total_times_ran++;
        }
        //print_r($questions_ids);
        //echo sizeof($questions_ids).'size: ';
        if(sizeof($questions_ids) > 0 )
        {
            //exit('le bhai');
                    $this_product_answers = $this->db->query("SELECT * FROM oc_answer WHERE question_id IN (" . implode(',', $questions_ids) . ")");
            for ($i = 0; $i < $this_product_answers->num_rows; $i++)
            {
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

}
