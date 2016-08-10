<?php
echo $header;
global $loader, $registry;
$loader->model('catalog/category');
$modelCat = $registry->get('model_catalog_category');
$review_status = false;
?>
	<link rel="stylesheet" type="text/css" href="<?php echo $base; ?>catalog/view/javascript/assets/slider-gallery.css"/>
	<link rel="stylesheet" type="text/css" href="<?php echo $base; ?>catalog/view/javascript/assets/jquery.bxslider.css"/>
	<script src="<?php echo $base; ?>catalog/view/javascript/assets/js/jquery.bxslider.js"></script>
	
	<script>
		var product_id_final, total_num_of_images, product_data_matched = 0, quantity_products_val, previous_original_price, this_quantity, product_quantity_final, product_amount_final, discounted_price, discount_available = 0, total_amount, product_original_price;
		var product_all_prices = [];
		
		function parseHtmlEnteties(str){
			return str.replace(/&#([0-9]{1,3});/gi, function(match, numStr){
				var num = parseInt(numStr, 10); // read num as normal number
				return String.fromCharCode(num);
			});
		}
		
		$(document).ready(function(){
			var query = window.location.search.substring(1);
			parameters = query.split("&");
			
			split_product_id = parameters[3].split("=");
			product_id = split_product_id[1];
			product_id_final = parseInt(product_id);
			
			split_product_amount = parameters[1].split("=");
			product_amount = split_product_amount[1];
			split_product_amount_dollar = product_amount.split("$");
			product_amount_final_before_splitted = split_product_amount_dollar[1].split(',');
			if(typeof product_amount_final_before_splitted[1] !== 'undefined'){
				product_amount_final = product_amount_final_before_splitted[0] + product_amount_final_before_splitted[1];
			}
			else{
				product_amount_final = product_amount_final_before_splitted[0];
			}
			
			product_amount_final = Number(product_amount_final);
			product_amount_final = Math.round(product_amount_final);
			
			split_product_quantity = parameters[2].split("=");
			product_quantity = split_product_quantity[1];
			product_quantity_final = parseInt(product_quantity);
			
			$('#quantity_products').val(product_quantity_final);
			quantity_products_val = product_quantity_final;
			this_quantity = product_quantity_final;
			
			$(".prevent_default_buy").click(function(event){
				event.preventDefault();
				$('#payment_method_required_text').css('display', 'none');
				var discount_value_selected, discount_type_selected;
				selected_element = $('.hover_selected');
				quantity_selected = $('#quantity_products').val();//selected_element[0]['children'][1].innerHTML;
				amount_selected = selected_element[0]['children'][2].innerHTML;
				original_amount_this_product = $('#discounted_prices_list').children().first().children()[0]['children'][2].innerHTML;
				original_amount_this_product = original_amount_this_product.split('$');
				original_amount_this_product = original_amount_this_product[1];
				payment_type_checked = $('input:checkbox[name=radiog_dark]:checked');
				if(payment_type_checked.length){
					$('#payment_method_required_text').css('display', 'none');
					discount_value_selected = payment_type_checked[0].value;
					discount_type_selected = $('input:checkbox[name=radiog_dark]:checked').attr('url_val');
				}
				else{
					$('#payment_method_required_text').css('display', 'block');
					discount_value_selected = 0;
					discount_type_selected = 'agree';
				}
				window.location.href = 'index.php?route=Buyprocess/buyprocessstep1&zamr=' + amount_selected + '&ytq=' + quantity_selected + '&pxs=' + product_id_final + '&tcsd=' + discount_value_selected + '&dtmp=' + discount_type_selected + '&orgmt=' + original_amount_this_product;
			});
			
			$.ajax(
				{
					url: 'index.php?route=Productdetails/productdtls/get_product_data',
					type: 'post',
					data: {product_id_final: product_id_final},
					async: false,
					success: function(data){
						
						//////////////////////////////////// Data from product details Start////////////////////////
						var product_main_image = '';
						parsed_data = JSON.parse(data);
						
						//Product Title
						$('#product_detail_title').text(parsed_data['product_details'][0].name);
						
						//Define product main image
						if(parsed_data['product_details'][0].image){
							product_main_image = parsed_data['product_details'][0].image;
						}
						else{
							product_main_image = 'cache/placeholder-228x228.png';
						}
						
						//Define product location
						if(parsed_data['product_location']){
							$('#product_location').text(parsed_data['product_location']);
						}
						else{
							$('#product_location').text("No location set!");
						}
						
						//Assign image src to main image
						$('.main_image_link').attr('src', "image/" + product_main_image);
						
						//Append first image with product images slider
						$('#prod-image-slider').append('<li class="active product-thumbs " ><div class="prod-image" ><div class="prod-image-inner" ><a href="#" class="prevent_default change_main_image" ><img id="imageslider0" src="image/' + product_main_image + '" alt=""/></a></div></div></li>');
						
						//Append quantity text wi in stock
						$('#in_stock_quantity').text(parsed_data['product_details'][0].quantity);
						
						//Append first price in the discounted prices list
						if(1 === product_quantity_final && Math.round(parsed_data['product_details'][0].price) === product_amount_final){
							$('#discounted_prices_list').append('<div class="first-table-row"><a class="for_first_price prevent_default change_selected_price hover_selected" selector_attribute = "0" href="#"><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">1</div><div class="price-table-block">$' + Math.round(parsed_data['product_details'][0].price).toLocaleString('es-AR', {}) + '<sup>00</sup></div></a><div class="clr"></div></div>');
							product_data_matched = 1;
						}
						else{
							$('#discounted_prices_list').append('<div class="first-table-row"><a class="for_first_price prevent_default change_selected_price" selector_attribute = "0" href="#"><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">1</div><div class="price-table-block">$' + Math.round(parsed_data['product_details'][0].price).toLocaleString('es-AR', {}) + '<sup>00</sup></div></a><div class="clr"></div></div>');
						}
						//////////////////////////////////// Data from product details Ends////////////////////////
						
						
						product_original_price = Math.round(parsed_data['product_details'][0].price);
						product_all_prices[0] = 1;
						
						
						//////////////////////////////////// Data from product discounts Start////////////////////////
						number_of_discounted_prices = parsed_data['product_discounts'].length;
						
						if(number_of_discounted_prices > 0){
							discount_available = 1;
						}
						else{
							discount_available = 0;
						}
						
						for(i = 0; i < number_of_discounted_prices; i++){
							product_all_prices[i + 1] = Math.round(parsed_data['product_discounts'][i].quantity);
						}
						
						for(i = 0; i < number_of_discounted_prices; i++){
							if(i === (number_of_discounted_prices - 1)){
								if(Math.round(parsed_data['product_discounts'][i].quantity) === product_quantity_final && Math.round(parsed_data['product_discounts'][i].price) === product_amount_final){
									$('#discounted_prices_list').append('<div class="first-table-row"><a id="' + product_all_prices[i + 1] + '" class="hover_selected prevent_default change_selected_price first_price" selector_attribute = "' + (i + 1) + '"  href="#" ><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price).toLocaleString('es-AR', {}) + '</div></a><div class="clr"></div></div>');
									product_data_matched = 1;
								}
								else{
									$('#discounted_prices_list').append('<div class="first-table-row"><a id="' + product_all_prices[i + 1] + '" class="prevent_default change_selected_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price).toLocaleString('es-AR', {}) + '</div></a><div class="clr"></div></div>');
								}
							}
							else{
								if(Math.round(parsed_data['product_discounts'][i].quantity) === product_quantity_final && Math.round(parsed_data['product_discounts'][i].price) === product_amount_final){
									$('#discounted_prices_list').append('<div class="first-table-row"><a id="' + product_all_prices[i + 1] + '_' + product_all_prices[i + 2] + '" class="hover_selected prevent_default change_selected_price first_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price).toLocaleString('es-AR', {}) + '</div></a><div class="clr"></div></div>');
								}
								else{
									$('#discounted_prices_list').append('<div class="first-table-row"><a id="' + product_all_prices[i + 1] + '_' + product_all_prices[i + 2] + '" class="prevent_default change_selected_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><img src="<?php echo $base; ?>image/assets/images/hover-logo-img.png" alt="" class="hover-show"></div><div class="unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price).toLocaleString('es-AR', {}) + '</div></a><div class="clr"></div></div>');
								}
							}
						}
						
						$('.for_first_price').attr('id', product_all_prices[0] + "_" + product_all_prices[1]);
						
						//////////////////////////////////// Data from product discounts end////////////////////////
						
						if(discount_available > 0){
							this_selector_attribute = $('.hover_selected').attr('selector_attribute');
							previous_selector_attribute = $('a[selector_attribute=' + (this_selector_attribute - 1) + ']');
							if(previous_selector_attribute.length){
								previous_original_quantity = previous_selector_attribute[0].children[1].innerHTML;
								previous_original_price_splitted = previous_selector_attribute[0].children[2].innerHTML.split('$');
								previous_original_price_temp = parseInt(previous_original_price_splitted[1]);
								
								//previous_original_price = previous_original_price_temp / previous_original_quantity;
								previous_original_price = previous_original_price_temp;
							}
							else{
								previous_original_price = product_amount_final;
							}
							
							//discounted_price = product_amount_final / product_quantity_final;
							discounted_price = product_amount_final;
							
							if(discounted_price !== Math.round(parsed_data['product_details'][0].price)){
								//Append Original price text
								$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
								
								//Append with discounted original price
								$('#discounted_original_price').text("$" + Math.round(discounted_price).toLocaleString('es-AR', {}));
								
								//Percentage discount
								discounted_price_remaining = Math.round(parsed_data['product_details'][0].price) - discounted_price;
								discounted_percent = (discounted_price_remaining / Math.round(parsed_data['product_details'][0].price)) * 100;
								
								$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
								
								saved_amount = discounted_price_remaining * product_quantity_final;
								$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
							}
							
							else{
								$('#discounted_original_price').text("$" + Math.round(parsed_data['product_details'][0].price).toLocaleString('es-AR', {}));
								$('#save_amt_count').text("$0");
							}
						}
						else{
							$('#discounted_original_price').text("$" + Math.round(parsed_data['product_details'][0].price).toLocaleString('es-AR', {}));
							$('#save_amt_count').text("$0");
						}
						
						total_amount = product_amount_final * product_quantity_final;
						$('#total_amount_block').text("$" + Math.round(product_amount_final).toLocaleString('es-AR', {}));
						
						//////////////////////////////////// Data from product images Start////////////////////////
						number_of_images = parsed_data['product_images'].length;
						
						total_num_of_images = number_of_images;
						
						for(i = 0; i < number_of_images; i++){
							$('#prod-image-slider').append('<li class="product-thumbs" "><div class="prod-image"><div class="prod-image-inner"><a href="#" class="prevent_default change_main_image"><img id="imageslider' + (i + 1) + '" src="image/' + parsed_data['product_images'][i].image + '" alt=""/></a></div></div></li>');
						}
						//////////////////////////////////// Data from product images Ends////////////////////////
						
						
						//////////////////////////////////// Data from product Sold Start////////////////////////
						
						$('#items_sold').text(parsed_data['product_sold'] + " vendidos");
						
						//////////////////////////////////// Data from product Sold Ends////////////////////////
						
						var check_vendor_idsss = <?php echo isset($check_vendor_id->row['id'])? $check_vendor_id->row['id']:'09898676576'; ?>;
						
						
						if(parseInt(parsed_data['product_details'][0].seller_id) == check_vendor_idsss){
							$('.reply-link').show();
							$('.question-hide-own-seller').hide();
						}
						else{
							$('.reply-link').hide();
							$('.question-hide-own-seller').show();
						}
						
						$('#prod_desc').html(parsed_data['product_description']).html();
						$('#prod_desc').css('border', '1px solid #ddd');
					}
				});
			$('.prevent_default').click(function(e){
				e.preventDefault();
			});
			
			$('.change_main_image').click(function(e){
				$('.bxslider > .active').removeClass('active');
				$(this).parents().eq(2).addClass('active');
				changed_image = this.children[0].src;
				$('.main_image_link').attr('src', changed_image);
			});
			
			starting_image = 0;
			ending_image = total_num_of_images;
			$('.bx-prev').click(function(){
				for(i = 0; i < total_num_of_images; i++){
					temp = $('#imageslider' + (i)).attr('src');
					$('#imageslider' + i).attr('src', $('#imageslider' + (i + 1)).attr('src'));
					$('#imageslider' + (i + 1)).attr('src', temp);
					$('.main_image_link').attr('src', temp);
				}
			});
			
			$('.bx-next').click(function(){
				for(i = total_num_of_images; i >= 0; i--){
					temp = $('#imageslider' + (i + 1)).attr('src');
					$('#imageslider' + (i + 1)).attr('src', $('#imageslider' + i).attr('src'));
					$('#imageslider' + i).attr('src', temp);
					$('.main_image_link').attr('src', temp);
				}
			});
			
			$('.change_selected_price').click(function(){
				var discounted_price_final, discount_value;
				$('.hover_selected').removeClass('hover_selected');
				$(this).addClass('hover_selected');
				
				this_quantity = parseInt(this.children[1].innerHTML);
				$('#quantity_products').val(this_quantity);
				this_amount_splitted = this.children[2].innerHTML.split('$');
				this_amount = parseInt(this_amount_splitted[1].replace('.', ''));
				
				discounted_price = this_amount;
				
				total_amount = this_amount * this_quantity;
				
				this_selector_attribute = $(this).attr('selector_attribute');
				previous_selector_attribute = $('a[selector_attribute=' + (this_selector_attribute - 1) + ']');
				if(previous_selector_attribute.length){
					previous_original_quantity = previous_selector_attribute[0].children[1].innerHTML;
					previous_original_price_splitted = previous_selector_attribute[0].children[2].innerHTML.split('$');
					previous_original_price_temp = parseInt(previous_original_price_splitted[1].replace('.', ''));
					
					previous_original_price = previous_original_price_temp;
				}
				else{
					previous_original_price = this_amount;
				}
				
				payment_type_checked = $('input:checkbox[name=radiog_dark]:checked');
				
				if(payment_type_checked.length){
					this_type_discount_value = payment_type_checked[0].value;
					
					percent_10_value = (total_amount * this_type_discount_value) / 100;
					final_total_value = total_amount - percent_10_value;
					$('#total_amount_block').text("$" + Math.round(final_total_value).toLocaleString('es-AR', {}));
					
					equal_discount_value = percent_10_value / this_quantity;
					previous_original_price = Math.round(previous_original_price - equal_discount_value);
					
					discounted_price_final = Math.round(final_total_value / this_quantity);
					
					if(discounted_price !== product_original_price){
						//Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
						
						//Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price_final).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining = product_original_price - discounted_price_final;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
					}
					
					else{
						$('#product_original_price').text("$" + Math.round(product_original_price).toLocaleString('es-AR', {}));
						
						discounted_new_value = Math.round(final_total_value / this_quantity);
						$('#discounted_original_price').text("$" + Math.round(discounted_new_value).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining_new = product_original_price - discounted_new_value;
						discounted_percent_new = (discounted_price_remaining_new / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent_new) + "% menos!");
						$('#save_amt_count').text("$" + Math.round((product_original_price - discounted_new_value)).toLocaleString('es-AR', {}));
					}
				}
				else{
					$('#total_amount_block').text("$" + Math.round(total_amount).toLocaleString('es-AR', {}));
					if(discounted_price !== product_original_price){
						//Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
						
						//Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining = product_original_price - discounted_price;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
					}
					
					else{
						$('#product_original_price').text("");
						$('#discounted_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
						$('#percentage_discount_value').text("");
						$('#save_amt_count').text("$0");
					}
				}
			});
			
			$('input:checkbox[name=radiog_dark]').change(function(){
				$('#payment_method_required_text').css('display', 'none');
				this_item = $('.hover_selected');
				
				this_quantity = parseInt(this_item[0].children[1].innerHTML);
				this_amount_splitted = this_item[0].children[2].innerHTML.split('$');
				this_amount = parseInt(this_amount_splitted[1]);
				
				discounted_price = this_amount;
				
				total_amount = this_amount * this_quantity;
				
				this_selector_attribute = $('.hover_selected').attr('selector_attribute');
				previous_selector_attribute = $('a[selector_attribute=' + (this_selector_attribute - 1) + ']');
				if(previous_selector_attribute.length){
					previous_original_quantity = previous_selector_attribute[0].children[1].innerHTML;
					previous_original_price_splitted = previous_selector_attribute[0].children[2].innerHTML.split('$');
					previous_original_price_temp = parseInt(previous_original_price_splitted[1]);
					
					previous_original_price = previous_original_price_temp;
				}
				else{
					previous_original_price = this_amount;
				}
				
				if(this.checked){
					$('input:checkbox[name=radiog_dark]').prop('checked', false);
					$(this).prop('checked', true);
					this_type_discount_value = this.value;
					
					discount_value = 10;
					percent_10_value = (total_amount * this_type_discount_value) / 100;
					final_total_value = total_amount - percent_10_value;
					$('#total_amount_block').text("$" + Math.round(final_total_value).toLocaleString('es-AR', {}));
					
					equal_discount_value = percent_10_value / this_quantity;
					previous_original_price = Math.round(previous_original_price - equal_discount_value);
					
					discounted_price_final = Math.round(final_total_value / this_quantity);
					
					if(discounted_price !== product_original_price){
						//Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
						
						//Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price_final).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining = product_original_price - discounted_price_final;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount));
					}
					
					else{
						$('#product_original_price').text("$" + Math.round(product_original_price).toLocaleString('es-AR', {}));
						
						discounted_new_value = Math.round(final_total_value / this_quantity);
						$('#discounted_original_price').text("$" + Math.round(discounted_new_value).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining_new = product_original_price - discounted_new_value;
						discounted_percent_new = (discounted_price_remaining_new / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent_new) + "% menos!");
						
						$('#save_amt_count').text("$" + Math.round((product_original_price - discounted_new_value)));
					}
				}
				else{
					$('#total_amount_block').text("$" + Math.round(total_amount).toLocaleString('es-AR', {}));
					if(discounted_price !== product_original_price){
						//Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
						
						//Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price).toLocaleString('es-AR', {}));
						
						//Percentage discount
						discounted_price_remaining = product_original_price - discounted_price;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
					}
					
					else{
						$('#product_original_price').text("");
						$('#discounted_original_price').text("$" + Math.round(product_original_price).toLocaleString('es-AR', {}));
						$('#percentage_discount_value').text("");
						$('#save_amt_count').text("$0");
					}
				}
			});
			
			$("#quantity_products").on("change paste keyup", function(){
				quantity_products_val = $('#quantity_products').val();
				
				change_product_details_with_plus_minus(quantity_products_val);
			});
			
			$('#minus_products').click(function(){
				quantity_products_val = $('#quantity_products').val();
				if(quantity_products_val < 1){
					$('.hover_selected').removeClass('hover_selected');
				}
				else{
					quantity_products_val--;
					$('#quantity_products').val(quantity_products_val);
					change_product_details_with_plus_minus(quantity_products_val);
				}
			});
			
			$('#add_products').click(function(){
				quantity_products_val = $('#quantity_products').val();
				quantity_products_val++;
				$('#quantity_products').val(quantity_products_val);
				change_product_details_with_plus_minus(quantity_products_val);
			});
			
			
			function change_product_details_with_plus_minus(quantity_products_val){
				if(quantity_products_val === ""){
					$('#discounted_original_price').text("$0");
					$('#percentage_discount_value').text("");
					$('#product_original_price').text("");
					$('#total_amount_block').text("");
					$('#save_amt_count').text("");
					$('.hover_selected').removeClass('hover_selected');
				}
				else{
					quantity_products_val = parseInt(quantity_products_val);
					if(quantity_products_val === 0){
						$('#discounted_original_price').text("$0");
						$('#percentage_discount_value').text("");
						$('#product_original_price').text("");
						$('#total_amount_block').text("");
						$('#save_amt_count').text("");
						$('.hover_selected').removeClass('hover_selected');
					}
					else{
						var discounted_price_final, discount_value;
						
						for(i = 0; i < product_all_prices.length; i++){
							if(i === (product_all_prices.length - 1)){
								if(quantity_products_val >= product_all_prices[i]){
									$('.hover_selected').removeClass('hover_selected');
									$('#' + product_all_prices[i]).addClass('hover_selected');
									
									this_quantity_original = $('#' + product_all_prices[i])[0].children[1].innerHTML;
									this_amount_splitted = $('#' + product_all_prices[i])[0].children[2].innerHTML.split('$');
									this_amount = parseInt(this_amount_splitted[1].replace('.', ''));
								}
							}
							else{
								if(quantity_products_val >= product_all_prices[i] && quantity_products_val < product_all_prices[i + 1]){
									$('.hover_selected').removeClass('hover_selected');
									$('#' + product_all_prices[i] + '_' + product_all_prices[i + 1]).addClass('hover_selected');
									
									this_quantity_original = $('#' + product_all_prices[i] + '_' + product_all_prices[i + 1])[0].children[1].innerHTML;
									this_amount_splitted = $('#' + product_all_prices[i] + '_' + product_all_prices[i + 1])[0].children[2].innerHTML.split('$');
									this_amount = parseInt(this_amount_splitted[1].replace('.', ''));
								}
							}
						}
						
						this_quantity = quantity_products_val;
						
						discounted_price = this_amount;
						
						total_for_plus_minus = Math.round(discounted_price * this_quantity);
						$('#total_amount_block').text("$" + Math.round(total_for_plus_minus).toLocaleString('es-AR', {}));
						
						total_amount = total_for_plus_minus;
						
						this_selector_attribute = $('.hover_selected').attr('selector_attribute');
						previous_selector_attribute = $('a[selector_attribute=' + (this_selector_attribute - 1) + ']');
						if(previous_selector_attribute.length){
							previous_original_quantity = previous_selector_attribute[0].children[1].innerHTML;
							previous_original_price_splitted = previous_selector_attribute[0].children[2].innerHTML.split('$');
							previous_original_price_temp = parseInt(previous_original_price_splitted[1]);
							
							previous_original_price = previous_original_price_temp;
						}
						else{
							previous_original_price = this_amount;
						}
						
						
						payment_type_checked = $('input:checkbox[name=radiog_dark]:checked');
						
						if(payment_type_checked.length){
							this_type_discount_value = payment_type_checked[0].value;
							
							percent_10_value = (total_amount * this_type_discount_value) / 100;
							final_total_value = total_amount - percent_10_value;
							$('#total_amount_block').text("$" + Math.round(final_total_value).toLocaleString('es-AR', {}));
							
							equal_discount_value = percent_10_value / this_quantity;
							previous_original_price = Math.round(previous_original_price - equal_discount_value);
							
							discounted_price_final = Math.round(final_total_value / this_quantity);
							
							if(discounted_price !== product_original_price){
								//////////////////Append Original price text
								$('#product_original_price').text("$" + Math.round(previous_original_price));
								
								/////////////////Append with discounted original price
								$('#discounted_original_price').text("$" + Math.round(discounted_price_final).toLocaleString('es-AR', {}));
								
								//////////////Percentage discount
								discounted_price_remaining = product_original_price - discounted_price_final;
								discounted_percent = (discounted_price_remaining / product_original_price) * 100;
								
								$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
								
								saved_amount = discounted_price_remaining * this_quantity;
								$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
							}
							
							else{
								$('#product_original_price').text("$" + Math.round(product_original_price).toLocaleString('es-AR', {}));
								
								discounted_new_value = Math.round(final_total_value / this_quantity);
								$('#discounted_original_price').text("$" + Math.round(discounted_new_value).toLocaleString('es-AR', {}));
								
								/////////////Percentage discount
								discounted_price_remaining_new = product_original_price - discounted_new_value;
								discounted_percent_new = (discounted_price_remaining_new / product_original_price) * 100;
								
								$('#percentage_discount_value').text(Math.round(discounted_percent_new) + "% menos!");
								
								$('#save_amt_count').text("$" + Math.round((product_original_price - discounted_new_value)).toLocaleString('es-AR', {}));
							}
						}
						else{
							$('#total_amount_block').text("$" + Math.round(total_for_plus_minus).toLocaleString('es-AR', {}));
							if(discounted_price !== product_original_price){
								/////////////////Append Original price text
								$('#product_original_price').text("$" + Math.round(previous_original_price).toLocaleString('es-AR', {}));
								
								/////////////////Append with discounted original price
								$('#discounted_original_price').text("$" + Math.round(discounted_price).toLocaleString('es-AR', {}));
								
								//////////Percentage discount
								discounted_price_remaining = product_original_price - discounted_price;
								discounted_percent = (discounted_price_remaining / product_original_price) * 100;
								
								$('#percentage_discount_value').text(Math.round(discounted_percent) + "% menos!");
								
								saved_amount = discounted_price_remaining * this_quantity;
								$('#save_amt_count').text("$" + Math.round(saved_amount).toLocaleString('es-AR', {}));
							}
							
							else{
								$('#product_original_price').text("");
								$('#discounted_original_price').text("$" + Math.round(product_original_price).toLocaleString('es-AR', {}));
								$('#percentage_discount_value').text("");
								$('#save_amt_count').text("$0");
							}
						}
					}
				}
			}
			
			$('.prevent_default_link').click(function(event){
				event.preventDefault();
				$('#login_model').modal('show');
			});
			
			$('#input-password').keypress(function(e){
				if(e.which == 13){
					user_login();
				}
			});
			
			$('#quick-login .loginaccount').click(function(){
				user_login();
			});
			
			function user_login(){
				$.ajax(
					{
						url: 'index.php?route=account/register/login_login',
						type: 'post',
						data: $('#quick-login input[type=\'text\'], #quick-login input[type=\'password\']'),
						dataType: 'json',
						beforeSend: function(){
							$('#modal-quicksignup .alert-danger').remove();
						},
						success: function(json){
							$('#modal-quicksignup .form-group').removeClass('has-error');
							if(json['islogged']){
								window.location.href = '<?php echo $base;?>';//"index.php?route=customuserdetail/editaccount";
							}
							if(json['error']){
								$('.error-login').html('<div class="col-sm-12 alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
								$('#quick-login #input-email').parent().addClass('has-error');
								$('#quick-login #input-password').parent().addClass('has-error');
								$('#quick-login #input-email').focus();
							}
							if(json['success']){
								window.location.reload();
							}
						}
					});
			}
			
			/*****add to wishlist-aa*****/
			$('.add-wishlist').on('click', function(e){
				e.preventDefault();
				var product_id = $(this).attr("id");
				$.ajax({
					url: 'index.php?route=account/wishlist/add',
					type: 'post',
					data: 'product_id=' + product_id,
					dataType: 'json',
					success: function(json){
						$('.alert').remove();
						
						if(json['redirect']){
							location = json['redirect'];
						}
						
						if(json['success']){
							$('#wishlist-response').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> Added to your wishlist. <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						}
						
						$('#wishlist-total span').html(json['total']);
						$('#wishlist-total').attr('title', json['total']);
						
						$('html, body').animate({scrollTop: 0}, 'slow');
					},
					error: function(xhr, ajaxOptions, thrownError){
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
				
			});
			/******add to wishlist-aa-end*******/
		});
		
		function isNumber(evt){
			var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
			if(iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
				return false;
			}
			return true;
		}
	</script>
	
	
	<div class="container" style="background-color:white; margin-top: 65px;">
		<div class="breadcum-block">
			<ul style="padding:10px 0px;">
				<li>
					<a href="<?php echo $base ?>">Inicio
				</li>
				<li>
					<?php if(isset($category_tree)) {
					foreach($category_tree as $tree_name){ ?>
				<li>&gt;</li>
				<?php $tree_name_get = $modelCat->get_category_tree_name($tree_name['path_id']); ?>
				<li>
					<a href="<?php echo 'index.php?route=product/category&path='.$tree_name['path_id']; ?>"><?php echo $tree_name_get; ?></a>
				</li>
				
				<?php }
				} ?>
				</li>
			</ul>
		</div>
		<!-- Titulo -->
		<div class="row">
			<div class="product-detai-head" id='product_detail_title' style="margin-top: 0"></div>
		</div>
		<div class="row">
			<!-- datos basicos -->
			<div class="sold-address-block sold-address-block-style" style="margin-bottom:20px;padding-top:10px">
			<span style="padding-top:10px;border-top:1px solid #c8c8c8">
				<div class="price-sold">
					<i class="fa fa-shopping-cart"></i><span id='items_sold'></span>
				</div>
				<div class="address-product-det">
					<i class="fa fa-map-marker"></i><span id='product_location'></span>
				</div>
					<span class="in-stock-class">Stock disponible</span> <span id='in_stock_quantity' style="color:#fb9233; font-size:14px; font-weight: bold;!important"></span>
					   <i class="fa fa-check-circle"></i>
			</span>
			</div>
		</div>
		<div class="row">
			<!-- foto principal -->
			<div class="col-sm-6 product" id="wishlist-response">
				
				<div class="product-image-slider">
					
					<div class="product-image" style="border:solid 1px #c8c8c8; width: 100%; height: 500px;">
						<div class="image">
							<a id="prod-image-link" href="" onclick="return false;" data-lightbox="image-1690276006" data-title="Nunc ullamcors">
								<img class="main_image_link" id="prod-image" src="" alt="">
							</a>
						</div>
					</div>
					
					<div><img src="<?php echo $base ?>/image/main-shadow.jpg" style="float: right;"/></div>
					<div class="clr"></div>
					<!-- /.col -->
				</div>
			</div>
			
			<div class="col-sm-6">
				<div class="col-sm-6" style="padding-top:20px;text-align:center">
					<div class="remove-price" id='product_original_price'></div>
					<div>Precio unitario</div>
					<div class="original-price" id='discounted_original_price'></div>
					<div>Descuento por cantidad</div>
					<div class="discount-block" id="percentage_discount_value"></div>
					<div class="check-box-container">
						<div class="method-block">
							<!--Method of Payment-->
						</div>
					</div>
				</div>
				
				
				<div class="col-sm-6" style="padding-bottom:30px">
					<div class="unit-price-product-block row-header-listing">
						<!--div class="table-logo">&nbsp;</div-->
						<div class="product-unit-block">Cantidad</div>
						<div class="price-product-block">Precio Unitario</div>
						<div class="clr"></div>
					</div>
					<div id='discounted_prices_list'></div>
					<div class="wty-product-block" style="padding-top:15px">
						<div class="qty-txt-product"
						">Cantidad
					</div>
					<div class="qty-table-product">
						<div class="minus-btn-qty">
							<button id='minus_products'><i class="fa fa-minus"></i></button>
						</div>
						<div class="textbox-qty" style="font-size:20px;border:solid 1px #c8c8c8;backgrund-color:#fb9233">
							<input id='quantity_products' type="text" name="qty" placeholder="100" onkeypress=" return isNumber(event);">
						</div>
						<div class="minus-btn-qty">
							<button id='add_products'><i class="fa fa-plus"></i></button>
						</div>
						<div class="clr"></div>
					</div>
					<div class="social-block-product"></div>
				
				</div>
			</div>
		</div>
		<div class="col-sm-6 border-top-bott" style="margin-top:0;height:100px">
			
			<div class="col-sm-5">
				<div class="total-price-product">
					<span class="total-txt-block" style="padding-top:20px">Total:</span><span class="tatal-amt-block" id='total_amount_block'></span>
				</div>
			</div>
			<div class="col-sm-7">
				<div class="pigi-save-amt-main" style="padding-top:10px">
					<div class="pigi-img-block">
						<img src="<?php echo $base; ?>image/assets/images/pigibank-icon.png" alt="">
					</div>
					<div class="save-amt-block" style="padding-top:0px;padding-left:30px">
						<div class="save-block-product">
							Ahorrás:
						</div>
						<div class="save-amt-count" id="save_amt_count"></div>
					</div>
					
					<div class="buy-btn">
						<a class='prevent_default_buy' href="#">
							<img src="<?php echo $base; ?>image/assets/images/bag-buy-img.png" alt=""> Comprar
						</a>
					</div>
				</div>
			</div>
			<div class="clr"></div>
		</div>
	</div>
	<div class="row">
		<!--  thumbnails slider -->
		<div class="col-sm-6">
			
			<ul id="prod-image-slider" style="align:center;"></ul>
		</div>
	
	
	</div>
	
	
	<div class="col-sm-12">
		<div class="reputetion-block" style="margin-top:30px; font-size:28px; margin-bottom:34px; text-align:center;color: #333;">
			Información del vendedor
		</div>
		<div class="reputation-stars" style="    text-align: center;margin-bottom: 45px;">
			<!---rating-reviews-aa-->
			<?php
			$finalRating = round($rating);
			$color = array();
			$color[1] = "color:#f3190e;";
			$color[2] = "color:#f79f01;";
			$color[3] = "color:#fce51f;";
			$color[4] = "color:#a2e759;";
			$color[5] = "color:#5fb801;";
			
			for($i = 1; $i <= 5; $i++){
				if($finalRating < $i){ ?>
					<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				<?php } else{ ?>
					<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x" style="<?php echo $color[$i]; ?>"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				<?php }
			}
			
			?>
			<!--rating-Reviews-aa-end-->
		</div>
		<div class="cate-reputaion-block">
			<ul>
				<li class="reputetion-li-big-amt">
					<div class="fig-reput-block">
						<!---aa--->
						<?php
						echo ($finalRating / 5 * 100).'%';
						?>
						<!---aa-end--->
					</div>
					<div class="recommend-block">
						De sus compradores lo recomiendan
					</div>
				</li>
				<li class="repu-divi-img-block res-hide-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img.png" alt=""></li>
				<li class="repu-divi-img-block res-show-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img-two.png" alt=""></li>
				<li class="reputetion-li-big-amt">
					<div class="fig-reput-block">
						0
					</div>
					<div class="recommend-block">
						Ventas concretadas
					</div>
				</li>
				<li class="repu-divi-img-block res-hide-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img.png" alt=""></li>
				<li class="repu-divi-img-block res-show-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img-two.png" alt=""></li>
				<li class="reputetion-li-block">
					<div class="recommend-block">
						-
					</div>
					<div class="recommend-block">
						-
					</div>
				</li>
				<li class="repu-divi-img-block res-hide-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img.png" alt=""></li>
				<li class="repu-divi-img-block res-show-divi">
					<img src="<?php echo $base; ?>image/assets/images/reput-divi-img-two.png" alt=""></li>
				<li class="reputetion-li-block">
					<div class="recommend-block" Style="color:orange;text-size:16px;font-weight:bold">
						<?php
						/****vendor account info-aa***/
						$date1 = date("Y-m-d", strtotime($date_added));
						$date2 = date("Y-m-d");
						$diff = abs(strtotime($date2) - strtotime($date1));
						
						$years = floor($diff / (365 * 60 * 60 * 24));
						$months = floor(($diff - $years * 365 * 60 * 60 * 24) / (30 * 60 * 60 * 24));
						$days = floor(($diff - $years * 365 * 60 * 60 * 24 - $months * 30 * 60 * 60 * 24) / (60 * 60 * 24));
						if($years != 0)
							echo $years.'<small> Años </small>'; else if($months != 0)
							echo $months.'<small> Meses </small>'; else if($days != 0)
							echo $days.'<small> Dias </small>'; else
							echo '&nbsp;';
						
						/******aa-ends******/
						?>
					</div>
					<div class="recommend-block">
						Vendiendo en Xcantidad.com
					</div>
				</li>
			</ul>
			<div class="clr"></div>
		</div>
	
	</div>
	
	
	<div class="container">
		<div class="12 col-md-12 col-lg-12">
			<div style="margin-top:95px; font-size:28px; margin-bottom:34px; text-align:center;color: #333;">
				Descripción del producto
			</div>
			<div class="">
				<div class="demo">
					<div id="product-discription">
						<ul class="resp-tabs-list" style="visibility: hidden; margin-top: -48px;">
							<li>Descripción del producto</li>
							<img src="<?php echo $base; ?>image/assets/images/tab-divi.png" alt="">
							<!---review-aa-->
							<?php if($review_status){ ?>
								<li><?php echo $tab_review; ?></li>
							<?php } ?>
							<!---review-aa-end-->
						</ul>
						<div class="resp-tabs-container">
							<div id="prod_desc">
								<p>A new style here at Superette, this long sleeve is a hybrid of two always popular styles, so it's
									bound to be a winner! A similar shape through the body to the Original Neck LS Tee, this has the
									addition of a raw patch pocket on the chest and doesn't have Bassike's signature tail. In an easy to
									wear grey marl, this is great for layering under a jumper, or even put a thermal under the tee if the
									cold winter is getting to you!
								</p>
								<ul class="tab-one-ul">
									<li>Slim fit long sleeve t-shirt with raw neckline</li>
									<li>Raw edge patch pocket on chest</li>
									<li>Raw sleeve and body finish with Bassike signature back neck chainstich</li>
									<li>100% organic cotton superfine jersey</li>
									<li>Machine washable in laundry bag</li>
									<li>Preshrunk so you can tumble dry</li>
								</ul>
							</div>
							
							<div>
								<!--reviews-aa-->
								<?php if($review_status){ ?>
									<div class="tab-pane" id="tab-review">
										<form class="form-horizontal" id="form-review">
											<div id="review"></div>
											<h2><?php echo $text_write; ?></h2>
											<?php if($review_guest){ ?>
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
														<input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control"/>
													</div>
												</div>
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
														<textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
														<div class="help-block"><?php echo $text_note; ?></div>
													</div>
												</div>
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label"><?php echo $entry_rating; ?></label>
														&nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
														<input type="radio" name="rating" value="1"/>
														&nbsp;
														<input type="radio" name="rating" value="2"/>
														&nbsp;
														<input type="radio" name="rating" value="3"/>
														&nbsp;
														<input type="radio" name="rating" value="4"/>
														&nbsp;
														<input type="radio" name="rating" value="5"/>
														&nbsp;<?php echo $entry_good; ?></div>
												</div>
												<?php echo $captcha; ?>
												<div class="buttons clearfix">
													<div class="pull-right">
														<button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
													</div>
												</div>
											<?php } else{ ?><?php echo $text_login; ?><?php } ?>
										</form>
									</div>
								<?php } ?>
								<!--reviews-aa-end-->
							</div>
						</div>
					</div>
				</div>
				
				<div style="margin-top:95px; font-size:28px; margin-bottom:34px; text-align:center;color: #333;">
					Preguntas al vendedor
				</div>
				
				<?php
				if($cust_id == 0)
					echo '<div style="font-size:14px;text-align:center;margin-bottom: 50px;"><a class="prevent_default_link" href="#">Iniciá sesión</a> para hacer preguntas</div>';
				?>
				
				<?php if($cust_id != 0){ ?>
					<form name="ask_question_form" method="post" id="" action="<?php echo $addQuesAction; ?>" class="question-hide-own-seller">
						<div class="textarea-que-block">
							<textarea rows="" cols="" name="question" required placeholder="Hacé tu pregunta..." class="ask-que-area"></textarea>
						</div>
						<div class="donot-txt">
							Sé amable, no ingreses detalles de contacto, ni uses lenguaje vulgar.
						</div>
						<input type="hidden" name="product_id" value="<?php if(isset($_GET['pxs']))
							echo $_GET['pxs']; ?>"/>
						<input type="hidden" name="page_uri" value="<?php echo urlencode($_SERVER['REQUEST_URI']); ?>"/>
						<div class="ask-btn">
							<button type="submit" name="ask_question_btn">Preguntar</button>
						</div>
						<div><?php echo $ask_suc; ?></div>
					</form>
				<?php } ?>
				
				
				<div class="question-block" style="border: 0;margin-top:0">
					<?php
					
					if(isset($que_ans_results['questions']) and $que_ans_results['questions'] != null){
						for($i = 0; $i < sizeof($que_ans_results['questions']); $i++){
							?>
							<div class="first-question">
								<div class="quew-arrow-block">
									<img src="<?php echo $base; ?>image/assets/images/ques-comm-arrow.png" alt="">
								</div>
								<div class="ques-txt-block">
									<?php echo $que_ans_results['questions'][$i]; ?>
									&nbsp;&nbsp;&nbsp;<span><i class="fa fa-calendar"></i> <?php echo $que_ans_results['q_datetime'][$i]; ?>
										<a href="javascript:void(0);" style="color:#000;" class="pull-right reply-link" id="<?php echo $i; ?>">
                                              <i class="fa fa-reply" aria-hidden="true"></i> Contestar
										   </a></span>
								</div>
								<div id="reply_<?php echo $i; ?>" class="reply_form">
									
									<form name="reply_answer_form" method="post" id="" action="<?php echo $addanswerAction; ?>">
										<div class="textarea-que-block">
											<textarea rows="" cols="" name="answer" placeholder="Reply to customer" class="ask-que-area" required></textarea>
										</div>
										<div class="donot-txt">
											Sé amable, no ingreses detalles de contacto, ni uses lenguaje vulgar.
										</div>
										<input type="hidden" name="products_ids" value="<?php if(isset($_GET['pxs']))
											echo $_GET['pxs']; ?>"/>
										<input type="hidden" name="questions_ids" value="<?php echo $que_ans_results['question_id'][$i]; ?>"/>
										<input type="hidden" name="customers_ids" value="<?php echo $que_ans_results['customer_id'][$i]; ?>"/>
										<input type="hidden" name="vendor_id" value="<?php echo $check_vendor_id->row['id']; ?>"/>
										<input type="hidden" name="page_uris" value="<?php echo urlencode($_SERVER['REQUEST_URI']); ?>"/>
										<div class="ask-btn">
											<button type="submit" name="reply_answer_btn">Contestar</button>
										</div>
										<div><?php echo $ask_suc; ?></div>
									</form>
								</div><!--reply end -->
							</div>
							
							<?php
							if(!empty($que_ans_results['answers'][$i])){
								for($k = 0; $k < sizeof($que_ans_results['answers'][$i]); $k++){
									if(!empty($que_ans_results['answers'][$i][$k])){ ?>
										<div class="first-question">
											<div class="ques-txt-block-white">
												<?php echo $que_ans_results['answers'][$i][$k]; ?>
												&nbsp;&nbsp;&nbsp;<span><i class="fa fa-calendar"></i> <?php echo $que_ans_results['a_datetime'][$i][$k]; ?></span>
											</div>
											<div class="quew-arrow-block-white">
												<img src="<?php echo $base; ?>image/assets/images/white-msg-block.png" alt="">
											</div>
										</div>
										<?php
									}
								}
							} else{
								echo '<span style="margin-left:3%;"> Esperando respuesta.</span>';
							}
							?>
							
							<?php
						}
					}
					?>
				</div>
			
			</div>
		</div>
	</div>
	
	<div class="clear5"></div>
	
	<div id='login_model' class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin: 10px;">
					<span aria-hidden="true">&times;</span></button>
				<div class="modal-body">
					
					<div class="col-sm-12 error-login"></div>
					
					<div class="col-sm-12 col-md-12 col-lg-12">
						<div class="clr"></div>
					</div>
					
					
					<div class="col-sm-12 p0" id="quick-login">
						<div class="main-heading col-sm-12">Login</div>
						<div class="clr"></div>
						<p><?php //echo $if_you_have_an_account_with_us; ?></p>
						<div class="form-group required">
							<!--<label for="email"><?php //echo $entry_email; ?> *</label>-->
							<input type="text" name="email" value="" placeholder="E-Mail" id="input-email" class="form-control btn-inp-rad"/>
						</div>
						<div class="form-group required">
							<!--<label for="password"><?php //echo $entry_password; ?> *</label>-->
							<input type="password" name="password" value="" id="input-password" placeholder="Password" class="form-control pass btn-inp-rad"/>
						</div>
						<div class="form-group">
							<button type="button" class="continu loginaccount col-sm-12 btn-reg-rad" data-loading-text="Loading...">
								Login
							</button>
							<span class="pull-left" style="color:black;"><input type="checkbox"/> Don't close session</span>
							<a href="index.php?route=account/forgotten" class="pull-right" style="color:#312783;">
								
								Forget Password ?
							</a>
						</div>
						<div class="clr"></div>
						<div style="border-bottom:1px solid #e5e5e5; height:20px;"></div>
						<br/>
						<div class="" style="color:black;"> Don't have an account?
							<a href="<?php echo $base; ?>index.php?route=account/register" style="color:#312783;">Register here.</a>
						</div>
						<div class="clr" style="height:20px;"></div>
					
					
					</div>
				
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal --></div>
	
	<script>
		$('.reply_form').hide();
		
		var reply_id = '';
		
		
		$(".reply-link").click(function(){
			$('.reply_form').hide();
			reply_id = $(this).attr("id");
			$("#reply_" + reply_id).show();
		});
		
		
		$(".res-find-what").click(function(){
			$(".show-in-mobile").slideToggle("slow");
		});
		
		$('.bxslider').bxSlider(
			{
				nextText: "",
				prevText: ""
			});
		
		
		$('#product-discription').easyResponsiveTabs(
			{
				type: 'default', //Types: default, vertical, accordion
				width: 'auto', //auto or any width like 600px
				fit: true,   // 100% fit in a container
				closed: 'accordion', // Start closed if in accordion view
				activate: function(event){ // Callback function if tab is switched
					var $tab = $(this);
					var $info = $('#tabInfo');
					var $name = $('span', $info);
					$name.text($tab.text());
					$info.show();
				}
			});
		
		$('#verticalTab').easyResponsiveTabs(
			{
				type: 'vertical',
				width: 'auto',
				fit: true
			});
	</script>
	
	<!--Reviews-aa-->
<?php
if(isset($_GET['pxs']))
	$product_id = $_GET['pxs'];
?>
	<script type="text/javascript">
		$('#review').delegate('.pagination a', 'click', function(e){
			e.preventDefault();
			
			$('#review').fadeOut('slow');
			
			$('#review').load(this.href);
			
			$('#review').fadeIn('slow');
		});
		
		$('#review').load('index.php?route=Productdetails/productdtls/review&product_id=<?php echo $product_id; ?>');
		
		$('#button-review').on('click', function(){
			
			$.ajax({
				url: 'index.php?route=Productdetails/productdtls/write&product_id=<?php echo $product_id; ?>',
				type: 'post',
				dataType: 'json',
				data: $("#form-review").serialize(),
				
				success: function(json){
					$('.alert-success, .alert-danger').remove();
					
					if(json['error']){
						$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
					}
					
					if(json['success']){
						$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
						
						$('input[name=\'name\']').val('');
						$('textarea[name=\'text\']').val('');
						$('input[name=\'rating\']:checked').prop('checked', false);
						
					}
				}
			});
		});
	
	
	</script><!------aa-end------->

<?php
echo $footer;
?>