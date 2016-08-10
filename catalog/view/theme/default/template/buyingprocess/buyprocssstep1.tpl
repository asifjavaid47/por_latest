<?php echo $header; ?>
<style>
	.hover-show {
		display: none;
		margin-left: 0px !important;
		margin-top: 0px !important;
	}
	
	.radio_area {
		display: block;
		clear: both;
	}
</style>
<script>
	var modify_address = 0, elements_in_stock = 0, modifying_address_id = 0;
	var product_id_final, total_num_of_images, product_data_matched = 0, quantity_products_val, previous_original_price, this_quantity, product_quantity_final, product_amount_final, discounted_price, discount_available = 0, total_amount, product_original_price;
	var product_all_prices = [];
	var product_amount_final;
	$(document).ready(function(){
		$('#quantity_prod').focus();
		var query = window.location.search.substring(1);
		
		parameters = query.split("&");
		
		split_product_id = parameters[3].split("=");
		product_id = split_product_id[1];
		product_id_final = parseInt(product_id);
		split_product_amount = parameters[1].split("=");
		product_amount = split_product_amount[1];
		split_product_amount_dollar = product_amount.split("$");
		
		product_amount_final = parseInt(split_product_amount_dollar[1]);
		
		split_product_quantity = parameters[2].split("=");
		
		original_amount_one_product = parameters[6].split('=');
		original_amount_one_product = original_amount_one_product[1];
		
		product_quantity = split_product_quantity[1];
		product_quantity_final = parseInt(product_quantity);
		$('#quantity_prod').val(product_quantity_final);
		quantity_products_val = product_quantity_final;
		this_quantity = product_quantity_final;
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
					if(parsed_data['product_details'][0].location){
						$('#product_location').text(parsed_data['product_details'][0].location);
					}
					else{
						$('#product_location').text("No location set!");
					}
					
					//Assign image src to main image
					$('.main_image_link').attr('src', "image/" + product_main_image);
					
					//Append first image with product images slider
					$('#prod-image-slider').append('<li class="active" style="float: none; list-style: none; position: relative; width: 83px; margin-bottom: 20px;"><div class="prod-image"><div class="prod-image-inner"><a href="#" class="prevent_default change_main_image"><img id="imageslider0" src="image/' + product_main_image + '" alt=""/></a></div></div></li>');
					
					//Append quantity text wi in stock
					$('#in_stock_quantity').text(parsed_data['product_details'][0].quantity);
					elements_in_stock = parsed_data['product_details'][0].quantity;
					
					//Append first price in the discounted prices list
					if(1 === product_quantity_final && Math.round(parsed_data['product_details'][0].price) === product_amount_final){
						$('#discounted_prices_list').append('<div class="custom first-table-row"><a class="for_first_price prevent_default change_selected_price hover_selected" selector_attribute = "0" href="#"><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">1</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_details'][0].price) + '</div></a><div class="clr"></div></div>');
						product_data_matched = 1;
					}
					else{
						$('#discounted_prices_list').append('<div class="custom first-table-row"><a class="for_first_price prevent_default change_selected_price" selector_attribute = "0" href="#"><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">1</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_details'][0].price) + '</div></a><div class="clr"></div></div>');
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
								$('#discounted_prices_list').append('<div class="custom first-table-row"><a id="' + product_all_prices[i + 1] + '" class="hover_selected prevent_default change_selected_price first_price" selector_attribute = "' + (i + 1) + '"  href="#" ><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price) + '</div></a><div class="clr"></div></div>');
								product_data_matched = 1;
							}
							else{
								$('#discounted_prices_list').append('<div class="custom first-table-row"><a id="' + product_all_prices[i + 1] + '" class="prevent_default change_selected_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price) + '</div></a><div class="clr"></div></div>');
							}
						}
						else{
							if(Math.round(parsed_data['product_discounts'][i].quantity) === product_quantity_final && Math.round(parsed_data['product_discounts'][i].price) === product_amount_final){
								$('#discounted_prices_list').append('<div class="custom first-table-row"><a id="' + product_all_prices[i + 1] + '_' + product_all_prices[i + 2] + '" class="hover_selected prevent_default change_selected_price first_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price) + '</div></a><div class="clr"></div></div>');
							}
							else{
								$('#discounted_prices_list').append('<div class="custom first-table-row"><a id="' + product_all_prices[i + 1] + '_' + product_all_prices[i + 2] + '" class="prevent_default change_selected_price" selector_attribute = "' + (i + 1) + '" href="#" ><div class="table-logo"><span class="hover-hide">x</span><span class="custom hover-show">x</span></div><div class="custom unit-count-block">' + parsed_data['product_discounts'][i].quantity + '</div><div class="custom price-table-block">$' + Math.round(parsed_data['product_discounts'][i].price) + '</div></a><div class="clr"></div></div>');
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
							$('#product_original_price').text("$" + Math.round(previous_original_price));
							
							//Append with discounted original price
							$('#discounted_original_price').text("$" + Math.round(discounted_price));
							
							//Percentage discount
							discounted_price_remaining = Math.round(parsed_data['product_details'][0].price) - discounted_price;
							discounted_percent = (discounted_price_remaining / Math.round(parsed_data['product_details'][0].price)) * 100;
							
							$('#percentage_discount_value').text(Math.round(discounted_percent) + "% Less!");
							
							saved_amount = discounted_price_remaining * product_quantity_final;
							$('#save_amt_count').text("$" + Math.round(saved_amount));
						}
						
						else{
							$('#discounted_original_price').text("$" + Math.round(parsed_data['product_details'][0].price));
							$('#save_amt_count').text("$0");
						}
					}
					else{
						$('#discounted_original_price').text("$" + Math.round(parsed_data['product_details'][0].price));
						$('#save_amt_count').text("$0");
					}
					
					total_amount = product_amount_final * product_quantity_final;
					
					$('#total_amount_block').text("$" + Math.round(product_amount_final));
					
					
					//////////////////////////////////// Data from product images Start////////////////////////
					number_of_images = parsed_data['product_images'].length;
					
					total_num_of_images = number_of_images;
					
					for(i = 0; i < number_of_images; i++){
						$('#prod-image-slider').append('<li class="" style="float: none; list-style: none; position: relative; width: 83px; margin-bottom: 20px;"><div class="prod-image"><div class="prod-image-inner"><a href="#" class="prevent_default change_main_image"><img id="imageslider' + (i + 1) + '" src="image/' + parsed_data['product_images'][i].image + '" alt=""/></a></div></div></li>');
					}
					//////////////////////////////////// Data from product images Ends////////////////////////
					
					//////////////////////////////////// Data from product Sold Start////////////////////////
					
					$('#items_sold').text(parsed_data['product_sold'] + " sold");
					
					//////////////////////////////////// Data from product Sold Ends////////////////////////
					
					//////////////////Data from product payment methods Start////////////////////////////////
					number_of_payments_methods = parsed_data['product_payment_types_and_discounts'].length;
					if(number_of_payments_methods > 0){
						if(parsed_data['product_payment_types_and_discounts'][0].cash_payment !== ""){
							var cash_discount_val, cash_discount_text_percent;
							if(parsed_data['product_payment_types_and_discounts'][0].cash_discount !== ""){
								cash_discount_val = parsed_data['product_payment_types_and_discounts'][0].cash_discount;
								cash_discount_text_percent = parsed_data['product_payment_types_and_discounts'][0].cash_discount + "%";
							}
							else{
								cash_discount_val = 0;
								cash_discount_text_percent = "";
							}
							$('.check-box-container').append('<div class="check-one-bx"><div class="check-bx"><input type="checkbox" name="radiog_dark" id="radio5" class="css-checkbox" value="' + cash_discount_val + '"><label for="radio5" class="css-label radGroup2">Cash Discount <span>' + cash_discount_text_percent + '</span></label></div><div class="clr"></div></div>');
						}
						
						if(parsed_data['product_payment_types_and_discounts'][0].wire_payment !== ""){
							var wire_discount_val, wire_discount_text_percent;
							if(parsed_data['product_payment_types_and_discounts'][0].wire_discount !== ""){
								wire_discount_val = parsed_data['product_payment_types_and_discounts'][0].wire_discount;
								wire_discount_text_percent = parsed_data['product_payment_types_and_discounts'][0].wire_discount + "%";
							}
							else{
								wire_discount_val = 0;
								wire_discount_text_percent = "";
							}
							$('.check-box-container').append('<div class="check-one-bx"><div class="check-bx"><input type="checkbox" name="radiog_dark" id="radio6" class="css-checkbox" value="' + wire_discount_val + '"><label for="radio6" class="css-label radGroup2">Wire Discount <span>' + wire_discount_text_percent + '</span></label></div><div class="clr"></div></div>');
						}
						
						if(parsed_data['product_payment_types_and_discounts'][0].credit_card_payment !== ""){
							var cc_discount_val, cc_discount_text_percent;
							if(parsed_data['product_payment_types_and_discounts'][0].credit_card_discount !== ""){
								cc_discount_val = parsed_data['product_payment_types_and_discounts'][0].credit_card_discount;
								cc_discount_text_percent = parsed_data['product_payment_types_and_discounts'][0].credit_card_discount + "%";
							}
							else{
								cc_discount_val = 0;
								cc_discount_text_percent = "";
							}
							$('.check-box-container').append('<div class="check-one-bx"><div class="check-bx"><input type="checkbox" name="radiog_dark" id="radio7" class="css-checkbox" value="' + cc_discount_val + '"><label for="radio7" class="css-label radGroup2">Credit Card Discount <span>' + cc_discount_text_percent + '</span></label></div><div class="clr"></div></div>');
						}
						$('.check-box-container').append('<div class="check-one-bx"><div class="check-bx"><input type="checkbox" name="radiog_dark" id="radio9" class="css-checkbox"  value="0"><label for="radio9" class="css-label radGroup2">Agree with the Seller</label></div><div class="clr"></div></div>');
					}
					else{
						$('.check-box-container').text("No Payment Methods defined for this product");
						$('.check-box-container').append('<div class="check-one-bx"><div class="check-bx"><input type="checkbox" name="radiog_dark" id="radio9" class="css-checkbox"  value="0"><label for="radio9" class="css-label radGroup2">Agree with the Seller</label></div><div class="clr"></div></div>');
					}
					
					//////////////////Data from product payment methods End ////////////////////////////////
					
					for(i = 0; i < product_all_prices.length; i++){
						if(i === (product_all_prices.length - 1)){
							if(quantity_products_val >= product_all_prices[i]){
								$('.hover_selected').removeClass('hover_selected');
								$('#' + product_all_prices[i]).addClass('hover_selected');
								//this_quantity_original = $('#'+product_all_prices[i])[0].children[1].innerHTML;
								
								//this_amount_splitted = $('#'+product_all_prices[i])[0].children[2].innerHTML.split('$');
								//this_amount = parseInt(this_amount_splitted[1]);
								
							}
						}
						else{
							if(quantity_products_val >= product_all_prices[i] && quantity_products_val < product_all_prices[i + 1]){
								$('.hover_selected').removeClass('hover_selected');
								$('#' + product_all_prices[i] + '_' + product_all_prices[i + 1]).addClass('hover_selected');
								
								//this_quantity_original = $('#'+product_all_prices[i]+'_'+product_all_prices[i+1])[0].children[1].innerHTML;
								//this_amount_splitted = $('#'+product_all_prices[i]+'_'+product_all_prices[i+1])[0].children[2].innerHTML.split('$');
								//this_amount = parseInt(this_amount_splitted[1]);
							}
						}
					}
					
					
				}
			});
		
		$('.prevent_default').click(function(e){
			e.preventDefault();
		});
		
		$('.change_main_image').click(function(e){
			
			
			$('.bxslider > .active').removeClass('active');
			$(this).parents().eq(2).addClass('active');
			//$(this).addClass('active');
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
			}
		});
		
		$('.bx-next').click(function(){
			for(i = total_num_of_images; i >= 0; i--){
				temp = $('#imageslider' + (i + 1)).attr('src');
				$('#imageslider' + (i + 1)).attr('src', $('#imageslider' + i).attr('src'));
				$('#imageslider' + i).attr('src', temp);
			}
		});
		
		var acceptable_value = 0;
		$("#quantity_prod").on("change paste keyup", function(){
			quantity_products_val = $('#quantity_prod').val();
			if(parseInt(elements_in_stock) < parseInt(quantity_products_val)){
				$('#quantity_prod').val(acceptable_value);
				return false;
			}
			else{
				acceptable_value = $('#quantity_prod').val();
				$('.q-m').html(quantity_products_val);
				change_product_details_with_plus_minus(quantity_products_val);
			}
		});
		
		// $('#minus_product').click(function(e)
		// {
		// quantity_products_val = $('#quantity_prod').val();
		// if(quantity_products_val < 1)
		// {
		// $('.hover_selected').removeClass('hover_selected');
		// }
		// else
		// {
		// quantity_products_val--;
		// $('#quantity_prod').val(quantity_products_val);
		// change_product_details_with_plus_minus(quantity_products_val);
		// e.preventDefault();
		// }
		// });
		// $('#plus_product').click(function(e)
		// {
		
		// quantity_products_val = $('#quantity_prod').val();
		// quantity_products_val++;
		// $('#quantity_prod').val(quantity_products_val);
		// change_product_details_with_plus_minus(quantity_products_val);
		// });
		
		
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
								this_amount = parseInt(this_amount_splitted[1]);
								
							}
						}
						else{
							if(quantity_products_val >= product_all_prices[i] && quantity_products_val < product_all_prices[i + 1]){
								$('.hover_selected').removeClass('hover_selected');
								$('#' + product_all_prices[i] + '_' + product_all_prices[i + 1]).addClass('hover_selected');
								
								this_quantity_original = $('#' + product_all_prices[i] + '_' + product_all_prices[i + 1])[0].children[1].innerHTML;
								this_amount_splitted = $('#' + product_all_prices[i] + '_' + product_all_prices[i + 1])[0].children[2].innerHTML.split('$');
								this_amount = parseInt(this_amount_splitted[1]);
							}
						}
					}
					this_quantity = quantity_products_val;
					//discounted_price = this_amount / this_quantity_original;
					discounted_price = this_amount;
					total_for_plus_minus = Math.round(discounted_price * this_quantity);
					$('.t-m').text("$" + Math.round(total_for_plus_minus));
					$('.t-a').text("$" + Math.round(total_for_plus_minus));
					$('#total_price_amount').text("$" + Math.round(total_for_plus_minus));
					total_amount = total_for_plus_minus;
					total_tax = total_amount * 10 / 100;
					$('.c-d').html(total_tax);
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
					this_type_discount_value = payment_type_checked[0].value;
					
					percent_10_value = (total_amount * this_type_discount_value) / 100;
					final_total_value = total_amount - percent_10_value;
					
					$('#total_amount_block').text("$" + Math.round(final_total_value));
					
					equal_discount_value = percent_10_value / this_quantity;
					previous_original_price = Math.round(previous_original_price - equal_discount_value);
					
					discounted_price_final = Math.round(final_total_value / this_quantity);
					
					if(discounted_price !== product_original_price){
						//////////////////Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price));
						
						/////////////////Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price_final));
						
						//////////////Percentage discount
						discounted_price_remaining = product_original_price - discounted_price_final;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% Less!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount));
					}
					
					else{
						$('#product_original_price').text("$" + Math.round(product_original_price));
						
						discounted_new_value = Math.round(final_total_value / this_quantity);
						$('#discounted_original_price').text("$" + Math.round(discounted_new_value));
						
						/////////////Percentage discount
						discounted_price_remaining_new = product_original_price - discounted_new_value;
						discounted_percent_new = (discounted_price_remaining_new / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent_new) + "% Less!");
						
						$('#save_amt_count').text("$" + Math.round((product_original_price - discounted_new_value)));
					}
					
					$('.t-m').text("$" + Math.round(total_for_plus_minus));
					if(discounted_price !== product_original_price){
						/////////////////Append Original price text
						$('#product_original_price').text("$" + Math.round(previous_original_price));
						
						/////////////////Append with discounted original price
						$('#discounted_original_price').text("$" + Math.round(discounted_price));
						
						//////////Percentage discount
						discounted_price_remaining = product_original_price - discounted_price;
						discounted_percent = (discounted_price_remaining / product_original_price) * 100;
						
						$('#percentage_discount_value').text(Math.round(discounted_percent) + "% Less!");
						
						saved_amount = discounted_price_remaining * this_quantity;
						$('#save_amt_count').text("$" + Math.round(saved_amount));
					}
					
					else{
						$('#product_original_price').text("");
						$('#discounted_original_price').text("$" + Math.round(product_original_price));
						$('#percentage_discount_value').text("");
						$('#save_amt_count').text("$0");
					}
					
				}
			}
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
		$()
	});
	function isNumber(evt){
		var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
		if(iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
			return false;
		}
		return true;
	}
