<?php
if(!$check_url == 'customuserdetail/companydetail' || !$check_url == 'customuserdetail/vendordetail' || !$check_url == 'customuserdetail/userdetail' || !$check_url == 'account/register'){
	global $loader, $registry;
	$loader->model('catalog/category');
	$modelCat = $registry->get('model_catalog_category');
	?>
	<div class="fine-what-container" style="background-color:white;padding-bottom:35px">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div id="find-head" class="find-head">
						Todas las categorias
					</div>
					<div class="find-head-content">
						Encontrá lo que querés
					</div>
				</div>
				<?php //$allcategories = $modelCat->getCategories();
				?>
				<?php $allcategories = $modelCat->getAllCategory();  //echo "<pre>";print_r($allcategories);
				?>
				
				<?php
				$level_one_category = $modelCat->get_level_one_category(59);
				$level_one_category1 = $modelCat->get_level_one_category(98);
				?>
				
				
				<div class="col-sm-12">
					<div class="row">
						<div class="col-sm-8" style="margin-bottom:10px;">
							<span style="font-size:14px; color:#505050; ">Productos</span>
						</div>
						
						<div class="col-sm-4" style="margin-bottom:10px">
							<span style="font-size:14px; color:#505050">Servicios</span>
						</div>
					</div>
				</div>
				
				
				<div class="col-sm-8">
					<?php
					$i = 0;
					foreach($level_one_category as $category){
						echo $i == 0? '<div class="col-sm-3">':'';
						?>
						<div style="margin-bottom:6px;">
							<a href="index.php?route=product/category&path=<?php echo trim($category['category_id']); ?>"><?php echo $category['name']; ?></a href>
						</div>
						<?php
						$i++;
						if($i == 9){
							echo $i == 9? '</div>':'';
							$i = 0;
						}
					} ?>
				
				</div>
			</div>
			<div class="col-sm-4">
				<?php
				$j = 0;
				foreach($level_one_category1 as $category){
					echo $j == 0? '<div class="col-sm-6">':'';
					?>
					<div style="margin-bottom:6px;">
						<a href="index.php?route=product/category&path=<?php echo trim($category['category_id']); ?>"><?php echo $category['name']; ?></a>
					</div>
					<?php
					$j++;
					if($j == 8){
						echo $j == 8? '</div>':'';
						$j = 0;
					}
				} ?>
			</div>
		
		
		</div>
	</div></div>
<?php } ?>
<div class="clearfix"></div>

<style>


	@media (max-width:767px) {

		.footer-main{
			display:none;
		}
		#derechos{
			display:none;
		}

		.termofuse-privacy-movile{
			margin-bottom:0px!important;


		}

		.fine-what-container{
			display:none;
		}
		.copyright-txt{
			height:32px;
			padding-top:0px;
			padding-bottom: 0px;
		}
		.copyright{
			height:32px;
			padding-top:0px;
			padding-bottom:!important;

		}

		.copyright-txt a {
			color:#aeaeae!important;
		}
		.footer-paragraph{
			margin:0!important;
		}



	}

	@media (min-width:768px ) and (max-width:991px ) {

		.footer-main{
			display:none;
		}
		#derechos{
			display:none;
		}

		.termofuse-privacy-movile{
			margin-bottom:0px!important;


		}

		.fine-what-container{
			display:none;
		}
		.copyright-txt{
			height:32px;
			padding-top:0px;
			padding-bottom: 0px;
		}
		.copyright{
			height:32px;
			padding-top:0px;
			padding-bottom: 0px;
			color: #aeaeae!important;
		}
		.footer-paragraph{
			margin:0!important;
		}


	}


	@media (min-width:992px ) and (max-width:1199px ) {

		.termofuse-privacy-movile{
			display:none;

		}

	}


	@media (min-width:1200px ) {

		.termofuse-privacy-movile{
			display:none;

		}

	}

