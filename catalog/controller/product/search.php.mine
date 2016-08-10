<?php

class ControllerProductSearch extends Controller {

    public function index() {
//        error_reporting(E_ALL);
//        ini_set('display_errors', 1);
        $quantity;
        $current_sort;
        $this->load->language('product/search');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        if (isset($this->request->get['search'])) {
            $search = $this->request->get['search'];
        } else {
            $search = '';
        }
        $data['old_search_string']=utf8_decode(urldecode($search));
        $search = utf8_decode(urldecode($search));
        $search = explode(' ', $search);
        $new_search = '';
        $corrected = 0;
        for ($i = 0; $i < sizeof($search); $i++) {
            $pspell_link = pspell_new("en");
            if (pspell_check($pspell_link, $search[$i])) {
                $new_search = $new_search . ' ' . $search[$i];
            } else {
                $suggestions = pspell_suggest($pspell_link, $search[$i]);
                $new_search = $new_search . ' ' . $suggestions[0];
                $corrected = 1;
            }
        }
        $search = $new_search;
        $data['corrected'] = $corrected;
        $data['new_search_string'] = $new_search;
        if (isset($this->request->get['tag'])) {
            $tag = $this->request->get['tag'];
        } elseif (isset($this->request->get['search'])) {
            $tag = $this->request->get['search'];
        } else {
            $tag = '';
        }
        if (isset($this->request->get['description'])) {
            $description = $this->request->get['description'];
        } else {
            $description = '';
        }
        if (isset($this->request->get['category_id'])) {
            $category_id = $this->request->get['category_id'];
        } else {
            $category_id = 0;
        }
        if (isset($this->request->get['sub_category'])) {
            $sub_category = $this->request->get['sub_category'];
        } else {
            $sub_category = '';
        }
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];