</script>
<script type="text/javascript">
	var check_radio_checkbox_val = '';
	
	function goToForthStep(){
		if(check_radio_checkbox_val != ''){
			
			$('.select-one-delivery-m').hide();
			
			$('.nav-tabs a[href="#review_purchase"]').tab('show');
			$('#leftbar').show();
			$("#step-four").removeClass("not-active");
			price = original_amount_one_product;
			
			quantity = $('.q-m').html();
			orignal_price = $("#sub_total").html();
			orignal_price = orignal_price.split('<sup>');
			orignal_price = orignal_price[0].split('$');
			total_res = Math.round(price * quantity);
			total = total_res - orignal_price[1];
			$(".big-txt").html("Ahorraste $" + total);
		}
		else{
			$('.select-one-delivery-m').show();
			return false;
		}
	}
	
	$(document).ready(function(){
		var allowed_to_go_back_to_price_step = 1;
		var selectedVal = "";
		$(".rad").click(function(){
			var selected = $("input[type='radio'][name='payment_method']:checked");
			if(selected.length > 0){
				selectedVal = selected.val();
			}
			$("#confirmQuantityContinue").click(function(){
				
			});
		});
		
		$("#confirmQuantityContinue").click(function(){
			allowed_to_go_back_to_price_step = 0;
			$('.nav-tabs a[href="#payment_method_tab"]').tab('show');
			$('#leftbar').show();
			$("#step-two").removeClass("not-active");
		});
		
		$("#payMethodContinue").click(function(){
			$('.nav-tabs a[href="#delivery_method"]').tab('show');
			$('#leftbar').show();
			$("#step-three").removeClass("not-active");
		});
		
		
		$('.radio-1-check').on('change', function(){
			check_radio_checkbox_val = this.checked ? this.value : 'Acordar con el vendedor ';
		});
		
		$('.radio-2-check').on('change', function(){
			check_radio_checkbox_val = this.checked ? this.value : 'Mediante Tarjeta de crédito';
		});
		
		$('.check-xenvios-box').on('change', function(){
			check_radio_checkbox_val = this.checked ? this.value : 'Mediante Xpagos ';
		});
		
		$('.radio-1-check').click();
		
		
		$('.select-one-delivery-m').hide();
		
		$("#shipMethodContinue").click(function(){
			if($('#new_address:visible').length){
				vendordetail();
			}
			else{
				goToForthStep();
			}
		});
		
		
		$('#step-one').click(function(){
			if(allowed_to_go_back_to_price_step === 0){
				return false;
			}
		});
	});
