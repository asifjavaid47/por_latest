<?php echo $header;

global $loader, $registry;
$loader->model('catalog/category');
$modelCat = $registry->get('model_catalog_category');
?>

<style>
	button.no-border {
		border: 0px;
		background-color: #F5F5F5;
	}
</style>

<div class="search-product-head-container" style="background-color: white">
	<div class="container">
		<div class="search-produ-head" style="background-color: white;padding-bottom: 26px;margin-bottom: 8px;">
			
			<div class="breadcum-block">
				<ul>
					<li>Home</li>
					<li>
						<?php if(isset($category_tree)) {
						foreach($category_tree as $tree_name){ ?>
					<li>&gt;</li>
					<?php $tree_name_get = $modelCat->get_category_tree_name($tree_name['path_id']); ?>
					<li>
						<a href="<?php echo 'index.php?route=product/category&path='.$tree_name['path_id']; ?>"><?php echo $tree_name_get; ?></a>
					</li>
					<?php }
					} else{
						echo '<li>&gt;</li><li>All Products</li>';
					} ?>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>


<div class="container">
	
	<div class="row" style="margin-top: 10px;">
		
		<?php echo $productsidebar; ?>
		
		<div class="col-sm-2 col-md-4 col-lg-6 col-w-600 products-area">
			<?php
			if($products){
				
				?>
				
				<div class="clr"></div>
				<div class="cilent_text" style="color:#bf2501;background-color:#f9b233;padding-bottom:0px; margin-bottom:15px"><?php echo $modelCat->get_category_tree_name($category_tree[(count($category_tree) - 1)]['path_id']); ?></div>
				<ul id="flexiselDemo1"></ul>
				<div class="clr"></div>
				<div class="product-main-container">
					<div id="grid-view-area" style="text-align: justify;">
						<?php
						$prod_count = 1;
						foreach($products as $product){ ?>
							<div class="product-one-main product-one-block <?php if($prod_count % 4 == 0)
								echo 'block-last-child'; ?>" style="width:100px;height:180px;margin-bottom: 15px;display: inline-block;float: none;">
								<?php
								if($product['listing_type'] == 3){
									$date1 = new DateTime(date('y-m-d'));
									$date2 = new DateTime($product['date_added']);
									$diff = $date2->diff($date1)->format("%a");
									if($diff < 30){
										echo '<span class="liquidation_ribbon_category"></span>';
									}
								} else if($product['listing_type'] == 2){
									echo '<span class="destacada_ribbon"></span>';
								} else if($product['listing_type'] == 1){
									echo '<span class="gratics_ribbon"></span>';
								}
								?>
								<div class='grid-overflow' style="width:inherit!important;height:inherit;">
									<a href="#" class="whole_product_redirections prevent_default2" quantity=1 amount= <?php echo $product['price']; ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $product['price']; ?>></a>
									<div class="product-img-block">
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/>
									</div>
									<div class="product-title product-title-category "><?php echo $product['name']; ?></div>
									<?php
									/******View all discounted quantities******/
									$disQuantities = $modelCat->getProductDiscounts($product['product_id']);
									$minPrice;
									$maxPrice;
									if($product['onlyPrice']){
										$minPrice = round($product['onlyPrice'], 0);
										$maxPrice = round($product['onlyPrice'], 0);
									}
									$tier_count = 0;
									$disQuantities;
									$disLen = count($disQuantities);
									foreach($disQuantities as $disQuantity){
										$minPrice = round($disQuantity['price'], 0);
										$tier_count++;
									}
									?>
									<?php ?>

									<label class="price-content-container">Precio</label>
									<div class="price-block-container" style="font-weight: bold;float: right;text-align: right;line-height: 15px;height:15px; font-size: 12px;padding-right: 5px;"><?php echo $currencySymb.str_replace(',','.',number_format($maxPrice, 0));?><sup>00</sup></div>
									<div class="clr"></div>
									<label class="price-content-container">P.min</label>
									<div class="min-price-block" style="width:auto;font-weight: bold;float: right;text-align: right;line-height: 15px;height:15px; font-size: 12px;padding-right: 5px;"><?php echo $currencySymb.str_replace(',','.',number_format($minPrice, 0)); ?><sup>00</sup></div>
									<div class="clr">
									<div style="text-align: center;" class="product-address-content-container">Capital Federal</div>
									</div>
									
									<div class="over-table-block over-table-block-category">
										<div class="clr"></div>
										<div class='fix_tier_price_at_bottom' style="width: 100px;    text-align: center;">
											<div class="heart-block-container add_to_wishlist" title='Add to Wishlist' product_id='<?php echo $product['product_id'] ; ?>'>
												<img src="<?php echo $base;?>catalog/view/theme/default/image/over-heart-img.png" alt="">
											</div>
											<div class="product_title_tier_prices product_title_tier_prices-category" style="height:36px!important;"><?php echo $product['name']; ?></div>
											<!--unit price instance-->
											<div class="first-amt-block">
												<a href="#" class='prevent_default' quantity=1 amount= <?php echo $currencySymb.$maxPrice; ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice; ?>>
													<div class="one-no-block one-no-block-category prod-list-amt-first prod-list-amt-first-category">x1</div>
													<div class="one-block-amt prod-list-amt-first prod-list-amt-first-category" style="line-height: 18px;"><?php echo $currencySymb.str_replace(',','.',number_format($maxPrice, 0)); ?><sup>00</sup>
													</div>
												</a>
											</div>
											<?php
											/******View all discounted quantities******/

											foreach($disQuantities as $disQuantity){
												?>
												<div class="first-amt-block">
													<a href="#" class='prevent_default' quantity= <?php echo $disQuantity['quantity']; ?> amount
													= <?php echo $currencySymb.round($disQuantity['price'], 0) ?>
													product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price
													=<?php echo $currencySymb.$maxPrice; ?> >
													<div class="one-no-block  one-no-block-category prod-list-amt-first prod-list-amt-first-category">x<?php echo $disQuantity['quantity']; ?></div>
													<div class="one-block-amt prod-list-amt-first prod-list-amt-first-category" style="line-height: 18px;"><?php echo $currencySymb.str_replace(',','.',number_format($disQuantity['price'], 0)) ?><sup>00</sup></div>
													</a>
												</div>

												<?php
											}
											for($i=0;$i<(4-count($disQuantities));$i++){ ?>
                                                <div class="first-amt-block"><div class="one-no-block  one-no-block-category prod-list-amt-first prod-list-amt-first-category"></div><div class="one-block-amt prod-list-amt-first prod-list-amt-first-category"></div></div>
                                            <?php } ?>

										</div>
									</div>
									<div class="prod-bottom-bar grid_view_item" style="width: 100px!important;height: 22px;">
	<span class="escala-font" style="float:left;text-align: center;display: inline-block;width: 100%;height: 22px;padding-top: 0px">
		<img src="https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfl1/v/t1.0-9/13507178_10209719049803807_9121710258395629353_n.jpg?oh=4646fb6e51c66048a89075d7a4d6650c&amp;oe=58063436&amp;__gda__=1479859703_4073f4d5403df5081fc0703dd0b49c3a" width="22px" height="22px">
	</span>
									</div>
								</div>
							</div>
							<style>
								.first-amt-block {
									line-height: 10px;
									
								}
								
								.one-no-block {
									width: 50px;
								}
							</style>
							<?php
							$prod_count++;
						}
						?>
						<div class="clr"></div>
					</div><!---id: grid-view -->
					
					<div id="list-view-area" style="display:none;">
						<?php
						foreach($products as $product){ ?>
							<div class="product-list-block">
								<div class="ribbon_immediate_after">
									<?php
									if($product['listing_type'] == 3){
										$date1 = new DateTime(date('y-m-d'));
										$date2 = new DateTime($product['date_added']);
										$diff = $date2->diff($date1)->format("%a");
										if($diff < 30){
											echo '<span class="liquidation_ribbon_category"></span>';
										}
									} else if($product['listing_type'] == 2){
										echo '<span class="destacada_ribbon"></span>';
									} else if($product['listing_type'] == 1){
										echo '<span class="gratics_ribbon"></span>';
									}
									?>
									<div class="col-sm-7 col-md-7 col-lg-9 pr0">
										<div class="list-hover-view">
											
											<div class="product-img-block">
												<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/>
											</div>
											<div class="list-view-name">
												<div class="product-head">
													<?php echo $product['name']; ?>
												</div>
												
												<?php if(!empty($product['location'])){ ?>
													<div class="location-list">
														<i class="fa fa-map-marker"></i>
														<?php echo $product['location']; ?>
													</div>
												<?php } ?>
											</div>
											<?php
											$disQuantities = $modelCat->getProductDiscounts($product['product_id']);
											
											$minPrice;
											$maxPrice;
											if($product['onlyPrice']){
												$minPrice = round($product['onlyPrice'], 0);
												$maxPrice = round($product['onlyPrice'], 0);
											}
											$tier_count = 0;
											$disQuantities;
											$disLen = count($disQuantities);
											foreach($disQuantities as $disQuantity){
												$minPrice = round($disQuantity['price'], 0);
												
												$tier_count++;
											} ?>
											<div class="table-responsive over-table-block">
												<div class="heart-block-container add_to_wishlist" title='Add to Wishlist' product_id='<?php echo $product['product_id'] ; ?>'>
													<img src="<?php echo $base;?>catalog/view/theme/default/image/over-heart-img.png" alt="">
												</div>
												<table class="table">
													<tbody>
													<tr class="first-amt-block">
														<td style="cursor:pointer" class='prevent_default_list' hover_effect_selector='0' quantity=1 amount= <?php echo $currencySymb.$maxPrice; ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice; ?>>
															1
														</td>
														<?php /******View all discounted quantities******/
														$effect_value = 1;
														foreach($disQuantities as $disQuantity){
															?>
															<td style="cursor:pointer" class='prevent_default_list' hover_effect_selector='<?php echo $effect_value ?>' quantity= <?php echo $disQuantity['quantity']; ?> amount = <?php echo $currencySymb.round($disQuantity['price'], 0) ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice; ?> ><?php echo $disQuantity['quantity']; ?></td>
															<?php
															$effect_value++;
														}
														?>

													</tr>
													<tr class="first-amt-block">
														<td style="cursor:pointer" class='prevent_default_list' hover_effect_selector='0' quantity=1 amount= <?php echo $currencySymb.$maxPrice; ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice; ?>><?php echo $currencySymb.$maxPrice; ?></td>
														<?php
														/******View all discounted prices******/
														$effect_value = 1;
														foreach($disQuantities as $disQuantity){
															?>
															<td style="cursor:pointer" class='prevent_default_list' hover_effect_selector='<?php echo $effect_value ?>' quantity= <?php echo $disQuantity['quantity']; ?> amount = <?php echo $currencySymb.round($disQuantity['price'], 0) ?> product_id=<?php echo $product['product_id'] ?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice; ?> ><?php echo $currencySymb.round($disQuantity['price'], 0) ?></td>
															<?php
															$effect_value++;
														} ?>
													</tr>
													<tr>
														<td colspan="6"><span id="feature_dialogue"><?php echo $product['name']; ?></span>
															<br>
															<span id="feauture_d_after">Stock <?php echo $product['stock']; ?>
																- <?php echo $product['location']; ?></span>
														</td>
													</tr>
													</tbody>
												</table>
											
											</div>
											<div class="prod-bottom-bar right">
												<span><span>%</span> Escala de Descuentos</span>
											</div>
										</div>
									</div>
									<div class="col-sm-5 col-md-5 col-lg-3">
										<div class="border-le">
											<div class="amt-block-container">
												<div class="unit-price-block">
													<div class="price-block-container">
														<?php echo $currencySymb.$maxPrice; ?>
													</div>
													<div class="price-content-container">
														Precio Unit
													</div>
												</div>
												<div class="min-price-block">
													<div class="min-block-container">
														<?php echo $currencySymb.$minPrice; ?>
													</div>
													<div class="min-content-container">
														Más Barato
													</div>
												</div>
												<div class="clr"></div>
												
												
												<div class="shipping-truck-block col-sm-6">
													
													
													<div class="shipping-content-container">
														Shipping
													</div>
												</div>
												
												<div class="product-condition-block col-sm-6 padding0">
													<div class="product-condition-content-container">
														Artículo Nuevo
													</div>
													<div class="product-address-block">
														<div class="product-address-content-container">
															Capital Federal
														</div>
													</div>
												</div>
												
												<div class="clr"></div>
											
											
											</div>
										</div>
									</div>
								</div>
							</div>
							<?php
						}
						?>
						<div class="clr"></div>
					</div><!---id: list-view -->
				
				</div>
				<div class="product-pagi-block">
					<?php echo $pagination; ?>
				</div>
				
				<?php if(!$categories && !$products){ ?>
					<p><?php echo $text_empty; ?></p>
					<div class="buttons">
						<div class="pull-right">
							<a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a>
						</div>
					</div>
				<?php } ?>
				
				<?php
			}
			?>
		</div>
	
	
	</div>
