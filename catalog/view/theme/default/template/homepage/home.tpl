<?php
echo $header;
//defining ids for the banners. currently we have three ids for banners
$banner_ids = array('banner1', 'banner2', 'carosal_banner');
?>
	<style>
		
		.nbs-flexisel-container {
			position: relative;
			max-width: 100%;
		}
		
		.nbs-flexisel-ul {
			position: relative;
			width: 99999px;
			margin: 0px;
			padding: 0px;
			list-style-type: none;
			text-align: center;
		}
		
		.nbs-flexisel-inner {
			position: relative;
			overflow: hidden;
			width: 100%;
		}
		
		.nbs-flexisel-item {
			float: left;
			margin: 0px;
			padding: 0px;
			cursor: pointer;
			position: relative;
			line-height: 0px;
		}
		
		.nbs-flexisel-item img {
			max-width: 100%;
			cursor: pointer;
			position: relative;
		}
		
		/*** Navigation ***/
		
		.flexicel-card {
			
			line-height: initial;
		}
		
		.flexicel-card-border {
			margin: 0 auto;
			width: 90%;
			padding: 5px;
			border: 1px solid red;
			width: 150px;
		}
		
		.flexicel {
			border: 1px solid black;
			padding: 10px 0;
		}
		
		.flexicel-aditional-data {
			margin: 0;
		}
		
		.flexicel-aditional-data span {
			display: block;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			font-size: 10px;
		}
		
		.flexicel-aditional-data div {
			padding: 0;
		}
	
	</style>
	<style>
		.prod-bottom-bar {
			padding: 1px !important;
		}
		
		.product-one-block:hover {
			color: #312782 !important;
			
		}
		
		.hover_selected_tier_price .one-no-block {
			transition: all ease-out 0.5s;
			-webkit-transition: all ease-out 0.5s;
			background: #f9b233;
			color: #312782 !important;
			border-top: 1px solid #FFF !important;
		}
		
		.hover_selected_tier_price .one-block-amt {
			transition: all ease-out 0.5s;
			-webkit-transition: all ease-out 0.5s;
			background: #f9b233;
			color: #312782 !important;
			border-top: 1px solid #FFF !important;
		}
	
	
	</style>
	
	<div class="list-cate-main header-main-color" style="margin-top:0; margin-bottom:0;box-shadow:none;">
		<div class="container">
			<div class="row">
				<div class="col-sm-12" style="padding:0px">
					<table style="width:100%; margin: 0px">
						<tr class="cat-buttons">
							<?php
							if($most_categories != NULL){
								foreach($most_categories as $most_category){ ?>
									<td class="cat-buttons">
										<a href="<?php echo $base.'index.php?route=product/category&path='.$most_category['category_id']; ?>" class="cat-row"><?php echo $most_category['name']; ?></a>
									</td>
								<?php }
							} ?>
							<td class="cat-buttons">
								<a href=" <?php echo $base; ?>index.php?route=product/category&path=166" class="cat-row">Jardines y
									Exteriores
								</a>
							</td>
							<td class="cat-buttons">
								<a href="<?php echo $base; ?>index.php?route=product/category&path=177" class="cat-row">Componentes de
									PC
								</a>
							</td>
							<td class="cat-buttons">
								<a href=" <?php echo $base; ?>index.php?route=product/category&path=184" class="cat-row">Ocio y tiempo
									libre
								</a>
							</td>
							<td class="cat-buttons">
								<a href="<?php echo $base; ?>index.php?route=product/category&path=174" class="cat-row">Belleza y
									cuidado personal
								</a>
							</td>
							<td class="cat-buttons"
							">
							<a href="<?php echo $base; ?>index.php?route=product/search&quantity=1&search=saleoffs" class="cat-row">
								Liquidaciones
							</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<div style="background-color:white">
		
		
		<div class="container">
			
			<div class="row">
				<!-- <div class="col-sm-12"> -->
				
				<div class="col-sm-12">
					<div class="row">
						<div class="silder-container " style="margin-top:5px">
							<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
								<!-- Indicators -->
								<ol class="carousel-indicators" style="z-index: 1 ">
									<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
									<li data-target="#carousel-example-generic" data-slide-to="1"></li>
									<li data-target="#carousel-example-generic" data-slide-to="2"></li>
								</ol>
								
								<!-- Wrapper for slides -->
								<div id='carosal_banner' class="carousel-inner" role="listbox">
									<!-- Commenting the  static banners
								<div class="item active">
									<img src="<?php // echo $base;?>image/assets/images/bannersld3.jpg" alt="...">
								</div>
								<div class="item">
									<img src="<?php // echo $base;?>image/assets/images/bannersld2.jpg" alt="...">
								</div>-->
								</div>
								
								<!-- Controls -->
								<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                               <span class="glyphicon glyphicon-chevron-left" aria-hidden="true">
                                   <i class="fa fa-angle-left"></i>
                               </span>
									<span class="sr-only">Anterior</span>
								</a>
								<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true">
                                   <i class="fa fa-angle-right"></i>
                               </span>
									<span class="sr-only">Siguiente</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="main-bgcolor" style="padding:15px 0px 15px 0px;">
			<div class="container">
				
				<div class="col-sm-12" style="padding:0px">
					<div class="row">
						<div id='banner1' class="col-sm-2" style="height:323px;background-color:white">
							<!-- Commenting static data
							<div class="main-heading">Banner 1</div>
							-->
						</div>
						<div class="col-sm-10" style="padding-right:0px!important;">
							<div class="product-slider">
								<div class="client_slider" style="box-shadow:none;">
									<div class="cilent_text" style="color:#bf2501;background-color:#f9b233;padding-bottom:0px">
										LIQUIDACIONES
									</div>
									<ul id="flexiselDemo1"></ul>
									<div class="clr"></div>
								</div>
							</div>
						</div>
					
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="main-bgcolor" style="padding-bottom:15px">
			<div class="container">
				<div class="col-sm-12" style="padding:0px">
					<div class="row">
						<div id='banner2' class="col-sm-2" style="height:323px;background-color: white">
							<!-- Commenting static data
							<div class="main-heading">Banner 2</div>
							-->
						</div>
						<div class="col-sm-10" style="padding-right:0px!important">
							<div class="product-slider">
								<div class="client_slider">
									<div class="cilent_text" style="color:#808080;font-size:14px;font-weight:bold;background-color:white;border-bottom:1px solid #eee;">
										Artículos Recomendados
									</div>
									<ul style="left:-215px !important" id="flexiselDemo2"></ul>
									<div class="clr"></div>
								</div>
							</div>
						</div>
					
					</div>
				</div>
			</div>
		</div>
		
		<div class="main-bgcolor" style="padding-bottom:15px">
			<div class="container">
				
				<div class="col-sm-12" style="padding:0px">
					<div class="row">
						<div class="product-slider">
							<div class="client_slider">
								<div class="cilent_text" style="color:#808080;font-size:14px;font-weight:bold;background-color:white;border-bottom:1px solid #eee;">
									Últimos Publicados
								</div>
								<ul style="left:-215px !important" id="flexiselDemo4"></ul>
								<div class="clr"></div>
							</div>
						</div>
						
						<div class="clr"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="main-bgcolor" style="padding-bottom:15px">
			<div class="col-sm-12">
				<div class="banner-block">
					<a href="#">Learn more</a>
					<div class="clr"></div>
				</div>
			</div>
		</div>
	</div></div>  </div>
	
	<script type="text/javascript">
		$('body').on('click', '.prevent_default', function(event){
			event.preventDefault();
			this_element = $(this);
			var quantity = this_element.attr('quantity');
			var amount = this_element.attr('amount');
			var product_id = this_element.attr('product_id');
			window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
		});
		
		$('body').on('click', '.prevent_default2', function(event){
			event.preventDefault();
			this_element = $(this);
			var quantity = this_element.attr('quantity');
			var amount = this_element.attr('amount');
			var product_id = this_element.attr('product_id');
			window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
		});
		
		var setTimeoutConst_grid;
		
		$('body').on('mouseover', '.prevent_default:not(.product_title_tier_prices)', function(event){
			event.preventDefault();
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
					discounted_percent = "-" + discounted_percent;
				}
				this_element.parent().siblings().children('.hover_selected_tier_price').removeClass('hover_selected_tier_price');
				this_element.addClass('hover_selected_tier_price');
				
				
				this_element.parents().eq(1).children().last().children(0)[0].innerHTML = Math.round(discounted_percent) + "%";
				
				saved_amount = discounted_price_remaining * product_quantity_final;
				this_element.parents().eq(1).children().last().children(0)[3].innerHTML = "$" + Math.round(saved_amount).toLocaleString('es-AR', {}) + "!";
			}, 1000);
		});
		
		$('body').on('mouseleave', '.prevent_default:not(.product_title_tier_prices)', function(event){
			clearTimeout(setTimeoutConst_grid);
		});
		
		function renderFlexicel(data, container){
			minimum_price_currently = 0, all_products_data = '', date_added_elem = '', all_products_data1 = '', all_products_data2 = '', all_products_data3 = '', all_products_data_last = '';
			parsed_data = JSON.parse(data);
			
			number_of_products = parsed_data['products_details'].length;
			for(var i = 0; i < number_of_products; i++){
				minimum_price_currently = 0;
				if(parsed_data['product_images'][i]){
					product_main_image = parsed_data['product_images'][i];
				}
				else{
					product_main_image = 'cache/placeholder-228x228.png';
				}
				
				parsed_price_original_parent = parsed_data['products_details'][i].price;
				minimum_price_currently = parsed_data['products_details'][i].price;
				parsed_price_original = parsed_data['products_details'][i].price;
				parsed_price = parseInt(parsed_data['products_details'][i].price);
				
				
				whole = Math.floor(parsed_price);
				fraction = parsed_price - whole;
				if(fraction < 9){
					fraction = '0' + fraction;
				}
				else{
					fraction = fraction;
				}
				parsed_price = "$" + whole.toLocaleString('es-AR', {}) + "<sup>" + fraction + "</sup>";
				
				
				number_of_product_discounts = parsed_data['products_discounts'][i].length;
				
				if(number_of_product_discounts > 0){
					minimum_price_currently = parsed_data['products_discounts'][i][number_of_product_discounts - 1].price;
				}
				
				whole_this = Math.floor(minimum_price_currently);
				fraction_this = minimum_price_currently - whole_this;
				if(fraction_this < 9){
					fraction_this = '0' + fraction_this;
				}
				else{
					fraction_this = fraction_this;
				}
				minimum_price_currently = "$" + whole.toLocaleString('es-AR', {}) + "<sup>" + fraction_this + "</sup>";
				
				all_products_data1 = '<li>'
					+ '											<div class="product-one-main product-one-block">'
					+ date_added_elem
					+ '<div class="grid-overflow-home">'
					+ '													<span class="liquidation_ribbon-home"></span>'
					+ '														<div class="product-img-block product-img-block-home">'
					+ '															<a href="#" class="whole_product_redirections whole_product_redirections-home prevent_default2" quantity="1" amount="$' + parsed_price_original + '" product_id="' + parsed_data['products_details'][i].product_id + '" original_quantity="1" original_price="$' + parsed_price_original + '" ></a>'
					+ '															<img src="' + product_main_image + '" alt=""/>'
					+ '														</div>'
					+ '														<div class="product-title product-title-home">'
					+ '															<a href="#" class="whole_product_redirections whole_product_redirections-home prevent_default2" quantity="1" amount="$' + parsed_price_original + '"product_id="' + parsed_data['products_details'][i].product_id + '" original_quantity="1" original_price="$' + parsed_price_original + '" style="position:inherit" >' + parsed_data['products_description'][i][0].name
					+ '															</a>'
					+ '														</div>'
					+ '														<div class="amt-block-container">'
					+ '															<div class="unit-price-block">'
					+ '																<div class="price-block-container">' + parsed_price + '</div>'
					+ '																<div class="price-content-container">Precio Unit</div>'
					+ '															</div>'
					+ '															<div class="min-price-block">'
					+ '																<div class="">' + minimum_price_currently + '</div>'
					+ '																<div class="price-content-container min-pr">Más Barato</div>'
					+ '															</div>'
					+ '															<div class="clr">'
					+ '																<div class="col-sm-7 padding0 text-left product-address-block">'
					+ '																	<div class="product-address-content-container">Capital Federal</div>'
					+ '																</div>'
					+ '																<div class="col-sm-5 product-condition-content-container padding0 text-right">Artículo Nuevo</div>'
					+ '															</div>'
					+ '														</div>'
					+ '													<div class="over-table-block">'
					+ '														<div class="clr"></div>'
					+ '														<div class="fix_tier_price_at_bottom">'
					+ '															<div class="product_stock_tier">' + parsed_data['products_details'][i].quantity + 'en Stock</div>'
					+ '															<a href="#" style="color: #b9d7ff" class="prevent_default product_title_tier_prices" quantity="1" amount="$' + parsed_price_original + '" product_id="' + parsed_data['products_details'][i].product_id + '" original_quantity="1" original_price="$' + parsed_price_original + '">' + parsed_data['products_description'][i][0].name
					+ '															</a>'
					+ '														<div class="first-amt-block">'
					+ '															<a href="#" class="prevent_default" quantity="1" amount="$' + parsed_price_original + '" product_id="' + parsed_data['products_details'][i].product_id + '" original_quantity="1" original_price="$' + parsed_price_original + '">'
					+ '																<div class="one-no-block">1</div>'
					+ '																<div class="one-block-amt">' + parsed_price + '</div>'
					+ '															</a>'
					+ '														</div>';
				
				
				all_products_data2 = '';
				
				
				for(j = 0; j < 4; j++){
					if(j < number_of_product_discounts){
						{
							parsed_price_original = parsed_data['products_discounts'][i][j].price;
							parsed_price = parseInt(parsed_data['products_discounts'][i][j].price);
							whole = Math.floor(parsed_price);
							fraction = parsed_price - whole;
							if(fraction < 9){
								fraction = '0' + fraction;
							}
							else{
								fraction = fraction;
							}
							
							all_products_data2 = all_products_data2
								+ '											<div class="first-amt-block">'
								+ '												<a href="#" class="prevent_default" quantity="'
								+ parsed_data['products_discounts'][i][j].quantity + '" amount="$'
								+ parsed_price_original
								+ '												" product_id="'
								+ parsed_data['products_details'][i].product_id
								+ '												" original_quantity="1" original_price="$'
								+ parsed_price_original_parent
								+ '												">'
								+ '													<div class="one-no-block">'
								+ parsed_data['products_discounts'][i][j].quantity
								+ '													</div>'
								+ '													<div class="one-block-amt">'
								+ parsed_price.toLocaleString('es-AR', {}) + "<sup>" + fraction + "</sup>"
								+ '													</div>'
								+ '												</a>'
								+ '											</div>';
							parsed_price = "$" + whole.toLocaleString('es-AR', {}) + "<sup>" + fraction + "</sup>";
						}
					}
					else{
						all_products_data2 = all_products_data2 + '<div class="first-amt-block"><div class="one-no-block"></div><div class="one-block-amt"></div></div>';
					}
				}
				
				all_products_data3 = '<div class="col-sm-12 b_x_2 home_page_most_bottom_container">'
					+ '											<span class="percentage_saved">-0%</span>'
					+ '										 	<span class="saved_amount_keyword pull-right">Ahorra</span>'
					+ '											<br>'
					+ '											<span class="total_amount_saved pull-right">$0!</span>'
					+ '									</div>'
					+ '									</div>'
					+ '									</div>'
					+ '											<div class="prod-bottom-bar grid_view_item">'
					+ '												<span style="float:left" class="escala-font">'
					+ '													<img src="https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfl1/v/t1.0-9/13507178_10209719049803807_9121710258395629353_n.jpg?oh=4646fb6e51c66048a89075d7a4d6650c&amp;oe=58063436&amp;__gda__=1479859703_4073f4d5403df5081fc0703dd0b49c3a" width="23px" height="23px">'
					+ '														ESCALA DE DESCUENTOS'
					+ '												</span>'
					+ '								</div>'
					+ '							</div>'
					+ '						</li>';
				all_products_data_last = all_products_data1 + all_products_data2 + all_products_data3;
				all_products_data = all_products_data + all_products_data_last;
			}
			$(container).html(all_products_data);
			$(container).flexisel({
				visibleItems: 5,
				itemsToScroll: 5,
				autoPlay: {
					enable: false,
					interval: 5000,
					pauseOnHover: true
				},
				responsiveBreakpoints: {
					portrait: {
						changePoint: 480,
						visibleItems: 2,
						itemsToScroll: 2
					},
					landscape: {
						changePoint: 768,
						visibleItems: 3,
						itemsToScroll: 3
					},
					tablet: {
						changePoint: 1024,
						visibleItems: 3,
						itemsToScroll: 3
					},
					desktopSmall: {
						changePoint: 1280,
						visibleItems: 4,
						itemsToScroll: 4
					}
				}
			});
		}
		
		$(document).ready(function(){
			$.ajax(
				{
					url: 'index.php?route=common/home/get_sale_off_products',
					type: 'post',
					success: function(data){
						renderFlexicel(data, '#flexiselDemo1');
					}
				});
			
			$.ajax(
				{
					url: 'index.php?route=common/home/get_recommended_products',
					type: 'post',
					success: function(data){
						renderFlexicel(data, '#flexiselDemo2');
					}
				});
			
			$.ajax(
				{
					url: 'index.php?route=common/home/get_latest_products',
					type: 'post',
					success: function(data){
						renderFlexicel(data, '#flexiselDemo4');
					}
				});
			
			$('.prevent_default').click(function(e){
				e.preventDefault();
			});
			
			
			$('body').on('click', '.prod-bottom-bar', function(){
				if($(this).siblings('.over-table-block').css('display') == 'none'){
					$(this).siblings('.over-table-block').show("slide", {direction: "down"}, 1000);
					$(this).css('bottom', '0');
				}
				else{
					$(this).siblings('.over-table-block').hide("slide", {direction: "down"}, 1000);
					$(this).css('bottom', '-20%');
				}
			});
			
			//to increment the number of clicks in a banner
			$('body').on('click', '.adds_class', function(){
				banner_id = $(this).attr('banner_id');
				Popup_open($('#' + banner_id).html());
				
				$.ajax(
					{
						url: 'index.php?route=dashboard/banner/change_banner_clicks',
						type: 'post',
						data: {banner_id: banner_id},
						success: function(data){
							console.log(data);
						}
					});
			});
			
			function Popup_open(data){
				var mywindow = window.open('');
				mywindow.document.write(data);
			}
			
		});
	
	
	</script>