</script>
<style>
	.not-active {
		pointer-events: none;
		cursor: pointer;
	}
	
	.active {
		color: #404040 !important;
	}
</style>
<div class="container">
	<div class="row">
		<div id='whole_container_buy_process' class="col-sm-8 midbox">
			<div class="buying-process-main"></div>
			<form name="ship_method" method="post" action="" class="addOrderForm">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs listing-tabs" role="tablist" style="background-color:#e6ebf5">
					<li role="presentation" class="active no-clickable" id="step-one">
						<a href="#confirm_quantity" aria-controls="confirm_quantity" role="tab" data-toggle="tab" style="z-index:2; color:inherit !important">
							Cantidad y precio
						</a>
					</li>
					<li role="presentation" class="not-active clickable" id="step-two">
						<a href="#payment_method_tab" aria-controls="payment_method_tab" role="tab" data-toggle="tab" style="z-index:2; color:inherit;">
							Pago
						</a>
					</li>
					<li role="presentation" class="not-active clickable" id="step-three">
						<a href="#delivery_method" aria-controls="delivery_method" role="tab" data-toggle="tab" style="z-index:2; color:inherit;">
							Entrega
						</a>
					</li>
					<li role="presentation" class="not-active clickable" id="step-four">
						<a href="#review_purchase" aria-controls="review_purchase" role="tab" data-toggle="tab" style="z-index:2; color:inherit;">
							Revisá tu pedido
						</a>
					</li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content col-sm-12 no-padding" style="background-color:white; text-align:center;min-height:100px;border:solid 1px #ddd">
					<?php
					
					/*echo 'Precio Unit: '.$unit_price;*/
					$subtotal = round($unit_price * $quantity);
					$discount_amount = round($discount / 100 * $subtotal);
					$discounted_total = $subtotal - $discount_amount;
					/*$total = ($subtotal - $discount_amount) + $ship_charges;*/
					
					if($cust_id == 0)
					echo 'Tenés que <a href="javascript:void(0);" class="login-reuired" style="font-weight:bold">Ingresár</a> para poder comprar.';
					else if($is_product_selected == 0)
					echo '! Por favor, debés <a href="?route=product/category">seleccionár</a> un producto.';
					else if($quantity == 0)
					echo 'Por favor, primero debés <a href="?route=Productdetails/productdtls&amount=$0&quantity=0&pxs='.$product_id.'">seleccionár</a> una cantidad.';
					else{
					?>
					<div role="tabpanel" class="tab-pane active" id="confirm_quantity">
						<style>
							.no-padding {
								padding-left: 0;
								padding-right: 0;
							}
						</style>
						<div class="col-sm-8 no-padding">
							<div class="delivery-method-bx">
								<div class="main-heading">Confirmá cantidad y precio </span></div>
								<!--Quantity-->
								<div style="text-align:center;padding-top:25px">

												<span> Cantidad <input type="text" id="quantity_prod" style="font-size:16px; font-weight:bold; color:#312782;border:1px solid; border-radius: 3px; height:30px;width:50px;text-align:center; margin:0px 10px" onkeypress=" return isNumber(event);" name="qty" placeholder="100" value="">
													
													Unidades</span>
								</div>
								<!--div class="total-price">
									<span id='total_label'>Total</span>
									<span id='total_price_amount'></span>
								</div-->
								<div style="text-align:center;padding-top:10px">
									<span>Stock disponible </span>
									<span class="red-price" id='in_stock_quantity'></span>
									<span>unidades. </span>
									<i class="fa fa-check-circle" style="color:green;font-size:16px"></i></span>
								</div>
								<div style="text-align:center;margin-top:75px">
									<button class="continu" id="confirmQuantityContinue" type="button">Confirmar</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-4 pull-right no-padding" id='leftbar'>
						<div class="total-box" style="background-color:#f0f0f0">
							<?php
							if($is_product_selected == 0)
								echo '! Please <a href="?route=product/category">Select</a> a product before.'; else if($quantity == 0)
								echo '! Please <a href="?route=Productdetails/productdtls&amount=$0&quantity=0&pxs='.$product_id.'">Select</a> a quantity before.'; else{
								?>
								<div style="border:solid 1px #c8c8c8">
									<img src="<?php echo $thumb; ?>" alt="">
								</div>
								<div class="tot-title text-center " style="color:#312782"><?php echo $product_name; ?></div>
								<div class="qty-box " id='bill_summery1' style="background-color:inherit;">
									<table style="font-size:12px; margin:5px auto !important;float:none !important;">
										<tbody>
										<tr style="height: 25px">
											<td>Cantidad</td>
											<td class="r-m q-m" id="product_quantity"><?php echo $quantity; ?></td>
										</tr>
										<tr style="height: 25px">
											<td>Subtotal</td>
											<td class="r-m t-m" id="sub_total">$<?php echo $subtotal; ?><sup>00</sup></td>
										</tr>
										<!--<tr><td >-<?php //echo $discount;
										?> % Cash</td> <td class="rr-m c-d" id="cash_discount">-$<?php echo $discount_amount; ?> <sup style="font-size: 14px;">00</sup></td> </tr>-->
										<tr style="height: 25px;border-bottom:solid 1px #c8c8c8">
											<td>Envío</td>
											<td class="r-m">
												<span id="shipChargesRes"></span>
											</td>
										</tr>
										<tr>
											<td style="padding-top:10px!important;color:#202020">Total
											</td>
											<td class="createlst-tittle" style="font-size: 18px !important; text-align: center ">
												<span class="t-a" id="totalAmount"></span>
											</td>
										</tr>
										</tbody>
									</table>
								</div>
								<div class="custom ">
									<div class="unit-price-product-block step-one-unit-table">
										<!--div class="table-logo">
											&nbsp;
										</div-->
										<div class="product-unit-block">
											Cantidad
										</div>
										<div class="price-product-block">
											Precio
										</div>
										<div class="clr"></div>
									</div>
									<div id='discounted_prices_list'></div>
								</div>          <?php
							}
							?>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="payment_method_tab">
						<div class="col-sm-8 >
					<div class=" delivery-method-bx
						">
						<div class="main-heading">Método de pago</div>
						<div class="col-sm-8 midbox" style="margin-top:30px">
							<ul style="margin-left:0px">
								<li style="text-align:left">
									<div class="radio_area delivery-m">
										<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" required checked/>&nbsp;
										Voy a acordar con el vendedor
									</div>
									<div class="radio_area delivery-m" style="color:#c8c8c8">
										<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled/>
										&nbsp; Mediante Tarjeta de credito
									</div>
									<div class="radio_area delivery-m" style="color:#c8c8c8">
										<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled/>
										&nbsp; Mediante
										Xpagos
									</div>
								</li>
							</ul>
							<!--<div class="radio_area payment-radio">
			                                            <?php
							if($credit_card_payment != ''){
								?>

			                                            <?php
							}
							?>
			                                            </div>
			<div class="radio_area payment-radio">
			                                            <?php
							if($credit_card_payment != ''){
								?>

			                                                <ul style="margin-left:0px;">
			                                                    <li>
			                                                        <label>
			                                                       <div class="radio_area delivery-m">
			                                                     <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" required checked />&nbsp; I will agree with seller
			                                                 </div>
			                                                 <div class="radio_area delivery-m">
			                                                <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled /> &nbsp; Credit card
			                                                 </div>
			                                                 <div class="radio_area delivery-m">
			                                                <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled /> &nbsp;  Use Xpagos
			                                                 </div>

			                                                        </label>
			                                                    </li>

			                                                </ul>
			                                            <?php
							}
							?>
			                                            </div>
			                                            <div class="radio_area payment-radio">
			                                            <?php
							if($cash_payment != ''){
								?>
			                                                <label>
			                                                <?php if($payment_method == 'cash'){
									
									?>

			                                                <?php
								} else{
									?>

			                                                <?php
								}
								?>


			                                            <?php
							}
							?>
			                                            </div>

			                                            <div class="radio_area payment-radio">

			                                            <?php
							if($wire_payment != ''){
							?>
			                                                <label>
			                                                    <?php if($payment_method == 'wire'){ ?>
			                                                    <!--<div class="radio_area delivery-m">
			                                                     <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" required checked />&nbsp; I will agree with seller
			                                                 </div>
			                                                 <div class="radio_area delivery-m">
			                                                <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled /> &nbsp; Credit card
			                                                 </div>
			                                                 <div class="radio_area delivery-m">
			                                                <input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled /> &nbsp;  Use Xpagos
			                                            </div>--> <?php
							} else{
								?>
								<div class="radio_area delivery-m">
									<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" required checked/>&nbsp;
									Acordar con el vendedor
								</div>
								<div class="radio_area delivery-m">
									<div>
										<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled s/>
										&nbsp; Mediante Tarjeta de credito
									</div>
								</div>
								<div class="radio_area delivery-m">
									<input type="radio" value="<?php echo $cash_discount.'% Cash discount!'; ?>" id="payment_method" name="payment_method" disabled/>
									&nbsp; Mediante Xpagos
								</div>      <?php
							}
							?>
							
							
							<?php
							}
							?>
						</div>
						-->
						<div style="text-align:center;margin-top:70px">
							<button class="continu rad" type="button" id="payMethodContinue">Continuar</button>
						</div>
					</div>
				</div>
		</div>
		<div role="tabpanel" class="tab-pane " id="delivery_method">
			<div class="col-sm-8">
				<div class="delivery-method-bx">
					<div class="main-heading">Método de entrega</div>
					<span class="resp"></span>
					<input type="hidden" id="cust_id" name="cust_id" value="<?php echo $cust_id; ?>"/>
					<input type="hidden" id="product_id" name="product_id" value="<?php echo $product_id; ?>"/>
					<input type="hidden" id="quantity" name="quantity" value="<?php echo $quantity; ?>"/>
					<input type="hidden" id="unit_price" name="unit_price" value="<?php echo $unit_price; ?>"/>
					<input type="hidden" id="discount" name="discount" value="<?php echo $discount; ?>"/>
					<input type="hidden" class="shipping_charges" name="shipping_charges" value="" id="shipChargesInput"/>
					<input type="hidden" class="total" name="total" value="" id="totalAmountInput"/>
					<input type="hidden" class="vendor_id" name="vendor_id" value="<?php echo $vendor_id; ?>" id="vendor_id"/>
					<div>
						<ul style="margin:25px auto !important;float:none !important;">
							<li style="text-align:left">
								<?php
								if(!empty($buyer_shipping)){
									?>
									<div class="radio_area delivery-m">
										<input type="hidden" id="shipping_method" value="Vendor will ship and buyer will pay" name="shipping_method"/>
									</div>
									<div class="radio_area delivery-m">
										<input type="radio" name="radiog_lite" id="radio1" class="radio-1-check" value="I will pick up the item">
										&nbsp;Voy a retirar en persona <?php echo "(".$city_province.")"; ?>
										<!-- <span class="subt-txt-rdo">Only week days from 8:00 am to 5:00 pm</span>-->
									</div>
									<div style="color:#a0a0a0"> Recibirás los datos del vendedor al finalizar este proceso
									</div>                  <?php
								} else{
									?>
									<div class="radio_area delivery-m">
									<input type="radio" name="radiog_lite" id="radio1" class="radio-1-check" value="I will pick up the item">
									&nbsp;Voy a retirar en
									persona<?php echo "(".$counrty_name[0]['state'].',&nbsp '.$counrty_name[0]['city'].")"; ?>
									</div><?php
								}
								
								if(!empty($vendor_shipping))
								{
									?>
									<div class="radio_area delivery-m">
										<input type="radio" name="radiog_lite" id="radio12" class="radio-2-check" value="I will agree with vendor">
										&nbsp; Voy a arreglar con el vendedor
									</div>
									<ul class="other-extra " style="display:none; padding-top:0px;padding-left:0px" id='address_drop_down'>
										<div class="radio_area delivery-m">
											<li style="color:#838383; padding-left:0;margin-top=0px" class="p0">Selecciona tu dirección de
												entrega.
											</li>
										</div>
										<?php
										$have_address = 0;
										if(!empty($get_address)){ ?>
											<div class="col-sm-12 p0">
												<select class="form-control vendor-sec-address maximize shipAddress" name="sec_address">
													<?php foreach($get_address as $key => $option_addr){
														if($option_addr['use_as'] != "" && strpos($option_addr['use_as'], 'Delivery')){ ?>
															<option class='address_get' value="<?php echo $key; ?>" data-address="<?php echo $option_addr; ?>" data-radius="<?php echo $radius; ?>" data-shippCharges="<?php echo $own_shipping_price; ?>" data-discountedTotal="<?php echo $discounted_total; ?>" data-vendorId="<?php echo $vendor_id; ?>" selected="selected"><?php echo $option_addr; ?></option>                              <?php } else{ ?>
															<option class='address_get' value="<?php echo $key; ?>" data-address="<?php echo $option_addr; ?>" data-radius="<?php echo $radius; ?>" data-shippCharges="<?php echo $own_shipping_price; ?>" data-discountedTotal="<?php echo $discounted_total; ?>" data-vendorId="<?php echo $vendor_id; ?>"><?php echo $option_addr; ?></option>                              <?php }
														$have_address++;
													} ?>
												</select>
											</div>
											<div class="col-sm-12 p0" style="text-align: center;">
												<a href='javascript:void(0);' class="btn btn-primary" id="newaddress" style="margin: 10px 0;">
													Usar otra
													dirección
												</a>
											</div>
										<?php } ?>
									</ul>
									<div id="new_address" style="margin: 10px 15px">
									<div class="row">
										<div class="form-group col-sm-8 p0">
											<input name="address_1" type="text" class="form-control vendor-new-address" value="" placeholder="Calle" id="input-address-1"/>
											<span class="text-muted"><?php echo $step_vendor_street_ex; ?></span><?php if($error_userdet_address_1){ ?>
												<div class="text-danger span-vendor-new-address"><?php echo $error_userdet_address_1; ?></div><?php } ?>
										</div>
										<div class="form-group col-sm-4 p0" style="padding-left: 15px;">
											<input type="text" class="form-control nomandatory vendor-new-door-number" name="doornumber" value="" placeholder="Número" id="input-number" onkeypress=" return isNumber(event);"/>
											<span class="text-muted"><?php echo $step_vendor_door_num_ex; ?></span><?php if($error_userdet_doornumber){ ?>
												<div class="text-danger span-vendor-new-door-number"><?php echo $error_userdet_doornumber; ?></div><?php } ?>
										</div>
									</div>
									<div class="row">
										<input type="checkbox" class="pull-left no-number-checkbox" style="display: none;" id="vendor_no_number"/>
										<div class="col-sm-4 form-group p0">
											<input type="text" class="form-control nomandatory vendor-new-floor" placeholder="Piso" name="floor" value="" id="input-floor"/>
											<span class="text-muted">Piso</span>
										</div>
										<div class="col-sm-4 pr0 form-group">
											<input type="text" class="form-control nomandatory vendor-new-apt" placeholder="Departamento" name="apartment" value="" id="input-apartment"/>
											<span class="text-muted">Departamento</span>
										</div>
										<div class="col-sm-4 pr0 form-group">
											<!--<label for="zip"><?php echo $zipcode_labl; ?> *</label>-->
											<input type="text" name="postcode" value="" class="form-control nomandatory vendor-new-postcode" placeholder="Código postal" id="input-postcode"/>
											<span class="text-muted"><?php echo $user_zip_labl; ?></span>
											<a target="_blank" href="http://www.andreani.com/buscador-de-codigos-postales-resultado" class="input_opt" style="display: block;">
												No se mi código
											</a><?php if($error_userdet_postcode){ ?>
												<div class="text-danger span-vendor-new-postcode"><?php echo $error_userdet_postcode; ?></div><?php } ?>
										</div>
										<input id="address_hidden" type="hidden" name="new_address_condition" value="0" class="address_hidden">
										<div class="form-group col-sm-9 height_75 p0" style="display: none;">
											<select name="country_id1" id="input-country1" class="form-control vendor-input-country">
												<option value=""><?php echo $text_select; ?></option><?php foreach($countries as $country){ ?><?php if($country['country_id'] == $country_id){ ?>
													<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option><?php } else{ ?>
													<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option><?php } ?><?php } ?>
											</select>
											<span class="text-muted"><?php echo $step_vendor_country_ex; ?></span>
											<div class="text-danger span-vendor-input-country"><?php echo $error_userdet_country; ?></div>
										</div>
										<div class="form-group col-sm-12 height_75 p0">
											<select name="provience_id1" id="provience_id1" class="form-control vendor-province-id">
												<option value=""><?php echo $text_select; ?></option><?php foreach($provience as $country){ ?><?php if($country['id'] == $country_id){ ?>
													<option value="<?php echo $country['id']; ?>" selected="selected"><?php echo $country['provincia']; ?></option><?php } else{ ?>
													<option value="<?php echo $country['id']; ?>"><?php echo $country['provincia']; ?></option><?php } ?><?php } ?>
											</select>
											<span class="text-muted"><?php echo $step_vendor_province_ex; ?></span>
											<div class="text-danger span-vendor-province-id"><?php echo $error_userdet_country; ?></div>
										</div>
										<div class="form-group col-sm-12 height_75 p0">
											<select name="city" id="input-city1" class="form-control vendor-input-city"></select>
											<span class="text-muted"><?php echo $step_vendor_cty_ex; ?></span>
											<div class="text-danger span-vendor-input-city"><?php echo $error_userdet_city; ?></div>
										</div>
										<div class="col-sm-12 p0" style="text-align: center;">
											<a href="javascript:void(0);" class="no-need-new-address btn btn-primary">Cancelar</a>
										</div>
									</div>
									<a href="javascript:void(0)" class="btn btn-primary save_address" style="display: none;">Guardar
										dirección
									</a>
									
									
									</div><?php
								}
								
								else
								{
								?>
								<div class="radio_area delivery-m" style="color:#c8c8c8">
									<input type="radio" name="radiog_lite" id="radio12" class="radio-2-check" value="I will agree with vendor" disabled>
									&nbsp; Voy a arreglar con el vendedor <?php
									}
									
									if(!empty($xenvios_shipping))
									{
									?>
									<div class="radio_area delivery-m" style="color:#c8c8c8">
										<input type="radio" name="radiog_lite" class="css-label radGroup1 check-xenvios-box" id="radio1" value="Use Xenvios" disabled>
										&nbsp;Usar Xenvios <?php
										} else{
											?>
											<div class="radio_area delivery-m" style="color:#c8c8c8">
												<input type="radio" name="radiog_lite" class="css-label radGroup1 check-xenvios-box" id="radio1" value="Use Xenvios" disabled>
												&nbsp;Usar Xenvios
											</div>      <?php
										}
										?><span class="select-one-delivery-m " style="color:red;">Tenés que seleccionar una opcion.</span>
							</li>
						</ul>
					</div>
					<div style="text-align:center;margin-top:30px">
						<button class="continu" id="shipMethodContinue" name="shipMethod" type="button">Continuar</button>
					</div>
				</div>
			</div>
		</div>
		<div role="tabpanel" class="tab-pane" id="review_purchase">
			<div class="col-sm-8">
				<div class="delivery-method-bx">
					<div class="main-heading">Revisá tu pedido</div>
					<div class="review-perices" style="text-align:center">
						<div class="item-section-title">Artículo:</div>
						<br/>
						<div class="item-section-right">
							<img class="rev-img" alt="" src="<?php echo $thumb; ?>" width="100" height="100">
							<div class="info-sec">
								<!--<h4><?php echo $product_name; ?></h4>-->
								<!-- <div class="items-price">100 items <span>$15000</span><div class="modify-txt"><a href="#">Modify</a></div></div>

						--> </div>
						</div>
						<div style="font-size:14px;color:#312782">
							<?php echo $product_name; ?>
							<br/>
							<?php echo  'Calle: &nbsp;', $product_address_street, '&nbsp;', $product_door_number, '&nbsp; Piso:',$product_address_floor, '&nbsp; Departamento:', $product_address_apartment;?>
							
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-1">&nbsp;</div>
					<div class="col-lg-10">
						<div class="item-section-right">
							<!-- <div class="radio_area review-per">
									<input type="radio" class="css-checkbox" id="radio13" name="radiog_lite">
									<label class="css-label radGroup1" id='cash_method' for="radio13">Cash 10% Discount
											<div class="modify-txt"><a href="#">Modify</a></div>
									 <span> -$1500<sup>00</sup></span>
									 </label>

							 </div> >
							 <div class="col-w-195">
								 <div class="qty-box box-rev-table" id='bill_summery'>


								 </div-->
						</div>
						<div class="createlst-tittle" style="text-align:center;margin-bottom:35px">Precio total
							$<?php echo $discount_amount; ?> </div>
						<!-- INTENTO DE COMPROBACION DE LOS DATOS DE LA COMPRA
							2 checkbox con los datos de los radios seleccionados en el paso 2 y 3

						<div><input type="checkbox"><span id="check_radio_checkbox_val.value"></span></div>-->
					</div>
				</div>
			</div>
			<div style="text-align:center;">
				<button id='last_continue' class="continu" type="button">Continuar</button>
			</div>
		</div>
	</div>
	<?php
	}
	?>
