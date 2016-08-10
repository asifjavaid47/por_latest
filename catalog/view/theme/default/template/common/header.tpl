<!DOCTYPE html><!--[if IE]><![endif]--><!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]--><!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]--><!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
	<meta charset="UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Xcantidad.com - Conviene más!</title>
	<!-- <title><?php echo $title; ?></title> -->
	<base href="<?php echo $base; ?>"/>
	<?php if($description){ ?>
		<meta name="description" content="<?php echo $description; ?>"/>
	<?php } ?>
	<?php if($keywords){ ?>
		<meta name="keywords" content="<?php echo $keywords; ?>"/>
	<?php } ?>
	<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src='http://code.jquery.com/ui/1.11.4/jquery-ui.js'></script>
	<script src="http://underscorejs.org/underscore-min.js"></script>
	<script src="catalog/view/javascript/mustache.min.js"></script>
	<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
	
	
	<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
	<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../upload/catalog/view/javascript/assets/js/easyResponsiveTabs.js"></script>
	<script src="../upload/catalog/view/javascript/assets/js/jquery.hoverIntent.js"></script>
	<link href="catalog/view/javascript/assets/easy-responsive-tabs.css" rel="stylesheet" media="screen"/>
	<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css"/>
	<meta name="viewport" content="width=device-width">
	<?php foreach($styles as $style){ ?>
		<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>"/>
	<?php } ?>
	<!--<script src="catalog/view/javascript/common.js" type="text/javascript"></script>-->
	<?php foreach($links as $link){ ?>
		<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
	<?php } ?>
	<?php foreach($scripts as $script){ ?>
		<script src="<?php echo $script; ?>" type="text/javascript"></script>
	<?php } ?>
	<?php foreach($analytics as $analytic){ ?><?php echo $analytic; ?><?php } ?>
	<link href="catalog/view/javascript/assets/porcantidad.css" rel="stylesheet" type="text/css"/>
	<link href="catalog/view/javascript/assets/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<!--silder css & js start here-->
	<link href="catalog/view/javascript/assets/style.css" rel="stylesheet" type="text/css"/>
	<!--silder css & js end here-->
	<!-- <script src="catalog/view/javascript/assets/js/jquery.min.js" type="text/javascript"></script>-->
	<script>
		$(document).ready(function(){
			$("#flip").click(function(){
				$("#panel").slideToggle("slow");
			});
			
		});
		
		String.format = function(){
			var s = arguments[0];
			for(var i = 0; i < arguments.length - 1; i++){
				var reg = new RegExp("\\{" + i + "\\}", "gm");
				s = s.replace(reg, arguments[i + 1]);
			}
			return s;
		};
	</script>
	<style>
		.tool_tip {
			position: relative;
		}
		
		.tool_tip > .tool_span {
			position: absolute;
			top: 70px;
			background: rgba(0, 0, 0, 0.5);
			color: #fff;
			padding: 6px 11px;
			font-size: 12px;
			max-width: 137px;
			border-radius: 3px;
			z-index: 100;
			display: none;
			
			left: 50%;
			transform: translateX(-50%);
			transition: all 0.25s ease-in-out;
		}
		
		.tool_tip > .tool_span:after {
			content: "";
			border: 8px solid transparent;
			position: absolute;
			top: -16px;
			border-bottom-color: rgba(0, 0, 0, 0.5);
			left: 0;
			right: 0;
			width: 10px;
			margin: 0 auto;
		}
		
		.tool_tip:hover > .tool_span {
			display: block;
			top: 50px;
		}
		.head_link{
			font-weight: normal!important;
			color: #ccc;
		}
		.head_link:hover{
			color: white !important;
		}
	</style>
