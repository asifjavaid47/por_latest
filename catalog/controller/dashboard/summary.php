<?php

class ControllerDashboardSummary extends Controller {

    //private $error = array();
    public function index()
	{
        if(!$this->customer->isLogged())
		{
            $this->response->redirect($this->url->link('account/register/login', '', 'SSL'));
        }
		
        // define template file
        if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/dashboard/summary.tpl'))
		{
            $this->template = $this->config->get('config_template') . '/template/dashboard/summary.tpl';
        }
		else
		{
            $this->template = 'default/template/dashboard/summary.tpl';
        }

        if ($this->request->server['HTTPS'])
		{
            $server = $this->config->get('config_ssl');
        }
		else
		{
            $server = $this->config->get('config_url');
        }
		
		$data['site_url'] = $server;
		$customer_id = $this->customer->getId();
		$seller_id_data = $this->db->query("select id from oc_vendordetail_lc where customer_id = ". $customer_id);
		
		$seller_id = $seller_id_data->row['id'];
		
		//for number of active products
		$active_products = $this->db->query("select count(*) as total_active_products from oc_product where product_status = 1 and seller_id = ".$seller_id);
		$data['total_active_products'] = $active_products->row['total_active_products'];
		
		//for number of paused products
		$paused_products = $this->db->query("select count(*) as total_paused_products from oc_product where product_status = 2 and seller_id = ".$seller_id);
		$data['total_paused_products'] = $paused_products->row['total_paused_products'];
		
		//for number of finalized products
		$finalized_products = $this->db->query("select count(*) as total_finalized_products from oc_product where product_status = 3 and seller_id = ".$seller_id);
		$data['total_finalized_products'] = $finalized_products -> row['total_finalized_products'];
		
		//for number of today sales
		$date = new DateTime();
		//echo "Now: ".$date->getTimestamp();
		$beginOfToday = strtotime("midnight", $date->getTimestamp());
		$endOfToday = strtotime("tomorrow", $beginOfToday) - 1;
		$today_sales = $this->db->query("select count(*) as total_today_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) >= ".$beginOfToday." AND UNIX_TIMESTAMP(datetime) <= ".$endOfToday);
		$data['total_today_sales'] = $today_sales -> row['total_today_sales'];
		
		//for number of sales yesterday
		$BeginofYesterday = $beginOfToday- 86400;
		$endOfYesterday = $endOfToday - 86399;
		$yesterday_sales = $this->db->query("select count(*) as total_yesterday_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) >= ".$BeginofYesterday." AND UNIX_TIMESTAMP(datetime) < ".$endOfYesterday);
		$data['total_yesterday_sales'] = $yesterday_sales -> row['total_yesterday_sales'];
		
		//for number of sales this week
		$day = date('w');
		$week_start = strtotime('-'.$day.' days')-5;
		//echo 'week sales: '.$week_start;
		$week_sales = $this->db->query("select count(*) as week_total_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) >= ".$week_start);
		$data['week_total_sales'] = $week_sales -> row['week_total_sales'];
		
		// for number of sales last week
		$previous_week = strtotime("-1 week +1 day");
		$start_last_week = strtotime("last sunday midnight",$previous_week);
		$end_last_week = strtotime("next saturday",$start_last_week);
		$last_week_sales = $this->db->query("select count(*) as total_last_week_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) > ".$start_last_week." AND UNIX_TIMESTAMP(datetime) < ".$end_last_week);
		$data['total_last_week_sales'] = $last_week_sales -> row['total_last_week_sales'];

		//for number of sales two weeks ago
		$second_last_week = strtotime("-2 week +1 day");
		$start_2nd_last_week = strtotime("last sunday midnight",$second_last_week);
		$end_2nd_last_week = strtotime("next saturday",$start_2nd_last_week);
		
		$second_last_week_sales = $this->db->query("select count(*) as total_2nd_last_week_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) > ".$start_2nd_last_week." AND UNIX_TIMESTAMP(datetime) < ".$end_2nd_last_week);
		$data['total_2nd_last_week_sales'] = $second_last_week_sales -> row['total_2nd_last_week_sales'];
		
		//for number of sales this month
		$first_day_this_month_date = date('01-m-Y'); // hard-coded '01' for first day
		$date = new DateTime($first_day_this_month_date);
		$first_day_this_month_date_timestamp = $date->getTimestamp()-1;
		
		$this_month_sales = $this->db->query("select count(*) as total_this_month_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) > ".$first_day_this_month_date_timestamp);
		$data['total_this_month_sales'] = $this_month_sales -> row['total_this_month_sales'];
		
		//for number of sales in last month
		$last_month_start_date = new DateTime("first day of last month");
		$last_month_end_date = new DateTime("last day of last month");

		$last_month_start_date_timestamp = $last_month_start_date->getTimestamp();
		$last_month_end_date_timestamp = $last_month_end_date->getTimestamp();
		$last_month_sales = $this->db->query("select count(*) as total_last_month_sales from oc_sale_purchase_lc where seller_id = ".$seller_id." AND UNIX_TIMESTAMP(datetime) > ".$last_month_start_date_timestamp." AND UNIX_TIMESTAMP(datetime) < ".$last_month_end_date_timestamp);
		$data['total_last_month_sales'] = $last_month_sales -> row['total_last_month_sales'];
		
		//for total sale off charges
		$all_sale_of_products_data = $this->db->query("select count(*) as all_sale_of_products from oc_product where seller_id = ".$seller_id." AND had_been_or_is_sale_off = 1");
		$number_of_all_saleoff_products = $all_sale_of_products_data->row['all_sale_of_products'];
		
		$one_saleoff_charges = 5;
		
		$saleoff_charges = $number_of_all_saleoff_products * $one_saleoff_charges;
		
		$data['saleoff_charges'] = $saleoff_charges;
		
		$data['header'] = $this->load->controller('common/header');
		$data['header1'] = $this->load->controller('common/header1');
        $data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('dashboard/summary',$data));
    }
}
?>