</div>      </ul>      </li>    </ul>  </div></div></div></form><!-- bootstrap tabs end -->
<div class="clr"></div>
<div class="container">
	<div id='final_description_container_buy_process' class="col-sm-8 midbox" style="display:none">
		<div class="row">
			<i class="fa fa-check-square-o" aria-hidden="true" style="color:green;font-size:20px"></i>
			<span class="main-heading">Felicitaciones por tu compra!</span>
			<p class="text-muted">Solo queda que te comuniques con el vendedor para arreglar el envío y pago.</p>
			<p class="text-muted"><?php echo  'Calle: &nbsp;', $product_address_street, '&nbsp;', $product_door_number, '&nbsp; Piso:',$product_address_floor, '&nbsp; Departamento:', $product_address_apartment;?></p>
			<div class="col-sm-12" style="border:solid 2px #c8c8c8;border-radius:5px;background-color:white">
				<div style="font-size:14px">
					<div>
						<span>Vendedor: </span><span style="color:#404040;text-transform:capitalize;font-weight:bold" id='finalization_vender_name'></span>
					</div>
					<div>
						<span>Teléfono: </span><span style="color:#404040;text-transform:capitalize;font-weight:bold" id='finalization_vender_phone'></span>
					</div>
					<div><span>Email: </span><span style="color:#404040;font-weight:bold" id='finalization_vender_email'></span>
					</div>
					<div></span><span style="color:#404040"
						<p id='finalization_vender_description'></p>
					</div>
				</div>
			</div>
			<br/>
			<div style="text-align:center;">
				<button id='finalized_last_continue' class="continu" type="button">Continuar</button>
			</div>
		</div>
	</div>
