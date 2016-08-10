<?php

class ControllerCustomuserdetailVendordetail extends Controller {

    private $error = array();

    public function index() {
        // set title of the page
        $this->document->setTitle("Vendor Detail");
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
        $this->load->language('customuserdetail/vendordetail');

        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/register', '', 'SSL'));
        }
        // define template file
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/customuserdetail/vendordetail.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/customuserdetail/vendordetail.tpl';
        } else {
            $this->template = 'default/template/customuserdetail/vendordetail.tpl';
        }
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['title'] = $this->document->getTitle();

        $data['base'] = $server;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            if (null !== $this->customer->isLogged()) {
                $cid = $this->customer->getId();
            }
            //echo "<pre>";print_r($this->request->post);echo "</pre>";
            //exit;

            $this->load->model('customuserdetail/vendordetail');
            $get_customer_id_sees = $this->model_customuserdetail_vendordetail->add_vendor_detail($cid, $this->request->post);
            $this->response->redirect($this->url->link('customuserdetail/companydetail'));
        }
        $data['address_labl'] = $this->language->get('address_labl');
        $data['zipcode_labl'] = $this->language->get('zipcode_labl');
        $data['city_labl'] = $this->language->get('city_labl');
        $data['country_labl'] = $this->language->get('country_labl');
        $data['province_labl'] = $this->language->get('province_labl');
        $data['text_select'] = $this->language->get('text_select');
        $data['text_none'] = $this->language->get('text_none');

        /* 	if (isset($this->error['company_name'])) {
          $data['error_userdet_companyname'] = $this->error['company_name'];
          } else {
          $data['error_userdet_companyname'] = '';
          } */

        if (isset($this->error['name'])) {
            $data['error_userdet_name'] = $this->error['name'];
        } else {
            $data['error_userdet_name'] = '';
        }
        if (isset($this->error['phone'])) {
            $data['error_userdet_phone'] = $this->error['phone'];
        } else {
            $data['error_userdet_phone'] = '';
        }
        if (isset($this->error['email'])) {
            $data['error_userdet_email'] = $this->error['email'];
        } else {
            $data['error_userdet_email'] = '';
        }
        if (isset($this->error['address_1'])) {
            $data['error_userdet_address_1'] = $this->error['address_1'];
        } else {
            $data['error_userdet_address_1'] = '';
        }
        if (isset($this->error['city'])) {
            $data['error_userdet_city'] = $this->error['city'];
        } else {
            $data['error_userdet_city'] = '';
        }
        if (isset($this->error['postcode'])) {
            $data['error_userdet_postcode'] = $this->error['postcode'];
        } else {
            $data['error_userdet_postcode'] = '';
        }
        if (isset($this->error['country_id'])) {
            $data['error_userdet_country'] = $this->error['country_id'];
        } else {
            $data['error_userdet_country'] = '';
        }
        if (isset($this->error['zone_id'])) {
            $data['error_userdet_zone'] = $this->error['zone_id'];
        } else {
            $data['error_userdet_zone'] = '';
        }
        if (isset($this->error['vendor_doornumber'])) {
            $data['error_userdet_vendor_doornumber'] = $this->error['vendor_doornumber'];
        } else {
            $data['error_userdet_vendor_doornumber'] = '';
        }
        if (isset($this->error['credit_card'])) {
            $data['error_payment_method_mandatory'] = $this->error['credit_card'];
        } else {
            $data['error_payment_method_mandatory'] = '';
        }
        $data['action'] = $this->url->link('customuserdetail/vendordetail', '', true);


        if (isset($this->request->post['credit_card'])) {
            //echo $data['credit_card'] = $this->request->post['credit_card'];
            ?>

            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
            <script>
                $(document).ready(function () {
                    $('#credit_card').attr('checked', 'checked');
                });
            </script>
            <?php

        } else {
            $data['credit_card'] = '';
        }
        if (isset($this->request->post['wire_transfer'])) {
            $data['wire_transfer'] = $this->request->post['wire_transfer'];
            ?>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
            <script>
                $(document).ready(function () {
                    $('#wire_transfer').attr('checked', 'checked');
                });
            </script>
            <?php

        } else {
            $data['wire_transfer'] = '';
        }
        if (isset($this->request->post['cash'])) {
            $data['cash'] = $this->request->post['cash'];
            ?>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
            <script>
                $(document).ready(function () {
                    $('#cash').attr('checked', 'checked');
                });
            </script>
            <?php

        } else {
            $data['cash'] = '';
        }
        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } else {
            $data['name'] = '';
        }
        if (isset($this->request->post['phone'])) {
            $data['phone'] = $this->request->post['phone'];
        } else {
            $data['phone'] = '';
        }
        if (isset($this->request->post['email'])) {
            $data['email'] = $this->request->post['email'];
        } else {
            $data['email'] = '';
        }
        if (isset($this->request->post['sec_address'])) {
            $data['sec_address'] = $this->request->post['sec_address'];
        } else {
            $data['sec_address'] = '';
        }
        if (isset($this->request->post['address_1'])) {
            $data['address_1'] = $this->request->post['address_1'];
        } else {
            $data['address_1'] = '';
        }
        if (isset($this->request->post['postcode'])) {
            $data['postcode'] = $this->request->post['postcode'];
        } elseif (isset($this->session->data['shipping_address']['postcode'])) {
            $data['postcode'] = $this->session->data['shipping_address']['postcode'];
        } else {
            $data['postcode'] = '';
        }
        if (isset($this->request->post['city'])) {
            $data['city'] = $this->request->post['city'];
        } else {
            $data['city'] = '';
        }
        if (isset($this->request->post['vendor_doornumber'])) {
            $data['vendor_doornumber'] = $this->request->post['vendor_doornumber'];
        } else {
            $data['vendor_doornumber'] = '';
        }

        if (isset($this->request->post['vendor_floor'])) {
            $data['vendor_floor'] = $this->request->post['vendor_floor'];
        } else {
            $data['vendor_floor'] = '';
        }
        if (isset($this->request->post['vendor_apartment'])) {
            $data['vendor_apartment'] = $this->request->post['vendor_apartment'];
        } else {
            $data['vendor_apartment'] = '';
        }
        if (isset($this->request->post['new_address_condition'])) {
            $data['new_address_condition'] = $this->request->post['new_address_condition'];
        } else {
            $data['new_address_condition'] = '';
        }
        if (isset($this->request->post['country_id'])) {
            $data['country_id'] = (int) $this->request->post['country_id'];
        } elseif (isset($this->session->data['shipping_address']['country_id'])) {
            $data['country_id'] = $this->session->data['shipping_address']['country_id'];
        } else {
            $data['country_id'] = $this->config->get('config_country_id');
        }

        if (isset($this->request->post['zone_id'])) {
            $data['zone_id'] = (int) $this->request->post['zone_id'];
        } elseif (isset($this->session->data['shipping_address']['zone_id'])) {
            $data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
        } else {
            $data['zone_id'] = '';
        }

        $this->load->model('localisation/country');

        $data['countries'] = $this->model_localisation_country->getCountries();
        $this->load->model('customuserdetail/vendordetail');
        if (null !== $this->customer->isLogged()) {
            $cid = $this->customer->getId();
            $get_customer_id_sees = $this->model_customuserdetail_vendordetail->get_address($cid);
            $get_province = $this->model_customuserdetail_vendordetail->get_province($get_customer_id_sees->row['zone_id']);
            $get_country = $this->model_customuserdetail_vendordetail->get_country($get_province->row['country_id']);
            //echo "<pre>";print_r($get_customer_id_sees);echo "</pre>";
            //echo "<pre>";print_r($get_country);echo "</pre>";
            $door_number = isset($get_customer_id_sees->row['door_number']) ? $get_customer_id_sees->row['door_number'] : '';
            $floor = isset($get_customer_id_sees->row['floor']) ? $get_customer_id_sees->row['floor'] : '';
            $apartment = isset($get_customer_id_sees->row['apartment']) ? $get_customer_id_sees->row['apartment'] : '';
            $city = isset($get_customer_id_sees->row['city']) ? $get_customer_id_sees->row['city'] : '';
            $provinces = isset($get_province->row['name']) ? $get_province->row['name'] : '';
            $countrys = isset($get_country->row['name']) ? $get_country->row['name'] : '';

            $data['get_address'] = $get_customer_id_sees->row['address_1'] . " " . $door_number . "," . " " . "floor " . $floor . $apartment . "," . " " . $city . ", " . $provinces . ", " . $countrys;

            //exit;
            //$data['get_address'] = $get_customer_id_sees->row['address_1'];
        }




        $this->response->setOutput($this->load->view('customuserdetail/vendordetail', $data));
    }

    public function validate_phone_numberss($phone) {

        if (preg_match('/^[0-9]+$/', $phone)) {
            return 1;
        } else {
            return 0;
        }
    }

    private function validate() {

        /* if ((utf8_strlen(trim($this->request->post['company_name'])) < 3) || (utf8_strlen(trim($this->request->post['company_name'])) > 128)) {
          $this->error['company_name'] = $this->language->get('error_userdet_companyname');
          }
         */

        if (!isset($this->request->post['credit_card']) && !isset($this->request->post['wire_transfer']) && !isset($this->request->post['cash'])) {
            $this->error['credit_card'] = $this->language->get('error_payment_method_mandatory');
        }


        if ((utf8_strlen(trim($this->request->post['name'])) < 2) || (utf8_strlen(trim($this->request->post['name'])) > 128)) {
            $this->error['name'] = $this->language->get('error_userdet_name');
        }

        if ((utf8_strlen($this->request->post['phone']) < 3) || (utf8_strlen($this->request->post['phone']) > 32)) {
            $this->error['phone'] = $this->language->get('error_userdet_phone');
        }


        $phonenum = $this->validate_phone_numberss($this->request->post['phone']);
        if ($phonenum == 0) {
            $this->error['phone'] = $this->language->get('error_userdet_phone');
        }





        if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
            $this->error['email'] = $this->language->get('error_userdet_email');
        }

        if ($this->request->post['new_address_condition'] == 1) {
            if ((utf8_strlen(trim($this->request->post['vendor_doornumber'])) < 1 || utf8_strlen(trim($this->request->post['vendor_doornumber'])) > 10)) {
                $this->error['vendor_doornumber'] = $this->language->get('error_userdet_vendor_doornumber');
            }
        }


        return !$this->error;
    }

    public function user_detail() {

        $s_name = $this->customer->getFirstName();
        $f_name = $this->customer->getLastName();
        $data["name"] = $f_name . " " . $s_name;
        $data["email"] = $this->customer->getEmail();
        $data["phone"] = $this->customer->getFax();
        echo json_encode($data, true);
    }

}
?>