</style>
<script>
	function makeFooterStickToBottom(){
		window.scrollTo(0, 0);
		var browserHeight = window.innerHeight;
		
		var footer = $('.footer');
		var copyright = $('.copyright');
		var copyrightEnd = copyright.position().top + copyright.height();
		
		if(copyrightEnd < browserHeight){
			var newPadding = browserHeight - copyrightEnd + 'px';
			if(footer.length != 0){
				var footer = $('.footer-main').css('margin-top', 0);
				footer.css('margin-top', newPadding);
			}
			else{
				copyright.css('margin-top', newPadding);
			}
			
		}
	}
	
	$(document).ready(makeFooterStickToBottom);
	$(window).resize(makeFooterStickToBottom);
</script>
<?php if($footer_hide == 0){ ?>

<div class="push"></div></div>
<div class="footer">
	
	<div class="footer-main header-main-color">
		<div class="container">
			<div class="row">
				<div id="footer-logo" class="col-sm-3 col-md-3 col-lg-3">
					<div class="footer-logo-block">
						<img src="<?php echo $base; ?>image/assets/images/footer_logo.png" alt="">
					</div>
				</div>
				<div class="col-sm-9 col-md-9 col-lg-9 border-line-block">
					<div class="information-main col-sm-8">
						<div class="row">
							<div class="col-sm-12">
								<div class="footer-information-head">
									Información
								</div>
								<div class="information-content">
									<div class="information-con-one">
										<a href="<?php echo $base; ?>index.php?route=account/termofuse"><i class="fa fa-circle-o"></i>
											Términos y Condiciones
										</a>
									</div>
									<div class="information-con-one">
										<a href="<?php echo $base; ?>index.php?route=account/privacy"><i class="fa fa-circle-o"></i>
											Políticas de Privacidad
										</a>
									</div>
									<div class="information-con-one">
										<a href="mailto:contacto@xcantidad.com?Subject=Contact Us" target="_top">
											<i class="fa fa-circle-o"></i> Contactanos
										</a>
									</div>
									<div class="information-con-one">
										<a href="mailto:reporte@xcantidad.com?Subject=Report a problem" target="_top">
											<i class="fa fa-circle-o"></i>Reportá un Problema
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="social-media" class="cards-block col-sm-4">
						<div class="social-icon-block">
							<div class="footer-information-head padding0">Mantenete conectado</div>
							<a href="http://Facebook.com/xcantidad" target='blank'><i class="fa fa-facebook"></i></a>
							<a href="http://Twitter.com/xcantidad" target='blank'><i class="fa fa-twitter"></i></a>
							<a href="http://ar.linkedin.com/in/xcantidad" target='blank'><i class="fa fa-linkedin"></i></a>
							<a href="http://Youtube.com/channel/UCn7-HFAgt0SPd9ND8kikQ6g" target='blank'><i class="fa fa-youtube"></i>
							</a>
						</div>
						<div class="clr"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<?php } ?>
	
	
	<div class="copyright">
		<div class="container">
			<div class="copyright-txt">
				<div><span class="termofuse-privacy-movile"><a href="<?php echo $base; ?>index.php?route=account/termofuse"><i class="fa"></i>
						Términos y Condiciones
					</a>|
					<a href="<?php echo $base; ?>index.php?route=account/privacy"><i class="fa"></i>
						Políticas de Privacidad
				</a></span>

				</div>
				<p class="footer-paragraph">Copyright © 2016 <span><a href="#">porcantidad.com S.A.</a></span> <span id="derechos">.Todos los derechos Reservados</span></p>
			</div>
		</div>
	</div>
	
	<!--MENU START HERE-->
	<script src="catalog/view/javascript/superfish.js" type="text/javascript"></script>
	<script type="text/javascript">
		//<![CDATA[
		var listdeal = [];
		//]]>
	</script>
	<script type="text/javascript">      //<![CDATA[
		$("#sp_vertical_megamenu li:has(.spvmm_container_menu_child)").doubleTapToGo();
		
		function isMobile(){
			return navigator.userAgent.match(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i);
		}
		
		jQuery(document).ready(function($){
			(function(element){
				var el = $(element), vf_megamenu = $('.vf-megamenu', el),
					level1 = $('.vf-megamenu >.spvmm-havechild', el),
					_li = $('.spvmm-havechild', el),
					vf_button = $('.vf-button', el),
					nb_hiden = 10;
				if(level1.length && level1.length > nb_hiden){
					$('.more-view', vf_megamenu).on('click touchstart', function(){
						if(level1.hasClass('cat-visible')){
							vf_megamenu.find('.cat-visible').removeClass('cat-visible').addClass('cat-hidden').stop().slideDown(400);
							$(this).html('<i class="fa fa-minus-square-o"></i>Close Categories');
						}
						else{
							if(level1.hasClass('cat-hidden')){
								vf_megamenu.find('.cat-hidden').removeClass('cat-hidden').addClass('cat-visible').stop().slideUp(200);
								$(this).html('<i class="fa fa-plus-square-o"></i>More Categories');
							}
						}
					});
				}
				
				function _vfResponsiveMegaMenu(){
					if($(window).width() <= 767){
						vf_megamenu.hide();
						$('.cat-title', el).on('click', function(){
							$(this).toggleClass('active').parent().find('ul.vf-megamenu').stop().slideToggle('medium');
							return false;
						});
						_li.addClass('vf-close');
						_li.children('div').css('display', 'none');
						if(vf_button.length){
							vf_button.on('click', function(){
								var _this = $(this), li = _this.parent(), ul = li.children('ul');
								var _div = li.children('div');
								if(li.hasClass('vf-close')){
									li.removeClass('vf-close').addClass('vf-open');
									_div.stop(false, true).slideDown(500);
									_this.removeClass('icon-close').addClass('icon-open');
								}
								else{
									li.removeClass('vf-open').addClass('vf-close');
									_div.stop(false, true).slideUp(200);
									_this.removeClass('icon-open').addClass('icon-close');
								}
								return;
							});
						}
					}
					else{
						$('.cat-title', el).unbind('click');
						vf_button.unbind('click');
						$('.cat-title', el).removeClass('active');
						vf_megamenu.removeAttr('style');
						_li.addClass('vf-close');
						_li.children('div').removeAttr('style');
						vf_button.removeClass('icon-open').addClass('icon-close');
					}
				}
				
				_vfResponsiveMegaMenu();
				
				if(isMobile()){
				}
				else{
					$(window).on('resize', function(){
						_vfResponsiveMegaMenu();
					});
				}
			})('#sp_vertical_megamenu');
		});
		//]]>
	</script>
	
	<script>
		$(".tool_tip").hover(
			function(){
				var title = $(this).attr("data-title");
				$(this).append("<span class='tool_span'>" + title + "</span>");
			},
			function(){
				$(".tool_tip span").remove();
			}
		);
	
	</script>
	

	
	
	<script>
		$(document).ready(function(){
			$(".res-find-what").click(function(){
				$(".show-in-mobile").slideToggle("slow");
			});
			
			$('.list-grid-switch').on('click', function(){
				var title = $(this).attr("title");
				if(title == 'List'){
					$("#grid-view-area").hide();
					$("#list-view-area").show();
					$("#list-view-area").css("display", "block");
				}
				if(title == 'Grid'){
					$("#list-view-area").hide();
					$("#grid-view-area").show();
					$("#grid-view-area").css("display", "block");
				}
			});
			
			$('.plus_dropdown').click(function(){
				$(this).next('.child_links').toggleClass('show');
			});
			
		});
	</script>
	
	<script>
		$(function(){
			$('.flip-desk-hide').click(function(){
				$(this).next('div').slideToggle();
				
				$(this).parent().siblings().children().next().slideUp();
				return false;
			});
		});
	</script>
	<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->
	</body>
	</html>