</div></div><!--Login Modal start-->
<div id='login_model' class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin:10px">
				<span aria-hidden="true">&times;</span></button>
			<div class="modal-body">
				<div class="col-sm-12 error-login"></div>
				<div class="col-sm-12 col-md-12 col-lg-12">
					<div class="clr"></div>
				</div>
				<div class="col-sm-12 p0" id="quick-login">
					<div class="main-heading col-sm-12">Ingresar</div>
					<div class="clr"></div>
					<p><?php //echo $if_you_have_an_account_with_us; ?></p>
					<div class="form-group required">
						<!--<label for="email"><?php //echo $entry_email; ?> *</label>-->
						<input type="text" name="email" value="" placeholder="E-Mail" id="input-email" class="form-control btn-inp-rad"/>
					</div>
					<div class="form-group required">
						<!--<label for="password"><?php //echo $entry_password; ?> *</label>-->
						<input type="password" name="password" value="" id="input-password" placeholder="Contraseña" class="form-control pass btn-inp-rad"/>
					</div>
					<div class="form-group">
						<button type="button" class="continu loginaccount col-sm-12 btn-reg-rad" data-loading-text="Loading...">
							Ingresar
						</button>
						<span class="pull-left" style="color:black;"><input type="checkbox"/> No cerrar sesión</span>
						<a href="index.php?route=account/forgotten" class="pull-right" style="color:#312783;">
							Olvidé mi contraseña
						</a>
					</div>
					<div class="clr"></div>
					<div style="border-bottom:1px solid #e5e5e5; height:20px;"></div>
					<br/>
					<div class="" style="color:black;"> No estás registrado?
						<a href="<?php echo $base; ?>index.php?route=account/register" style="color:#312783;">Registrate aquí.</a>
					</div>
					<div class="clr" style="height:20px;"></div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div><!-- /.modal --><!--Login modal end-->