            $current_sort = $this->request->get['sort'];
        } else {
            $sort = '';

            $current_sort = Null;
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'DESC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        if (isset($this->request->get['location'])) {
            $location = $this->request->get['location'];
        } else {
            $location = "";
        }
        if (isset($this->request->get['price'])) {

            $price = $this->request->get['price'];
            $exploded_price_range = explode("-", $price);
            $data['min_price'] = $exploded_price_range[0];
            $data['max_price'] = $exploded_price_range[1];
        } else {
            $price = "";
            $data['min_price'] = NULL;
            $data['max_price'] = NULL;
        }
        if (isset($this->request->get['quantity'])) {
            $quantity = $this->request->get['quantity'];
        } else {
            $quantity = "";
        }
        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = (int) 48;
        }

        if (isset($this->request->get['search'])) {
            $this->document->setTitle($this->language->get('heading_title') . ' - ' . $this->request->get['search']);
        } elseif (isset($this->request->get['tag'])) {
            $this->document->setTitle($this->language->get('heading_title') . ' - ' . $this->language->get('heading_tag') . $this->request->get['tag']);
        } else {
            $this->document->setTitle($this->language->get('heading_title'));
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('product/search')
        );

        $url = '';
        if (isset($this->request->get['price'])) {
            $url .= '&price=' . urlencode(html_entity_decode($this->request->get['price'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['search'])) {
            $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['tag'])) {
            $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
        }

        if (isset($this->request->get['description'])) {
            $url .= '&description=' . $this->request->get['description'];
        }

        if (isset($this->request->get['category_id'])) {
            $url .= '&category_id=' . $this->request->get['category_id'];
        }

        if (isset($this->request->get['sub_category'])) {
            $url .= '&sub_category=' . $this->request->get['sub_category'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        if (isset($this->request->get['location'])) {
            $url .= '&location=' . $this->request->get['location'];
        }
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('product/search', $url)
        );
        if (isset($this->request->get['search'])) {
            $data['heading_title'] = $this->language->get('heading_title') . ' - ' . $this->request->get['search'];
        } else {
            $data['heading_title'] = $this->language->get('heading_title');
        }
        $data['text_empty'] = $this->language->get('text_empty');
        $data['text_search'] = $this->language->get('text_search');
        $data['text_keyword'] = $this->language->get('text_keyword');
        $data['text_category'] = $this->language->get('text_category');
        $data['text_sub_category'] = $this->language->get('text_sub_category');
        $data['text_quantity'] = $this->language->get('text_quantity');
        $data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $data['text_model'] = $this->language->get('text_model');
        $data['text_price'] = $this->language->get('text_price');
        $data['text_tax'] = $this->language->get('text_tax');
        $data['text_points'] = $this->language->get('text_points');
        $data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $data['text_sort'] = $this->language->get('text_sort');
        $data['text_limit'] = $this->language->get('text_limit');
        $data['entry_search'] = $this->language->get('entry_search');
        $data['entry_description'] = $this->language->get('entry_description');
        $data['button_search'] = $this->language->get('button_search');
        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');
        $data['button_list'] = $this->language->get('button_list');
        $data['button_grid'] = $this->language->get('button_grid');
        $data['compare'] = $this->url->link('product/compare');
        $this->load->model('catalog/category');
        // 3 Level Category Search
        $data['categories'] = array();
        $categories_1 = $this->model_catalog_category->getCategories(0);
        foreach ($categories_1 as $category_1) {
            $level_2_data = array();
            $categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
            foreach ($categories_2 as $category_2) {
                $level_3_data = array();
                $categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);
                foreach ($categories_3 as $category_3) {
                    $level_3_data[] = array(
                        'category_id' => $category_3['category_id'],
                        'name' => $category_3['name'],
                    );
                }
                $level_2_data[] = array(
                    'category_id' => $category_2['category_id'],
                    'name' => $category_2['name'],
                    'children' => $level_3_data
                );
            }
            $data['categories'][] = array(
                'category_id' => $category_1['category_id'],
                'name' => $category_1['name'],
                'children' => $level_2_data
            );
        }
        $data['products'] = array();
        if (isset($this->request->get['search']) || isset($this->request->get['tag']) || isset($this->request->get['price'])) {

            $filter_data = array(
                'filter_name' => $search,
                'filter_tag' => $tag,
                'filter_description' => $description,
                'filter_category_id' => $category_id,
                'filter_sub_category' => $sub_category,
                'sort' => $sort,
                'order' => $order,
                'start' => ($page - 1) * $limit,
                'limit' => $limit,
                'location' => $location,
                'price' => $price,
                'quantity' => $quantity,
            );

            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);

            $results = $this->model_catalog_product->getProducts($filter_data);
            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                }
                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
                } else {
                    $tax = false;
                }
                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }
                if (isset($current_sort)) {
                    $max_price = $this->model_catalog_product->getdicountedunitprice($result['product_id'], $quantity);
                    $data['is_sort_set'] = 'yes';
                    $data['sort_order'] = $order;
                    $data['products'][] = array(
                        'current_unit_price' => $max_price,
                        'product_id' => $result['product_id'],
                        'thumb' => $image,
                        'name' => $result['name'],
                        'quantity' => $result['quantity'],
                        'location' => $result['location'],
                        'listing_type' => $result['listing_type'],
                        'require_shipping_method' => $result['require_shipping_method'],
                        'require_shipping_method' => $result['require_shipping_method'],
                        'buyer_pay_or_free_shipping' => $result['buyer_pay_or_free_shipping'],
                        'own_shipping_price' => $result['own_shipping_price'],
                        'radius' => $result['radius'],
                        'vendor_id' => $result['vendor_id'],
                        'product_condition' => $result['product_condition'],
                        'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                        'price' => $price,
                        'special' => $special,
                        'tax' => $tax,
                        'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                        'rating' => $result['rating'],
                        'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url),
                        'date_added' => $result['date_added']
                    );
                } else {
                    $max_price = $this->model_catalog_product->getdicountedunitprice($result['product_id'], $quantity);
                    $data['is_sort_set'] = 'no';
                    $data['products'][] = array(
                        'current_unit_price' => $max_price,
                        'product_id' => $result['product_id'],
                        'thumb' => $image,
                        'name' => $result['name'],
                        'quantity' => $result['quantity'],
                        'location' => $result['location'],
                        'listing_type' => $result['listing_type'],
                        'require_shipping_method' => $result['require_shipping_method'],
                        'require_shipping_method' => $result['require_shipping_method'],
                        'buyer_pay_or_free_shipping' => $result['buyer_pay_or_free_shipping'],
                        'own_shipping_price' => $result['own_shipping_price'],
                        'radius' => $result['radius'],
                        'vendor_id' => $result['vendor_id'],
                        'product_condition' => $result['product_condition'],
                        'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                        'price' => $price,
                        'special' => $special,
                        'tax' => $tax,
                        'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                        'rating' => $result['rating'],
                        'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url),
                        'date_added' => $result['date_added']
                    );
                }
            }
            $url = '';
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }
            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }
            if (isset($this->request->get['location'])) {
                $url .= '&location=' . $this->request->get['location'];
            }
            $data['sorts'] = array();
            $data['sorts'][] = array(
                'text' => $this->language->get('MÃ¡s relevante'),
                'value' => 'p.listing_type-DESC',
                'href' => $this->url->link('product/search', 'sort=p.sort_order&order=ASC' . $url)
            );
            $data['sorts'][] = array(
                'text' => $this->language->get('text_price_asc'),
                'value' => 'p.price-ASC',
                'href' => $this->url->link('product/search', 'sort=p.price&order=ASC' . $url)
            );
            $data['sorts'][] = array(
                'text' => $this->language->get('text_price_desc'),
                'value' => 'p.price-DESC',
                'href' => $this->url->link('product/search', 'sort=p.price&order=DESC' . $url)
            );

            $url = '';
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            $data['limits'] = array();

            $limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));
            sort($limits);
            foreach ($limits as $value) {
                $data['limits'][] = array(
                    'text' => $value,
                    'value' => $value,
                    'href' => $this->url->link('product/search', $url . '&limit=' . $value)
                );
            }
            $url = '';
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['price'])) {
                $url .= '&price=' . urlencode(html_entity_decode($this->request->get['price'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['quantity'])) {
                $url .= '&quantity=' . urlencode(html_entity_decode($this->request->get['quantity'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }
            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $pagination = new Pagination();
            $pagination->total = $product_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link('product/search', $url . '&page={page}');
            $data['pagination'] = $pagination->render();
            $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));


            if ($page == 1) {
                $this->document->addLink($this->url->link('product/search', '', true), 'canonical');
            } elseif ($page == 2) {
                $this->document->addLink($this->url->link('product/search', '', true), 'prev');
            } else {
                $this->document->addLink($this->url->link('product/search', $url . '&page=' . ($page - 1), true), 'prev');
            }
            if ($limit && ceil($product_total / $limit) > $page) {
                $this->document->addLink($this->url->link('product/search', $url . '&page=' . ($page + 1), true), 'next');
            }
        }
        $data['search_categories'] = $this->model_catalog_product->getRelatedSearch($search);

        $var = '';
        if (!empty($data['search_categories'])) {
            foreach ($data['search_categories'] as $cat_id_arr) {

                $var .= $cat_id_arr['category_id'] . ",";
            }
        }
        $var = substr($var, 0, -1);

        if (!empty($var)) {
            $data['search_categories_parent_level_one'] = $this->model_catalog_product->getparent_levelone_category($var);
        } else {
            
        }
//        for location search
        $this->load->model('catalog/category');
        $sidebarLocations = $this->model_catalog_category->getLocations();
        foreach ($sidebarLocations as $location) {
            $data['locations'][] = array(
                'location' => $location['location'],
                'locProducts' => $location['locProducts']
            );
        }
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }

        $data['base'] = $server;
        $data['search'] = $search;
        $data['description'] = $description;
        $data['category_id'] = $category_id;
        $data['sub_category'] = $sub_category;
        $data['currencySymb'] = $this->currency->getSymbolLeft($this->session->data['currency']);
        $data['sort'] = $sort;
        $data['order'] = $order;
        $data['limit'] = $limit;
        //search quantiy value
        $data['search_quantity'] = $quantity;
        $data['limit'] = $limit;
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('product/search', $data));
    }

}