<?php

//for getting and appending banners
$all_html = '';
$all_carosal_html = '';
$total_carosal_banners = 0;
$add_classe_active = 0;
if(!empty($homepgae_banners)){
	for($i = 0; $i < sizeof($homepgae_banners); $i++){
		if($homepgae_banners[$i]['banner_assigned_id'] != 'carosal_banner'){
			if(in_array($homepgae_banners[$i]['banner_assigned_id'], $banner_ids)){
				$all_html = '';
				//$all_html = $all_html . "<br><div id='".$homepgae_banners[$i]['banner_id']."' class='banner_main_div'><div class='print_banner' title = 'Print this Banner' banner_id='".$homepgae_banners[$i]['banner_id']."'><i class='fa fa-print'></i></div><div id='banner".$homepgae_banners[$i]['banner_id']."' banner_id='".$homepgae_banners[$i]['banner_id']."' class='adds_class'><div id='their_banner_html_".$homepgae_banners[$i]['banner_id']."' class='their_html_container'>".html_entity_decode(base64_decode($homepgae_banners[$i]['banner_html']))."</div></div></div>";
				$all_html = $all_html."<br><div id='".$homepgae_banners[$i]['banner_id']."' class='banner_main_div'><div id='banner".$homepgae_banners[$i]['banner_id']."' banner_id='".$homepgae_banners[$i]['banner_id']."' class='adds_class'><div id='their_banner_html_".$homepgae_banners[$i]['banner_id']."' class='their_html_container'>".html_entity_decode(base64_decode($homepgae_banners[$i]['banner_html']))."</div></div></div>";
				?>
				<script>
					$('#<?php echo $homepgae_banners[$i]['banner_assigned_id']; ?>').append("<?php echo trim(str_replace('"', "'", preg_replace('/\s+/', ' ', $all_html))); ?>");
				</script>
				<?php
			}
		} else if($homepgae_banners[$i]['banner_assigned_id'] == 'carosal_banner'){
			//$all_carosal_html = '';
			if($add_classe_active != 0){
				$all_carosal_html = $all_carosal_html."<div class='item'><div id='".$homepgae_banners[$i]['banner_id']."' class='banner_main_div'><div id='banner".$homepgae_banners[$i]['banner_id']."' banner_id='".$homepgae_banners[$i]['banner_id']."' class='adds_class'><div id='their_banner_html_".$homepgae_banners[$i]['banner_id']."' class='their_html_container'>".html_entity_decode(base64_decode($homepgae_banners[$i]['banner_html']))."</div></div></div></div>";
			} else{
				$all_carosal_html = $all_carosal_html."<div class='item active'><div id='".$homepgae_banners[$i]['banner_id']."' class='banner_main_div'><div id='banner".$homepgae_banners[$i]['banner_id']."' banner_id='".$homepgae_banners[$i]['banner_id']."' class='adds_class'><div id='their_banner_html_".$homepgae_banners[$i]['banner_id']."' class='their_html_container'>".html_entity_decode(base64_decode($homepgae_banners[$i]['banner_html']))."</div></div></div></div>";
			}
			$total_carosal_banners++;
			$add_classe_active++;
		}
	}
}

if($total_carosal_banners > 0){
	?>
	<script>
		$('#carosal_banner').html("<?php echo trim(str_replace('"', "'", preg_replace('/\s+/', ' ', $all_carosal_html))); ?>");
	</script>
	<?php
} else{
	?>
	<script>
		$('#carosal_banner').html("<div class='item active'><img src='http://porcantidad.com/download/image/assets/images/bannersld2.jpg' alt='...'></div>");
	</script>
	<?php
}
echo $footer;
?>