</div>
<div class="modal fade" id="wishlist_success_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Added Favourite</h4>
			</div>
			<div class="modal-body">
				<p>Product Marked Favourite Successfully.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
	$('.prevent_default').click(function(event){
		event.preventDefault();
		this_element = $(this);
		var quantity = this_element.attr('quantity');
		var amount = this_element.attr('amount');
		var product_id = this_element.attr('product_id');
		window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
	});
	
	$('.prevent_default2').click(function(event){
		event.preventDefault();
		this_element = $(this);
		var quantity = this_element.attr('quantity');
		var amount = this_element.attr('amount');
		var product_id = this_element.attr('product_id');
		window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
	});
	
	var setTimeoutConst_grid;
	$('.prevent_default').mouseover(function(event){
		this_element = $(this);
		setTimeoutConst_grid = setTimeout(function(){
			var quantity = this_element.attr('quantity');
			var amount = this_element.attr('amount');
			var product_id = this_element.attr('product_id');
			var original_price = this_element.attr('original_price');
			var original_quantity = this_element.attr('original_quantity');
			
			original_price_split1 = original_price.split(',');
			if(original_price_split1[1]){
				original_price = (original_price_split1[0]) + '' + (original_price_split1[1]);
			}
			else{
				original_price = original_price_split1[0];
			}

			amount_split1 = amount.split(',');
			if(amount_split1[1]){
				amount = (amount_split1[0]) + '' + (amount_split1[1]);
			}
			else{
				amount = amount_split1[0];
			}

			amount_splitted = amount.split('$');
			amount = amount_splitted[1];
			original_price_splitted = original_price.split('$');
			original_price = original_price_splitted[1];

			product_amount_final = amount;
			product_quantity_final = quantity;

			discounted_price = product_amount_final;

			discounted_price_remaining = Math.round(original_price) - discounted_price;
			discounted_percent = (discounted_price_remaining / Math.round(original_price)) * 100;

			if(discounted_percent < 0){
				discounted_percent = Math.abs(discounted_percent);
			}
			else{
				discounted_percent = '-' + discounted_percent;
			}
			this_element.parent().siblings().children('.hover_selected_tier_price.hover_selected_tier_price-category ').removeClass('hover_selected_tier_price hover_selected_tier_price-category');
			this_element.addClass('hover_selected_tier_price hover_selected_tier_price-category');



		}, 1000);
	}).mouseleave(function(event){
		clearTimeout(setTimeoutConst_grid);
	});
	
	var setTimeoutConst;
	$('.prevent_default_list').mouseover(function(event){
		this_element = $(this);
		hover_effect_selectors = this_element.attr('hover_effect_selector');
		this_element.parents().eq(1).find('td[hover_effect_selector = ' + hover_effect_selectors + ']').addClass('hover_effect_selector');
		
		setTimeoutConst = setTimeout(function(){
			var quantity = this_element.attr('quantity');
			var amount = this_element.attr('amount');
			var product_id = this_element.attr('product_id');
			var original_price = this_element.attr('original_price');
			var original_quantity = this_element.attr('original_quantity');
			
			original_price_split1 = original_price.split(',');
			if(original_price_split1[1]){
				original_price = (original_price_split1[0]) + '' + (original_price_split1[1]);
			}
			else{
				original_price = original_price_split1[0];
			}
			
			amount_split1 = amount.split(',');
			if(amount_split1[1]){
				amount = (amount_split1[0]) + '' + (amount_split1[1]);
			}
			else{
				amount = amount_split1[0];
			}
			
			amount_splitted = amount.split('$');
			amount = amount_splitted[1];
			original_price_splitted = original_price.split('$');
			original_price = original_price_splitted[1];
			
			product_amount_final = amount;
			product_quantity_final = quantity;
			
			discounted_price = product_amount_final;
			
			discounted_price_remaining = Math.round(original_price) - discounted_price;
			discounted_percent = (discounted_price_remaining / Math.round(original_price)) * 100;
			saved_amount = discounted_price_remaining * product_quantity_final;
			
			if(discounted_percent < 0){
				discounted_percent = Math.abs(discounted_percent);
			}
			else{
				discounted_percent = '-' + discounted_percent;
			}
			
			this_element.parents().eq(1).find('.hover_effect_tier_price_list').removeClass('hover_effect_tier_price_list');
			hover_effect_selectors = this_element.attr('hover_effect_selector');
			this_element.addClass('hover_effect_tier_price_list');
			this_element.parents().eq(1).find('td[hover_effect_selector = ' + hover_effect_selectors + ']').addClass('hover_effect_tier_price_list');
			
			
			//$('.list_view_saved_percent').text("-"+Math.round(discounted_percent)+"%");
			this_element.parents().eq(1).find('.list_view_saved_percent').text(Math.round(discounted_percent) + "%");
			//$('.list_view_saved_amount_value').text("$"+Math.round(saved_amount)+"!");
			this_element.parents().eq(1).find('.list_view_saved_amount_value').text("$" + Math.round(saved_amount) + "!");
		}, 1000);
	}).mouseleave(function(event){
		clearTimeout(setTimeoutConst);
		hover_effect_selectors = $(this).attr('hover_effect_selector');
		$('td[hover_effect_selector = ' + hover_effect_selectors + ']').removeClass('hover_effect_selector');
	});
	
	$('.prevent_default_list').click(function(event){
		this_element = $(this);
		var quantity = this_element.attr('quantity');
		var amount = this_element.attr('amount');
		var product_id = this_element.attr('product_id');
		window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
	});
	
	$('.prod-bottom-bar.grid_view_item').click(function(){
		if($(this).siblings('.over-table-block').css('display') == 'none'){
			$(this).siblings('.over-table-block').show("slide", {direction: "down"}, 1000);
			$(this).css('bottom', '0');
		}
		else{
			$(this).siblings('.over-table-block').hide("slide", {direction: "down"}, 1000);
			$(this).css('bottom', '-20%');
		}
	});
	
	$('.prod-bottom-bar.right').click(function(){
		if($(this).siblings('.over-table-block').css('display') == 'none'){
			$(this).siblings('.over-table-block').show("slide", {direction: "right"}, 1000);
			$(this).css('left', '93%');
		}
		else{
			$(this).siblings('.over-table-block').hide("slide", {direction: "right"}, 1000);
			$(this).css('left', '100%');
		}
	});
	
	$('body').on('click', '.add_to_wishlist', function()
	{
		var product_id_here = $(this).attr('product_id');
		$.ajax(
		{
			url: 'index.php?route=product/wishlist/add_to_wishlist',
			type: 'POST',
			data:{product_id:product_id_here},
			success: function (data)
			{
				$('#wishlist_success_modal').modal('show');
			}
		});
	});
</script>

<?php echo $footer; ?>
