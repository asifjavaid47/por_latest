<?php

class ModelCustomCategory extends Model {

    public function get_sub_cat($id) {
        $query = $this->db->query("SELECT a.* , b.* FROM oc_category as a JOIN  oc_category_description as b ON a.category_id=b.category_id  where a.parent_id = " . $id . " and b.language_id  = 1  order by b.category_id asc");
        return $query->rows;
    }

    public function getCategory($category_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int) $category_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row;
    }

    public function getCategories($parent_id = 0) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

        return $query->rows;
    }

    public function getCategory_custom($category_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int) $category_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");
        return $query->row;
    }

    public function getCategoryFilters($category_id) {
        $implode = array();

        $query = $this->db->query("SELECT filter_id FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $implode[] = (int) $result['filter_id'];
        }

        $filter_group_data = array();

        if ($implode) {
            $filter_group_query = $this->db->query("SELECT DISTINCT f.filter_group_id, fgd.name, fg.sort_order FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_group fg ON (f.filter_group_id = fg.filter_group_id) LEFT JOIN " . DB_PREFIX . "filter_group_description fgd ON (fg.filter_group_id = fgd.filter_group_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND fgd.language_id = '" . (int) $this->config->get('config_language_id') . "' GROUP BY f.filter_group_id ORDER BY fg.sort_order, LCASE(fgd.name)");

            foreach ($filter_group_query->rows as $filter_group) {
                $filter_data = array();

                $filter_query = $this->db->query("SELECT DISTINCT f.filter_id, fd.name FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_description fd ON (f.filter_id = fd.filter_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND f.filter_group_id = '" . (int) $filter_group['filter_group_id'] . "' AND fd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY f.sort_order, LCASE(fd.name)");

                foreach ($filter_query->rows as $filter) {
                    $filter_data[] = array(
                        'filter_id' => $filter['filter_id'],
                        'name' => $filter['name']
                    );
                }

                if ($filter_data) {
                    $filter_group_data[] = array(
                        'filter_group_id' => $filter_group['filter_group_id'],
                        'name' => $filter_group['name'],
                        'filter' => $filter_data
                    );
                }
            }
        }

        return $filter_group_data;
    }

    public function getCategoryLayoutId($category_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }

    public function getTotalCategoriesByCategoryId($parent_id = 0) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row['total'];
    }

    public function getProductDiscounts($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . $product_id . "' AND quantity > 1  ORDER BY quantity ASC, priority ASC, price ASC");

        return $query->rows;
    }

    public function getLocations() {
        $query = $this->db->query("SELECT `location`, count(product_id) as locProducts FROM " . DB_PREFIX . "product where location <> '' group by `location` order by `product_id` desc limit 0, 10  ");
        return $query->rows;
    }

    public function getCatProductsCount($cat_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . $cat_id . "' ");

        return count($query->rows);
    }

    public function getProductDetailsJoinById($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product as product join " . DB_PREFIX . "product_description as product_desc WHERE product.product_id = " . $product_id . " AND product_desc.product_id = " . $product_id);
        return $query->rows;
    }

    public function getProductDiscountById($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = " . $product_id . " ORDER BY quantity ASC");
        return $query->rows;
    }

    public function getProductLocationByProductNUserId($product_id_final) {
        $address_query = $this->db->query("SELECT * from  " . DB_PREFIX . "product WHERE product_id = " . $product_id_final . " ");
        $address_id = $address_query->row['address_id'];

        $query = $this->db->query("SELECT * from oc_address_lc where id =  " . $address_id . "   ");
        if (isset($query->row['city'])) {
            $query_city = $this->db->query("SELECT * from localidades where id = " . $query->row['city']);
        } else {
            $query_city->row['localidad'] = 'Not Set';
        }
        return $query_city->row['localidad'];
    }

    public function getProductCityProvinceByProductNUserId($product_id_final) {
        $address_query = $this->db->query("SELECT * from  " . DB_PREFIX . "product WHERE product_id = " . $product_id_final . " ");
        $address_id = $address_query->row['address_id'];

        $query = $this->db->query("SELECT * from oc_address_lc where id =  " . $address_id . "   ");
        // echo '<pre>';
        // print_r($query);
        // exit;

        if (isset($query->row['city'])) {
            $query_city = $this->db->query("SELECT * from localidades where id = " . $query->row['city']);
        } else {
            $query_city->row['localidad'] = 'Not Available';
        }

        if (isset($query->row['province'])) {
            $query_province = $this->db->query("SELECT * from provincias where id = " . $query->row['province']);
        } else {
            $query_province->row['provincia'] = 'Not Available';
        }
        return $query_city->row['localidad'] . ', ' . $query_province->row['provincia'];
    }

    public function getProductImagesById($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = " . $product_id);
        return $query->rows;
    }

    public function getProductSoldById($product_id) {
        $num_of_sold = 0;
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE product_id = " . $product_id);
        if ($query->num_rows > 0) {
            for ($i = 0; $i < $query->num_rows; $i++) {
                $num_of_sold = $num_of_sold + $query->rows[$i]['quantity'];
            }
        }
        return $num_of_sold;
    }

    public function getProductPaymentMethodsById($product_id) {
        $num_of_sold = 0;
        $query = $this->db->query("SELECT * FROM payment_method_and_discount_lc WHERE product_id = " . $product_id);
        return $query->rows;
    }

    /*     * **Questions to the seeler*** */

    public function addQuestion($data) {
        if (!empty($data['report_id'])) {

            $data['report_id'] = 1;
        } else {
            $data['report_id'] = 0;
        }
        $this->db->query("insert into oc_question(customer_id,product_id,question,date_time,report_id,q_role) values('" . $data['customer_id'] . "', '" . $data['product_id'] . "', '" . $data['question'] . "', '" . $data['date_time'] . "', '" . $data['report_id'] . "', '" . $data['q_role'] . "' )");
    }

    public function getQuestionAnswer($product_id) {
        exit("herel");
        //$q = $this->db->query("select q.question_id, q.question, q.date_time, (select CONCAT(firstname, ' ', lastname) from oc_customer where customer_id = q.customer_id) as cust_name, a.vendor_id, a.answer, a.date_time as a_date_time from oc_question q left join oc_answer a on q.question_id = a.question_id where q.product_id = $product_id ");

        $all_questions = $this->db->query("select * from oc_question where report_id='0' AND product_id = $product_id");

        $questions_answers = array();
        for ($i = 0; $i < $all_questions->num_rows; $i++) {
            $answers_data = $this->db->query("select * from oc_answer where question_id = " . $all_questions->rows[$i]['question_id']);
            $questions_answers['questions'][$i] = $all_questions->rows[$i]['question'];
            $questions_answers['q_role'][$i] = $all_questions->rows[$i]['q_role'];
            $questions_answers['q_datetime'][$i] = $all_questions->rows[$i]['date_time'];
            $questions_answers['customer_id'][$i] = $all_questions->rows[$i]['customer_id'];
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

    /*     * ********* */
    /*     * **************** bilal code start ************************* */

    public function get_vendor_id($cust_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendordetail_lc WHERE customer_id = " . $cust_id);
        return $query;
    }

    public function getvendoremail($prod_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = " . $prod_id);
        return $query;
        //echo "<pre>"; print_r($query); echo "</pre>";
        //exit; 
    }

    public function getcustomeremail($cust_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = " . $cust_id);
        return $query;
    }

    public function getsellerid($prod_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = " . $prod_id);
        return $query;
    }

    public function getsellerids($prod_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = " . $prod_id);
        return $query->row['seller_id'];
    }

    public function getreporter_email($prod_id) {

        $query = $this->db->query("SELECT rl.`reporter_id`,oc.`customer_id`,oc.`email` FROM `oc_reporting_lc` rl  INNER JOIN oc_customer oc ON rl.`reporter_id`=oc.`customer_id`   WHERE rl.product_id='" . $prod_id . "' GROUP BY product_id ");

        return $query->row;
    }

    public function getselleremail($seller_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendordetail_lc WHERE id = " . $seller_id);
        return $query;
    }

    public function add_answer($info) {
        //echo "<pre>"; print_r($info);echo "</pre>";
        //exit;
        $this->db->query("INSERT INTO " . DB_PREFIX . "answer (question_id,vendor_id,answer,a_role) VALUES (" . (int) $info['question_id'] . ", " . $this->db->escape($info['vendor_id']) . " , '" . $this->db->escape($info['answer']) . "', '" . $this->db->escape($info['a_role']) . "' )");
    }

    public function getAllCategory() {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE language_id = 1 ");
        return $query->rows;
    }

    public function get_level_one_category($id) {

        $query = $this->db->query("SELECT a.* , b.*FROM oc_category as a JOIN  oc_category_description as b ON a.category_id=b.category_id where a.parent_id = " . $id . " and b.language_id  = 1 order by b.category_id asc");
        //echo "<pre>"; print_r($query); echo "</pre>";exit;
        return $query->rows;
    }

    public function get_category_tree($category_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_path WHERE category_id = " . $category_id . " ORDER BY category_id ASC");
        return $query->rows;
    }

    public function get_category_tree_name($category_id) {
        //echo $category_id;
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = " . $category_id . " and language_id = 1");
        //echo "<pre>"; print_r($query->rows[0]['name']);echo "</pre>";

        return $query->rows[0]['name'];
    }

    /*     * **************** bilal code end ************************* */

    // asif code start
    public function adduser_history($cat, $ip) {
        $query = $this->db->query("INSERT INTO  oc_userhistory_lc (category_id,ip_address) VALUES ('" . $cat . "','" . $ip . "');");
    }

    public function most_visted_categories($ip) {
        $query = $this->db->query("SELECT  us.`category_id`,COUNT(cd.category_id) AS cnt,cd.name FROM `oc_userhistory_lc` us INNER JOIN  `oc_category_description` cd ON us.`category_id`= cd.category_id WHERE ip_address = '$ip' GROUP BY category_id ORDER BY cnt DESC LIMIT 0, 3 ");

        if ($query->num_rows) {
            return $query->rows;
        } else {
            return 0;
        }
    }
    public function show_most_visted_categories($words) {
        if (sizeof($words) > 0) {
            $a = 0;
            $sql = "SELECT  DISTINCT c.name, c.`category_id` FROM `oc_category_description` c  INNER JOIN oc_userhistory_lc uc   ON c.`category_id` = uc.`category_id` WHERE  ";
            foreach ($words as $word1) {
                if ($a == 0) {
                    $sql.='uc.`category_id` = "' . $word1['category_id'] . '"';
                } else {
                    $sql.=' OR uc.`category_id` = "' . $word1['category_id'] . '"';
                }
                $a++;
            }
            $query = $this->db->query($sql);
            return $query->rows;
        }
    }

    public function sller_products() {
        $sql = "SELECT COUNT(op.`product_id`) AS p_count,opc.*,cd.name FROM oc_order_product op INNER JOIN oc_product_to_category opc  ON op.`product_id` = opc.`product_id`INNER JOIN `oc_category_description` cd ON opc.`category_id`=cd.`category_id` GROUP BY op.`product_id` ORDER BY p_count DESC LIMIT 0, 5 ";
        $query = $this->db->query($sql);
        if ($query->num_rows) {
            return $query->rows;
        } else {
            return 0;
        }
    }

    public function get_seler_id($id) {
        $query = $this->db->query("SELECT * FROM oc_product where product_id='$id'");
        return $query->row['seller_id'];
    }

    public function get_seller_email($id) {

        $query = $this->db->query("SELECT * FROM `oc_reporting_lc` rp INNER JOIN oc_vendordetail_lc ov  ON rp.`seller_id`=ov.`id` INNER JOIN `oc_address_lc` ad ON ad.`customer_id`=ov.`customer_id` WHERE rp.`seller_id`='" . $id . "'
  GROUP BY rp.product_id");
        return $query->row['v_email'];
    }
    public function get_buyer_email($id){
        
        
        $query=$this->db->query("SELECT email FROM oc_customer WHERE customer_id='".$this->db->escape($id)."'");
        return $query->row;
    }

    public function save_reporting($data) {
        $this->db->query("INSERT INTO  oc_reporting_lc (reporter_id,product_id,type_of_issue,comments,seller_id) VALUES ('" . $data['reporter_id'] . "','" . $data['product_id'] . "','" . $data['type_of_issue'] . "','" . $data['comments'] . "','" . $data['seller_id'] . "');");
    }

//    asif code end 
}