</head>
<body class="main-bgcolor">
<div class="wrapper">
	<!--top bar head start LC-->
	<div class="header-main-block header-main-color">
		<div class="container">
			<div class="row">
				<div class="col-xs-1 col-sm-2 p0" style="margin-top: 10px;">
					<div class="logo-container">
						<a href="<?php echo $base; //echo $home; ?>">
							<img src="<?php echo $base; ?>image/assets/images/logo.png" alt="" style="max-width: initial;" class="hidden-xs"/>
							<img src="<?php echo $base; ?>image/assets/images/logo-abrigded.png" alt="" style="max-width: initial;" class="hidden-sm hidden-md hidden-lg"/>
						</a>
						</a>
					</div>
				</div>
				
				<?php if($search_hide == 0){ ?>
					<div class="col-xs-6 col-sm-5" style="padding-right:0px">
						
						<div class="search-bar-container">
							<div class="search-input-block">
								<div class="search-txtfild">
									<?php
									
									if(isset($_GET['search'])){
										$value_search = $_GET['search'];
									} else{
										$value_search = "";
									}
									
									if(isset($_GET['quantity'])){
										$value_quantity = $_GET['quantity'];
									} else{
										$value_quantity = 1;
									}
									
									
									?>
									
									<input type="text" name="search" value="<?php echo $value_search; ?>" placeholder="Encontrá lo que querés!" id="input-search" class=" search-enter"/>
								</div>
								<div class="clearfix"></div>
							</div>
							<!--asif changes -->
						
						</div>
					
					</div>
					
					
					<div class="col-xs-3 col-sm-2 p0">
						<div class="search-bar-container">
							
							<div class="minus-btn-qty hidden-xs" style="width:15%;max-width:initial;">
								<button id='s_minus_products'><i class="fa fa-caret-down" aria-hidden="true"></i></button>
							</div>
							
							<div class="textbox-qty" style="width:40%;max-width:initial;">
								<input id='quantity_products_header' type="text" name="quantity" onkeypress=" return isNumber(event);" class="search-enter" placeholder="100" value="<?php echo $value_quantity; ?>">
							</div>
							
							<div class="minus-btn-qty hidden-xs" style="width:15%;max-width:initial;">
								<button id='s_add_products'><i class="fa fa-caret-up" aria-hidden="true"></i></button>
							</div>
							<div class="search-btn" style="max-width:initial;padding:0;">
								<button id="btn-search" style="padding: 0;text-align: center">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
					
					</div>
				
				<?php } ?>
				
				<div class="col-sm-3 p0 hidden-xs">
					<div class="top-icons-container">
						
						<?php if($search_hide == 0){ ?>
							
							<ul>
								<?php if($logged){ ?>
									<li class="pro_drop">
										<span class="glyphicon glyphicon-user white-hover head_link" style="font-size: 14px;"  aria-hidden="true"></span>
										
										<div class="drop_opt">
											<i class="fa fa-caret-up" aria-hidden="true"></i>
											<a href="<?php echo $base; ?>index.php?route=dashboard/summary">Mi
												Cuenta
											</a>
											<a href="<?php echo $base; ?>index.php?route=customuserdetail/editaccount">Mis
												Datos
											</a>
											<a href="<?php echo $base; ?>index.php?route=customuserdetail/resetpwd">Cambiar
												Contraseña
											</a>
											<a href="<?php echo $base; ?>index.php?route=account/logout">Salir</a>
										</div>
									</li>
									
									<li class="line-divi"><img src="<?php echo $base; ?>image/assets/images/icon-divi.png"></li>
									<li>
										<a class="white-hover head_link" id="sell" href="<?php echo $base; ?>index.php?route=createlisting/category">Vender</a>
									</li>
								<?php } else{ ?>
									
									<li>
										<a class="white-hover head_link" id="register" href="<?php echo $base; ?>index.php?route=account/register">
											Registrate
										</a>
									</li>
									<li class="line-divi"><img alt="" src="<?php echo $base; ?>image/assets/images/icon-divi.png">
									</li>
									<li>
										<a class="white-hover head_link" id="login" href="<?php echo $base; ?>index.php?route=account/register/login">
											Ingresá
										</a>
									</li>
									<li class="line-divi"><img alt="" src="<?php echo $base; ?>image/assets/images/icon-divi.png">
									</li>
									<li>
										<a class="white-hover head_link" id="sell" href="<?php echo $base; ?>index.php?route=createlisting/category">
											Vender
										</a>
									</li>
								<?php } ?>
							</ul>
						
						
						<?php } ?>
						
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="col-sm-3 p0 hidden-sm hidden-md hidden-lg">
					
					
					<div class="res-menu hidden-lg hidden-md">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" STYLE="MARGIN-TOP: 10PX;height: 35px;width: 35px;padding-left: 5px;">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<div id="navbar" class="collapse navbar-collapse res-menu1 " style="background-color: white;">
							<ul class="nav navbar-nav ">
								<?php if($logged){ ?>
									<li>
										<a id="sell" href="<?php echo $base; ?>index.php?route=createlisting/category">Vender</a>
									</li>
									<li>
										<a href="#"><img src="<?php echo $base; ?>image/assets/images/user-img.png"></a>
									</li>
									<li>
										<a href="<?php echo $base; ?>index.php?route=dashboard/summary">Mi
											Cuenta
										</a>
									</li>
									<li>
										<a href="<?php echo $base; ?>index.php?route=customuserdetail/editaccount">Mis
											Datos
										</a>
									</li>
									<li>
										<a href="<?php echo $base; ?>index.php?route=customuserdetail/resetpwd">Cambiar
											Contraseña
										</a>
									</li>
									<li>
										<a href="<?php echo $base; ?>index.php?route=account/logout">Salir</a>
									
									</li>
								<?php } else{ ?>
									
									<li>
										<a class="white-hover" id="register" href="<?php echo $base; ?>index.php?route=account/register">
											Registrate
										</a>
									</li>
									
									<li>
										<a class="white-hover" id="login" href="<?php echo $base; ?>index.php?route=account/register/login">
											Ingresá
										</a>
									</li>
									
									<li>
										<a class="white-hover last-br" id="sell" href="<?php echo $base; ?>index.php?route=createlisting/category">
											Vender
										</a>
									</li>
								<?php } ?>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	
	<div class="clr"></div>
	
	<script type="text/javascript">
		$('#btn-search').bind('click', function(){
			url = 'index.php?route=product/search';
			
			var search = $('input[name=\'search\']').prop('value');
			var quantity = $('input[name=\'quantity\']').prop('value');
			var min_price = $('input[name=\'min_price\']').prop('value');
			var max_price = $('input[name=\'max_price\']').prop('value');
			if(quantity){
				url += '&quantity=' + encodeURIComponent(quantity);
			}
			if(search){
				url += '&search=' + encodeURIComponent(search);
			}
			if(min_price && max_price){
				url += '&price=' + min_price + '-' + max_price;
			}
			var category_id = $('select[name=\'category_id\']').prop('value');
			if(category_id > 0){
				url += '&category_id=' + encodeURIComponent(category_id);
			}
			
			check_box_available = $('.solo-en-block').children(0);
			if(check_box_available.length > 0){
				var checked_checkbox = $('input:checkbox[name=vehicle]:checked');
				if(checked_checkbox.length > 0){
					var as = $('input[name=\'vehicle\']').prop('value');
					current_location = window.location.href;
					if(current_location.indexOf("category_id") > 0){
						splitted_location = current_location.split("&category_id=");
						location = splitted_location[0] + '&category_id=' + as;
					}
				}
				else{
					if(checked_checkbox.length == 0){
						var as = $('input[name=\'vehicle\']').prop('value');
						current_location = window.location.href;
						var search = $('input[name=\'search\']').prop('value');
						var a = current_location.replace('&category_id=' + as, '');
						current_url = a;
						splitted_location = current_url.split('search=');
						new_location = splitted_location[0] + "search=" + search;
						url = new_location;
						
					}
				}
			}
			var sub_category = $('input[name=\'sub_category\']:checked').prop('value');
			if(sub_category){
				url += '&sub_category=true';
			}
			
			var filter_description = $('input[name=\'description\']:checked').prop('value');
			if(filter_description){
				url += '&description=true';
			}
			location = url;
		});
		$('.search-enter').bind('keydown', function(e){
			if(e.keyCode == 13){
				$('#btn-search').trigger('click');
			}
		});
		$('select[name=\'category_id\']').on('change', function(){
			if(this.value == '0'){
				$('input[name=\'sub_category\']').prop('disabled', true);
			}
			else{
				$('input[name=\'sub_category\']').prop('disabled', false);
			}
		});
		$('select[name=\'category_id\']').trigger('change');
	</script>
	
	<script type="text/javascript">
		function isNumber(evt){
			var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
			if(iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
				return false;
			}
			return true;
		}
	</script>
	<script type="text/javascript">
		$('#s_minus_products').click(function(){
			quantity_products_header_val = $('#quantity_products_header').val();
            if (quantity_products_header_val > 1) {
	            quantity_products_header_val--;
	            $('#quantity_products_header').val(quantity_products_header_val);
			}
		});
		$('#s_add_products').click(function(){
			quantity_products_header_val = $('#quantity_products_header').val();
			quantity_products_header_val++;
			$('#quantity_products_header').val(quantity_products_header_val);
		});
	</script>
	<!-- hadi code -->
	<script type="text/javascript">
		$('body').on('click', '.dropdown-toggle', function(){
			///alert("ok");
			
			if($('.btn-group').hasClass('open')){
				$('.btn-group').removeClass('open');
			}
			else{
				$(".btn-group").addClass("open");
				$('.dropdown-toggle').attr("aria-expanded", "true");
			}
		});
		$('.language-select').click(function(){
			var long_code = "";
			long_code = $(this).attr("name");
			$("#lang_code").val(long_code);
			$("#form-language").submit();
		});
	</script>
	<!-- hadi code end -->
	<script src="catalog/view/javascript/jquery.flexisel.js" type="text/javascript"></script>
</div>