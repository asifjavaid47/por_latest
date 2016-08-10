<?php
class ModelBuyprocessBuyprocess extends Model {
    /*     * *******Buy Process step 1 stasts-aa********** */
    public function getProduct($id)
	{
        $q = $this->db->query("select pd.name, p.product_id, p.model, p.image,p.price,
        s.require_shipping_method, s.vendor, s.buyer, s.xenvios, s.porcantidad_or_own_shipping, s.buyer_pay_or_free_shipping, s.own_shipping_price, s.radius, s.vendor_id, 
        pay.cash_payment, pay.wire_payment, pay.credit_card_payment, pay.cash_discount, pay.wire_discount, pay.credit_card_discount 
        FROM oc_product p 
        INNER JOIN oc_product_description pd ON p.product_id = pd.product_id 
        INNER JOIN shipping_method_lc s ON p.product_id = s.product_id 
        INNER JOIN payment_method_and_discount_lc pay ON p.product_id = pay.product_id 
        WHERE p.product_id = '$id' ");
        if ($q->num_rows)
		{
            return array(
                'product_id' => $q->row['product_id'],
                'name' => $q->row['name'],
                'model' => $q->row['model'],
                'image' => $q->row['image'],
                'price' => $q->row['price'],
                'require_shipping_method' => $q->row['require_shipping_method'],
                'porcantidad_or_own_shipping' => $q->row['porcantidad_or_own_shipping'],
                'buyer_pay_or_free_shipping' => $q->row['buyer_pay_or_free_shipping'],
                'own_shipping_price' => $q->row['own_shipping_price'],
                'vendor_shipping' => $q->row['vendor'],
                'buyer_shipping' => $q->row['buyer'],
                'xenvios_shipping' => $q->row['xenvios'],
				
                'radius' => $q->row['radius'],
                'vendor_id' => $q->row['vendor_id'],
                'cash_payment' => $q->row['cash_payment'],
                'wire_payment' => $q->row['wire_payment'],
                'credit_card_payment' => $q->row['credit_card_payment'],
                'cash_discount' => $q->row['cash_discount'],
                'wire_discount' => $q->row['wire_discount'],
                'credit_card_discount' => $q->row['credit_card_discount']
            );
        } else {
            return false;
        }
    }
    public function getCustomerAddresses($id) {
        $q = $this->db->query("select * from `oc_address_lc` where `customer_id` = '$id' ");
        return $q->rows;
    }
    public function getCustomercity_pro($id) {
        $q = $this->db->query("SELECT * FROM`oc_countrylc` WHERE lcid = '$id' ");
        return $q->rows;
    }
    public function getCustomer($id) {
        $q = $this->db->query("select * from `oc_customer` where `customer_id` = '$id' ");
        if ($q->num_rows) {
            return array(
                'firstname' => $q->row['firstname'],
                'lastname' => $q->row['lastname'],
                'email' => $q->row['email'],
                'telephone' => $q->row['telephone']
            );
        } else {
            return false;
        }
    }
    public function getProductPrice($product_id, $quantity) {
        $product_price = 0;
        if ($quantity <= 1) {
            $q = $this->db->query("select `price` from `oc_product` where `product_id` = '$product_id' ");
            if ($q->num_rows)
                $product_price = $q->row['price'];
        }
        else {
            $q = $this->db->query("select `price`, `quantity` from `oc_product_discount` where `product_id` = '$product_id' order by `quantity` DESC");
            $row['quantity'] = array();
            $product_price = 0;
            for ($i = 0; $i < $q->num_rows; $i++) {
                if ($quantity >= $q->rows[$i]['quantity']) {
                    $product_price = $q->rows[$i]['price'];
                    break;
                }
            }
        }
        if ($product_price == 0) {
            $q = $this->db->query("select `price` from `oc_product` where `product_id` = '$product_id' ");
            if ($q->num_rows)
                $product_price = $q->row['price'];
        }

        return $product_price;
    }
    public function getCustAddress($id) {
        $q = $this->db->query("select * from `oc_address_lc` where `id` = '$id' ");
        if ($q->num_rows) {
            return array(
                'id' => $q->row['id'],
                'address' => $q->row['address'],
                'new_address' => $q->row['new_address'],
                'door_number' => $q->row['door_number'],
                'floor' => $q->row['floor'],
                'apartment' => $q->row['apartment'],
                'postcode' => $q->row['postcode'],
                'city' => $q->row['city'],
                'country' => $q->row['country'],
                'province' => $q->row['province']
            );
        } else {
            return false;
        }
    }
    public function addOrder($data) {
        $datetime = date("Y-m-d H:i:s");
        $inv_prefix = 'INV-' . $datetime;
        $q1 = $this->db->query("insert into `oc_order` values('', '0', '" . $inv_prefix . "', '0', '', '', '" . $data['customer_id'] . "', '0', '" . $data['firstname'] . "', '" . $data['lastname'] . "', '" . $data['email'] . "', '" . $data['telephone'] . "', '', '', '" . $data['firstname'] . "', '" . $data['lastname'] . "', '', '" . $data['payment_address1'] . "', '', '" . $data['payment_city'] . "', '" . $data['payment_postcode'] . "', '', '" . $data['payment_country_id'] . "', '', '" . $data['payment_zone_id'] . "', '', '', '', '', '', '" . $data['firstname'] . "', '" . $data['lastname'] . "', '', '" . $data['shipping_address1'] . "', '', '" . $data['shipping_city'] . "', '" . $data['shipping_postcode'] . "', '', '" . $data['shipping_country_id'] . "', '', '" . $data['shipping_zone_id'] . "', '', '', '" . $data['shipping_method'] . "', '', '" . $data['shipping_charges'] . "', '', '" . $data['total'] . "', '1', '" . $data['vendor_id'] . "', '0', '0', '0', '', '1', '2', 'USD', '1.00', '" . $data['ip'] . "', '', '', '', '" . $datetime . "', '" . $datetime . "' ) ");
        $order_id = $this->db->getLastId();
        $q2 = $this->db->query("insert into `oc_order_product`(`order_id`, `product_id`,`name`,`model`,`quantity`,`price`, `discount`, `total`, `tax`) values('" . $order_id . "', '" . $data['product_id'] . "', '" . $data['name'] . "', '" . $data['model'] . "', '" . $data['quantity'] . "', '" . $data['price'] . "', '" . $data['discount'] . "', '" . $data['total'] . "', '0')");
        if ($q1 && $q2)
            return $order_id;
        else
            return 0;
    }
	
		public function getProductAddress($product_id){
				$q = $this->db->query("SELECT * FROM oc_address_lc WHERE customer_id = (SELECT customer_id FROM oc_vendordetail_lc WHERE id = (SELECT seller_id FROM oc_product WHERE product_id = '$product_id'))");
				if ($q->num_rows) {
						return array(
								'new_address' => $q->row['new_address'],
								'door_number' => $q->row['door_number'],
								'floor' => $q->row['floor'],
								'apartment' => $q->row['apartment'],
								'postcode' => $q->row['postcode'],
								'city' => $q->row['city'],
								'country' => $q->row['country'],
								'province' => $q->row['province']
						);
				}
		
		}
    public function getVendorAddress($vendor_id) {
        $q = $this->db->query("select * from `oc_vendordetail_lc` where `id` = '$vendor_id' ");
        if ($q->num_rows) {
            return array(
                'new_address' => $q->row['new_address'],
                'v_address' => $q->row['v_address'],
                'city' => $q->row['city']
            );
        }
    }
    /*     * *******Buy Process step 1 ends-aa********** */
    /*     * *******Buy Process step 2 stasts-aa********** */
    public function getProductOrder($order_id, $cust_id) {
        $q = $this->db->query("select o.order_id, o.shipping_charges, op.product_id, op.name, op.quantity, op.price, op.discount, op.total
        FROM oc_order_product op, oc_order o WHERE o.order_id = op.order_id 
        AND o.order_id = '$order_id' AND o.customer_id = '$cust_id'");
        if ($q->num_rows) {
            $product_id = $q->row['product_id'];
            $q1 = $this->db->query("select pd.name, p.product_id, p.model, p.image,p.price  from oc_product p, oc_product_description pd where p.product_id = pd.product_id AND p.product_id = '$product_id' ");
            if ($q1->num_rows) {
                return array(
                    'product_id' => $q1->row['product_id'],
                    'name' => $q1->row['name'],
                    'model' => $q1->row['model'],
                    'image' => $q1->row['image'],
                    'original_price' => $q1->row['price'], /*                     * ***one product price without discount****** */
                    'shipping_charges' => $q->row['shipping_charges'],
                    'quantity' => $q->row['quantity'],
                    'price' => $q->row['price'], /*                     * *****saved in order_product table after order******* */
                    'discount' => $q->row['discount'],
                    'total' => $q->row['total']
                );
            } else
                return false;
        } else
            return false;
    }
    /*     * ******Buy Process step 2 ends -aa******* */


    /*     * ******Buy Process step 3 strts -aa******* */
    public function getProductDiscount($id) {
        $q = $this->db->query("select * from `oc_product_discount` where `product_id` = '$id' and `quantity` > 1 ");
        return $q->rows;
    }
    /*     * ******Buy Process step 3 ends -aa******* */


    /*     * ******Buy Process step 4 strts -aa******* */
    public function updOrderProduct($data) {
        $q1 = $this->db->query("update `oc_order_product` set `quantity` = '" . $data['quantity'] . "', `price` = '" . $data['price'] . "', `total` = '" . $data['total'] . "' where `order_id` = '" . $data['order_id'] . "' AND `product_id` = '" . $data['product_id'] . "' ");

        $q2 = $this->db->query("update `oc_order` set `total` = '" . $data['total'] . "' where `order_id` = '" . $data['order_id'] . "' ");

        if ($q1 && $q2)
            return true;
        else
            return false;
    }
    /*     * ******Buy Process step 4 ends -aa******* */
}