<script>
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
					//$('#quick-login .loginaccount').button('loading');
					$('#modal-quicksignup .alert-danger').remove();
				},
				success: function(json){
					$('#modal-quicksignup .form-group').removeClass('has-error');
					if(json['islogged']){
						
						window.location.reload();
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
	
	
	$('.login-reuired').click(function(event){
		$('#login_model').modal('show');
	});
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$('.span-vendor-input-country').hide();
		$('.span-vendor-province-id').hide();
		$('.span-vendor-input-city').hide();
		
		$('.span-vendor-new-address').hide();
		$('.span-vendor-new-door-number').hide();
		$('.span-vendor-new-postcode').hide();
		$('#new_address').hide();
		
		$('#newaddress').click(function(){
			$('#address_drop_down').hide();
			modify_address = 0;
			$('#new_address').show();
			$('#input-address-1').val('');
			$('#input-number').val('');
			$('#input-floor').val('');
			$('#input-apartment').val('');
			$('#input-postcode').val('');
			$('#country_id1').val('');
			$('#provience_id1').val('');
			// $('#').val(parsed_data[''])
		});
		$('.no-need-new-address').click(function(){
			$('#new_address').hide();
			$('#newaddress').show();
			$('#address_drop_down').show();
		})
	});
	
	$('body').on('change', 'input[name=radiog_lite]', function(){
		if($('#radio12').is(':checked')){
			$('.other-extra').show();
			$('#newaddress').show();
			<?php if (empty($get_address)) { ?>
			$('#new_address').show();
			$('.no-need-new-address').hide();
			<?php  } ?>
		}
		else{
			$('.other-extra').hide();
			$('#new_address').hide();
		}
	});
	//ajax for cities
	$('select[name=\'provience_id1\']').on('change', function(){
		
		var data_attribute = this.value;
		$.ajax({
			url: 'index.php?route=customuserdetail/userdetail/cities_lc',
			type: 'POST',
			dataType: 'json',
			data: {city_id: data_attribute},
			success: function(data){
				if(data == ''){
					$('#input-city1').html('<option value="0" selected="selected"><?php echo $text_none; ?></option>');
				}
				var resulted_data = '';
				for(i = 0; i < data.length; i++){
					resulted_data = resulted_data + "<option value = " + data[i].id + ">" + data[i].localidad + "</option>"
				}
				$('#input-city1').html(resulted_data);
				
			}
		});
	});
	
	
	//for add data
	$(".save_address").click(function(){
		if($('#new_address:visible').length){
			vendordetail();
		}
		
	});
	var vendor_num_val = '';
	$('#vendor_no_number').change(function(){
		if(this.checked){
			vendor_num_val = 'checked';
			
		}
		else{
			vendor_num_val = '';
		}
	});
	function vendordetail(){
		var vendor_error = false;
		var vendor_new_address = $('.vendor-new-address').val();
		var vendor_door_number = $('.vendor-new-door-number').val();
		var vendor_new_floor = $('.vendor-new-floor').val();
		var vendor_new_apt = $('.vendor-new-apt').val();
		var vendor_new_postcode = $('.vendor-new-postcode').val();
		var vendor_new_country = $('.vendor-input-country option:nth-child(2)').val();
		var vendor_new_province = $('.vendor-province-id').val();
		var vendor_new_cty = $('.vendor-input-city').val();
		if(vendor_new_address == ''){
			$('.span-vendor-new-address').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-new-address').hide();
		}
		
		if(vendor_door_number == '' && vendor_num_val == ''){
			$('.span-vendor-new-door-number').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-new-door-number').hide();
		}
		
		if(vendor_new_postcode == '' || vendor_new_postcode.length < 4){
			$('.span-vendor-new-postcode').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-new-postcode').hide();
		}
		
		
		if(vendor_new_country == ''){
			$('.span-vendor-input-country').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-input-country').hide();
		}
		if(vendor_new_province == ''){
			$('.span-vendor-province-id').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-province-id').hide();
		}
		
		if(vendor_new_cty == '' || vendor_new_cty == null){
			$('.span-vendor-input-city').show();
			vendor_error = true;
			return;
		}
		else{
			$('.span-vendor-input-city').hide();
		}
		
		if(vendor_error === true){
			
		}
		else{
			request_type = 0;
			if(modify_address === 1){
				request_type = 1;
			}
			else{
				request_type = 0;
			}
			$.ajax(
				{
					url: 'index.php?route=Buyprocess/buyprocessstep1/buy_verification_add_address',
					type: 'post',
					data: {
						request_type: request_type,
						modifying_address_id: modifying_address_id,
						vendor_new_address: vendor_new_address,
						vendor_door_number: vendor_door_number,
						vendor_new_floor: vendor_new_floor,
						vendor_new_apt: vendor_new_apt,
						vendor_new_postcode: vendor_new_postcode,
						vendor_new_country: vendor_new_country,
						vendor_new_province: vendor_new_province,
						vendor_new_cty: vendor_new_cty
					},
					success: function(data){
						parsed_data = JSON.parse(data);
						if(data !== 'not_inserted' || data !== 'not_updated'){
							if(parsed_data['modify'] === 1){
								$(".shipAddress option[value='" + parsed_data['id'] + "']").remove();
								$('.shipAddress').append('<option class="address_get" value="' + parsed_data['id'] + '" data-address="' + parsed_data['new_address'] + parsed_data['city'] + parsed_data['country'] + '" data-radius="<?php echo $radius;?>" data-shippCharges="<?php echo $own_shipping_price;?>" data-discountedTotal="<?php echo $discounted_total;?>" data-vendorId="<?php echo $vendor_id;?>" selected>' + parsed_data['new_address'] + '</option>');
								$('.shipAddress').trigger("change");
							}
							else{
								$('.shipAddress').append('<option class="address_get" value="' + parsed_data['id'] + '" data-address="' + parsed_data['new_address'] + parsed_data['city'] + parsed_data['country'] + '" data-radius="<?php echo $radius;?>" data-shippCharges="<?php echo $own_shipping_price;?>" data-discountedTotal="<?php echo $discounted_total;?>" data-vendorId="<?php echo $vendor_id;?>" selected>' + parsed_data['new_address'] + '</option>');
								$('.shipAddress').trigger("change");
							}
							$('#new_address').hide();
							$('#address_drop_down').show();
							goToForthStep();
						}
					}
				});
		}
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var myRadio = $('input[name=radiog_lite]');
		var checkedValue = myRadio.filter(':checked').val();
		if(checkedValue == 'I will agree with vendor'){
			
			$('.shipAddress').trigger("change");
		}
		else{
			$('.address_tab').hide();
			value = $("#sub_total").html();
			$("#shipChargesRes").html(0);
			$("#totalAmount").html(value);
			$("#total_price_amount").html(value);
			
		}
		$('input[name=radiog_lite]').change(function(){
			checkedValue = myRadio.filter(':checked').val();
			if(checkedValue == 'I will agree with vendor'){
				$('.address_tab').show();
				$('.shipAddress').trigger("change");
			}
			else{
				if(checkedValue == 'I will pick up the item'){
					$('.address_tab').hide();
				}
			}
		});
		
	});
	$('#last_continue').click(function(){
		$('#whole_container_buy_process').hide();
		
		$.ajax(
			{
				url: 'index.php?route=Buyprocess/buyprocessstep1/get_vendor_details',
				type: 'post',
				data: {
					product_id_final,
					product_id_final
				},
				success: getVendorDetailsCallback
			});
		$('#final_description_container_buy_process').show();
		
	});
	
	function getVendorDetailsCallback(data){
		
		parsed_data = JSON.parse(data);
		splitted_name = parsed_data.v_name.split(' ');
		updated_name = splitted_name[1] + ' ' + splitted_name[0];
		
		$('#finalization_vender_phone').text(parsed_data.v_phone);
		$('#finalization_vender_email').text(parsed_data.v_email);
		$('#finalization_vender_name').text(updated_name);
		$('#finalization_vender_description').text(parsed_data.vendor_information);
		makeFooterStickToBottom();
	}
	
	$('#finalized_last_continue').click(function(){
		window.location.href = '<?php echo $base;?>';
	});
	var modify_address_id = 0;
	$('#modify_address').click(function(){
		$('#newaddress').hide();
		$('#address_drop_down').hide();
		
		modify_address = 1;
		$.ajax(
			{
				type: "POST",
				data: {modify_address_id: modify_address_id},
				url: "index.php?route=Buyprocess/buyprocessstep1/get_address_to_modify",
				success: function(data){
					parsed_data = JSON.parse(data);
					$('#input-address-1').val(parsed_data['new_address']);
					$('#input-number').val(parsed_data['door_number']);
					$('#input-floor').val(parsed_data['floor']);
					$('#input-apartment').val(parsed_data['apartment']);
					$('#input-postcode').val(parsed_data['postcode']);
					$('#country_id1').val(parsed_data['country']);
					$('#provience_id1').val(parsed_data['province']);
					// $('#').val(parsed_data[''])
					modifying_address_id = parsed_data['id'];
					$('#new_address').show();
				}
			});
	});
	$('.shipAddress').change(function(){
		if($(this).val() !== ''){
			modify_address_id = $(this).val();
			$('#modify_address').css('display', 'block');
		}
		else{
			$('#modify_address').css('display', 'none');
		}
		$("#loadShippingCharges").show();
		$("#shippLoad_modal").show();
		var shipAddress = $('.shipAddress option:selected').attr("data-address");
		var vendorId = $('.shipAddress option:selected').attr("data-vendorId");
		var radius = $('.shipAddress option:selected').attr("data-radius");
		var shippCharges = $('.shipAddress option:selected').attr("data-shippCharges");
		var discountedTotal = $('.shipAddress option:selected').attr("data-discountedTotal");
		
		$.ajax(
			{
				type: "POST",
				data: "shipAddress=" + shipAddress + "&vendorId=" + vendorId + "&radius=" + radius + "&shippCharges=" + shippCharges,
				url: "index.php?route=Buyprocess/buyprocessstep1/getShipCharges",
				success: function(data){
					$("#shipChargesRes").html('$' + data);
					$("#shipChargesInput").val(data);
					
					if(discountedTotal > 0){
						var total = parseInt(discountedTotal) + parseInt(data);
					}
					else{
						var total = $("#sub_total").html();
						
						total = total.split("<sup>");
						total = total[0].split("$");
						total = total[1];
						
						var cash = $("#cash_discount").html();
						cash = cash.split("<sup>");
						cash = cash[0].split("$");
						cash = cash[1];
						total = total - cash;
					}
					$("#totalAmountInput").val(total);
					$(".t-a").html('$' + total);
					$("#loadShippingCharges").hide();
					$("#shippLoad_modal").hide();
					$("#step-two").removeClass("not-active");
				},
				error: function(){
					$("#loadShippingCharges").hide();
					$("#shippLoad_modal").hide();
					alert('Something went wrong');
				}
			});
	});
</script>
<?php
echo $footer;
?>
