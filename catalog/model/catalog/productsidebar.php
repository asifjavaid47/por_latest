<?php
class ModelCatalogProductsidebar extends Model {


    /**********Products Sidebar*************/
    public function getCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

		return $query->rows;
	}
    
    public function getCatParentId($category_id){
        $parent_id;
        $q = $this->db->query("select parent_id from oc_category where category_id = '$category_id' ");
        foreach($q->rows as $row){
            $parent_id = $row['parent_id'];
        }
        return $parent_id;
    }
    
    public function getCatProductsCount($cat_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . $cat_id . "' ");

		return count($query->rows);
	}
    
    /**********Product locations -- starts*************/
    public function getLocations() {
		$query = $this->db->query("SELECT `location`, count(product_id) as locProducts FROM " . DB_PREFIX . "product where location <> '' group by `location` order by `product_id` desc limit 0, 10  ");
		return $query->rows;
	}
    /**********Product locations -- ends*************/
    /***********************/
}