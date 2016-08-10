<?php
	echo $header;
?>
<div class="col-sm-1 col-md-1 col-lg-1">
</div>
<div class="col-sm-10 col-md-10 col-lg-10">
	<div class="product-main-container grid_wrap" id='all_results'>
	</div>
</div>
<script>
$(document).ready(function()
{
	$.ajax(
	{
		url: 'index.php?route=common/home/get_sale_off_products',
		type: 'post',
		success: function (data)
		{
			all_products_data = '', date_added_elem='', all_products_data1='', all_products_data2 = '', all_products_data3 = '', all_products_data_last = '';
			parsed_data = JSON.parse(data);
			number_of_products = parsed_data['products_details'].length;
			for(i=0;i<number_of_products;i++)
			{
				if(parsed_data['product_images'][i])
				{
					product_main_image = parsed_data['product_images'][i];
				}
				else
				{
					product_main_image = 'cache/placeholder-228x228.png';
				}
				
				parsed_price_original_parent = parsed_data['products_details'][i].price;
				parsed_price_original = parsed_data['products_details'][i].price;
				parsed_price = parseInt(parsed_data['products_details'][i].price);
				whole = Math.floor(parsed_price);
				fraction = parsed_price - whole;
				if(fraction < 9)
				{
					fraction = '0'+fraction;
				}
				else
				{
					fraction = fraction;
				}
				parsed_price="$"+whole+"<sup>"+fraction+"</sup>";
				
				var currentDate = new Date();
				var day = currentDate.getDate();
				var month = currentDate.getMonth() + 1;
				var year = currentDate.getFullYear();
				element_time = new Date(parsed_data['products_details'][i].date_added);
				
				current_date = year  + "-" + month + "-" + day;
				date_diff = current_date - element_time;
				if(date_diff < 30)
				{
					date_added_elem = '<span class="liquidation_ribbon"></span>';
				}
				else
				{
					date_added_elem = '';
				}
				//remove following after correcting the upper condition
				date_added_elem = '<span class="liquidation_ribbon"></span>';
				
				all_products_data1 = '<div class="product-one-main product-one-block">'+date_added_elem+'<div class="grid-overflow"><a href="#" class="whole_product_redirections prevent_default2" quantity="1" amount="$'+parsed_price_original+'" product_id="'+parsed_data['products_details'][i].product_id+'" original_quantity="1" original_price="$'+parsed_price_original+'" ></a><div class="product-img-block"></span><img src="'+product_main_image+'" alt=""/></div><div class="product-title">'+parsed_data['products_description'][i][0].name+'</div><div class="amt-block-container"><div class="unit-price-block"><div class="price-block-container">'+parsed_price+'</div><div class="price-content-container">Precio Unit</div></div><div class="min-price-block"><div class="">$900</div><div class="price-content-container min-pr">Más Barato</div></div><div class="clr"><div class="col-sm-7 padding0 text-left product-address-block"><div class="product-address-content-container">Capital Federal</div></div><div class="col-sm-5 product-condition-content-container padding0 text-right">Artículo Nuevo</div></div></div><div class="over-table-block"><div class="clr"></div><div class="fix_tier_price_at_bottom"><div class="product_stock_tier">'+parsed_data['products_details'][i].quantity+' en Stock</div><div class="product_title_tier_prices">'+parsed_data['products_description'][i][0].name+'</div><div class="first-amt-block"><a href="#" class="prevent_default" quantity="1" amount="$'+parsed_price_original+'" product_id="'+parsed_data['products_details'][i].product_id+'" original_quantity="1" original_price="$'+parsed_price_original+'"><div class="one-no-block">1</div><div class="one-block-amt">'+parsed_price+'</div></a></div>';
				number_of_product_discounts = parsed_data['products_discounts'][i].length;
				all_products_data2 = '';
				for(j=0;j < number_of_product_discounts; j++)
				{
					parsed_price_original = parsed_data['products_discounts'][i][j].price;
					parsed_price = parseInt(parsed_data['products_discounts'][i][j].price);
					whole = Math.floor(parsed_price);
					fraction = parsed_price - whole;
					if(fraction < 9)
					{
						fraction = '0'+fraction;
					}
					else
					{
						fraction = fraction;
					}
					parsed_price="$"+whole+"<sup>"+fraction+"</sup>";
				
					all_products_data2 = all_products_data2 + '<div class="first-amt-block"><a href="#" class="prevent_default" quantity="'+parsed_data['products_discounts'][i][j].quantity+'" amount="$'+parsed_price_original+'" product_id="'+parsed_data['products_details'][i].product_id+'" original_quantity="1" original_price="$'+parsed_price_original_parent+'"><div class="one-no-block">'+parsed_data['products_discounts'][i][j].quantity+'</div><div class="one-block-amt">'+parsed_price+'</div></a></div>';
				}
				all_products_data3 = '<div class="col-sm-12 b_x_2 home_page_most_bottom_container"><span class="percentage_saved">-0%</span><span class="saved_amount_keyword pull-right">Ahorra</span><br><span class="total_amount_saved pull-right">$0!</span></div></div></div><div class="prod-bottom-bar grid_view_item"><span style="float:left" class="escala-font"><img src="https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfl1/v/t1.0-9/13507178_10209719049803807_9121710258395629353_n.jpg?oh=4646fb6e51c66048a89075d7a4d6650c&amp;oe=58063436&amp;__gda__=1479859703_4073f4d5403df5081fc0703dd0b49c3a" width="23px" height="23px">ESCALA DE DESCUENTOS</span></div></div></div>';
				all_products_data_last = all_products_data1 + all_products_data2 + all_products_data3;
				all_products_data = all_products_data + all_products_data_last;
			}
			$('#all_results').html(all_products_data);
		}
	});
	$('.prevent_default').click(function(e)
	{
		e.preventDefault();
	});
		
		
	$('body').on('click','.prod-bottom-bar' ,function()
	{
		if($(this).siblings('.over-table-block').css('display') == 'none')
		{
			$(this).siblings('.over-table-block').show("slide", { direction: "down" }, 1000);
			$(this).css('bottom','0');
		}
		else
		{
			$(this).siblings('.over-table-block').hide("slide", { direction: "down" }, 1000);
			$(this).css('bottom','-20%');
		}
	});
	
	
		$('.prevent_default').click(function (event)
	{
		event.preventDefault();
		this_element = $(this);
		var quantity = this_element.attr('quantity');
		var amount = this_element.attr('amount');
		var product_id = this_element.attr('product_id');
		window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
	});
 
	$('body').on('click', '.prevent_default2', function (event)
	{
		event.preventDefault();
		this_element = $(this);
		var quantity = this_element.attr('quantity');
		var amount = this_element.attr('amount');
		var product_id = this_element.attr('product_id');
		window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
	});	
	
	var setTimeoutConst_grid;
	
	$('body').on('mouseover', '.prevent_default', function(event)
	{
		this_element = $(this);
		setTimeoutConst_grid = setTimeout(function()
		{
			var quantity = this_element.attr('quantity');
			var amount = this_element.attr('amount');
			var product_id = this_element.attr('product_id');
			var original_price = this_element.attr('original_price');
			var original_quantity = this_element.attr('original_quantity');
			
			original_price_split1 = original_price.split(',');
			if(original_price_split1[1])
			{
				original_price = (original_price_split1[0])+''+(original_price_split1[1]);		
			}
			else
			{
				original_price = original_price_split1[0];		
			}
			
			amount_split1 = amount.split(',');
			if(amount_split1[1])
			{
				amount = (amount_split1[0])+''+(amount_split1[1]);		
			}
			else
			{
				amount = amount_split1[0];		
			}
			
			amount_splitted = amount.split('$');
			amount = amount_splitted[1];
			original_price_splitted = original_price.split('$');
			original_price = original_price_splitted[1];
			
			product_amount_final = amount;
			product_quantity_final = quantity;
				
			//discounted_price = product_amount_final / product_quantity_final;
			discounted_price = product_amount_final;
			
			discounted_price_remaining = Math.round(original_price) - discounted_price;
			discounted_percent = (discounted_price_remaining / Math.round(original_price)) * 100;
			if(discounted_percent < 0)
			{
				discounted_percent = Math.abs(discounted_percent);
			}
			else
			{
				discounted_percent = "-"+discounted_percent;
			}
			this_element.parent().siblings().children('.hover_selected_tier_price').removeClass('hover_selected_tier_price');
			this_element.addClass('hover_selected_tier_price');
			
			this_element.parents().eq(1).children().last().children(0)[0].innerHTML = Math.round(discounted_percent)+"%";

			saved_amount = discounted_price_remaining * product_quantity_final;
			this_element.parents().eq(1).children().last().children(0)[3].innerHTML = "$"+Math.round(saved_amount)+"!";
		}, 1000);
	}).on('mouseleave', '.prevent_default', function(event)
	{ 
		clearTimeout(setTimeoutConst_grid);
	});
	
});
</script>
<?php
	echo $footer;
?>