<?php
echo $header;
?>
	<style type="text/css">
		.mar_req_height_80 {
			height: 90px;
			
		}
		
		.txtcolor {
			color: red;
			font-size: 10px;
		}
		
		@media (max-width: 767px) {
			
			.product-condition-responsive {
				width: 34% !important;
			}
			
			.btn.btn-primary.desc-continue {
				width: 100%;
				height: 45px;
				padding-top: 10px;
				margin-top: 20px;
			}
			
			.nav.nav-tabs.listing-tabs {
				display: none
			}
			
			.listing-wrapper .common-content {
				
				padding-left: 5px;
				padding-right: 5px;
				padding-top: 10px;
				margin-top: 10px;
				
			}
			
			.pm5 {
				padding: 0px 5px;
				
			}
		}
		
		@media (min-width: 768px) and (max-width: 991px) {
			
		}
		
		@media (min-width: 992px) and (max-width: 1199px) {
			
		}
		
		@media (min-width: 1200px) {
			.editor-margin {
				margin-left: 15px;
			}
		}
	
	
	</style>  <input type="hidden" value="<?php echo $current_customer_id; ?>" class="current_customer_id"/>
	<div class="min-height">
		<div class="container">
			<div class="row">
				<div class="container">
					<div class="row">
						<div class="col-sm-12" style="margin-top:-48px">
							<div class="buying-process-main">
								<div class="cart-section-block register" style="line-height:20px;">
									<div class="cart-step-one">
										<div class="clearfix"></div>
									</div>
									<div class="clearfix"></div>
									<!--    original tabs!-->
									<ul class="nav nav-tabs listing-tabs" role="tablist" style="background-color:#e6ebf5;">
										<li role="presentation" class="active">
											<a href="#home" aria-controls="home" role="tab" data-toggle="tab" class="disable-cat tabs-stl">
												Seleccion
												de Categoría
											</a>
										</li>
										<li role="presentation" class="tab-nolink">
											<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" class="disable-desc tabs-stl">
												Descripción
												del producto
											</a>
										</li>
										<li role="presentation" class="tab-nolink">
											<a href="#messages" aria-controls="messages" role="tab" data-toggle="tab" class="disable-quantity-price tabs-stl">
												Cantidades
												y precios
											</a>
										</li>
										<li role="presentation" class="tab-nolink">
											<a href="#settings" aria-controls="settings" role="tab" data-toggle="tab" class="disable-review-listing tabs-stl">
												Revisión
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="clr"></div>
					</div>
				</div>
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 listing-wrapper pm0">
					<div class="common-content">
						<div class="clr"></div>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="home">
								<style>
									.col-cat {
										display: inline-block;
										width: 260px;
										white-space: nowrap;
										box-sizing: border-box;
									}
									
									.list-cate-main {
										max-width: 100%;
										overflow-y: hidden;
										white-space: nowrap;
										height: auto;
										position: relative;
										margin-left: 0;
										padding: 0 0 0px 0px;
										box-sizing: border-box;
										width: 100%;
										overflow-X: scroll;
									}
								</style>
								<div class="selected-categories" style="color:#332690;font-size:12px;height: 35px">
									<span class="first-category-select"></span>
									<span class="second-category-select"></span>
									<span class="third-category-select"></span>
									<span class="forth-category-select"></span>
									<span class="fifth-category-select"></span>
								</div>
								<div class="list-cate-main" style="background-color:inherit; margin-top:0; margin-bottom:0;min-height:21px;box-shadow:none">
									<div class="clr"></div>
									<div class="col-cat" id="sub_cat_1" style="display: none;margin-right: -4px;">
										<div class="listing-selection">
											<select size="3" class="sub-cat-1" style="font-size:12px;"></select>
										</div>
									</div>
									<div class="col-cat col-sm-3" style="font-size:12px;padding:0;margin-right: -4px;">
										<div class="listing-selection">
											<select size="3" class="main-cat">
												<?php foreach($get_category->rows as $key => $val): ?>
													<option value="<?php echo $val['category_id']; ?>"><?php echo $val['name']; ?></option>
												<?php endforeach; ?>
											</select>
										</div>
									</div>
									<div class="col-cat" id="sub_cat_2" style="display: none;margin-right: -4px;">
										<div class="listing-selection">
											<select size="3" class="sub-cat-2" style="font-size:12px;margin-right: -4px;"></select>
										</div>
									</div>
									<div class="col-cat" id="sub_cat_3" style="display: none;margin-right: -4px;">
										<div class="listing-selection">
											<select size="3" class="sub-cat-3" style="font-size:12px"></select>
										</div>
									</div>
									<div class="col-cat" id="sub_cat_4" style="display: none;margin-right: -4px;">
										<div class="listing-selection">
											<select size="3" class="sub-cat-4" style="font-size:12px"></select>
										</div>
									</div>
								</div>
								<div class="clr"></div>
								<label style="color:red;display: none;margin-left: 15px" class="select-catgegory-error">Seleccione una
									categoria</label>
								<div class="clr"></div>
								<a href="javascript:void(0);" class="btn btn-primary choose-cat-continue" style="margin-top: 15px;">
									Continuar
								</a>
							</div>
							<div style="col-sm-12">
								<!---------------------------------------------------------------------------------------------------------->
								<!---------------------------------------------------------------------------------------------------------->
							</div>
							<div role="tabpanel" class="tab-pane fade" id="profile">
								<div id="profile" class="tab-pane fade in active add-description" role="tabpanel">
									<div style="border:0;" class="createlst-tittle">Título del producto</div>
									<form class="form-inline">
										<div class="form-group" style="margin-top:20px;">
											<div class="col-sm-1 important-text" style="text-align:left">Título:*</div>
											<div class="col-sm-9 pm5">
												<input type="text" placeholder="Ej.: Sillas plásticas de jardín" class="form-control product-title pm5 wmfull" maxlength="64" style="padding-left:6px; color:#808080">
												<br>
												<span class="important-text">Quedan </span>
												<span id="prod_chars" style="color:#fa7905">64</span>
												<span class="important-text">carácteres</span>
												<br>
												<span style="display: none;color:red;font-size:12px;" class="error-product-title">Campo obligatorio</span>
											</div>
										</div>
										<div class="clr"></div>
										<div class="form-group" style="display:none;">
											<div class="col-sm-3 text-right">Tags:*</div>
											<div class="col-sm-9">
												<input type="hidden" placeholder="i.e,T-shirt for Man Christian Dior" class="form-control products-tag">
												<i class="fa fa-question-circle" aria-hidden="true" data-toggle="tooltip" data-placement="right" title="" data-original-title="To help search engines to find your listing"></i>
												<br>
												<span id="countWord">Enter tags saperated by commas, The more the better.</span>
											</div>
										</div>
										<div class="clr"></div>
										<div class="form-group">
											<div class="col-sm-1 important-text" style=" text-align:left">SKU:</div>
											<div class="col-sm-4">
												<input type="text" placeholder="Ej.: spj00223" class="form-control products-sku pm5 wmfull">
												<span class="span-product-sku" style="color:red; font-size:10px;">El código SKU ya existe, elegí otro o el sistema asignará uno!</span>
											</div>
										</div>
									</form>
									<div style="border:0;" class="createlst-tittle">Agregá fotos de tu producto</div>
									<br>
									<style>
										.photoBox {
											
											margin-right: 0px;
											padding: 0;
											margin-left: 15px;
											height: 110px;
											width: 110px;
											border: 1px solid #c8c8c8;
											margin-bottom: 10px;
										}
									</style>
									<div class="photobox-wrapper">
										<div class="col-sm-1 photoBox">
											<div class="addphotos-wrap">
												<img src="<?php echo $base; ?>image/no-image.png" style="padding: 1px;">
												<input type="file" class="img-browse" id="product_main_image" multiple/>
											</div>
											<span style="display: block;" class="text-center important-text">Foto Principal</span>
											<a style="display: block;" class="btn-delete text-center important-text">Borrar</a>
										</div>
										<div class="col-sm-1 photoBox">
											<div class="addphotos-wrap no-image">
												<img src="<?php echo $base; ?>image/no-image.png" class="product-hover-img" style="padding: 1px;"/>
												<input type="file" class="img-browse product-img-upload" index="0" multiple/>
											</div>
											<a style="display: block;" class="btn-delete text-center important-text">Borrar</a>
										</div>
										<div class="col-sm-1 photoBox">
											<div class="addphotos-wrap no-image">
												<img src="<?php echo $base; ?>image/no-image.png" class="product-hover-img" style="padding: 1px;"/>
												<input type="file" class="img-browse product-img-upload" index="1" multiple/>
											</div>
											<a style="display: block;" class="btn-delete text-center important-text">Borrar</a>
										</div>
										<div class="col-sm-1 photoBox">
											<div class="addphotos-wrap no-image">
												<img src="<?php echo $base; ?>image/no-image.png" class="product-hover-img" style="padding: 1px;"/>
												<input type="file" class="img-browse product-img-upload" index="2" multiple/>
											</div>
											<a style="display: block;" class="btn-delete text-center important-text">Borrar</a>
										</div>
										<div class="col-sm-1 photoBox">
											<div class="addphotos-wrap no-image">
												<img src="<?php echo $base; ?>image/no-image.png" class="product-hover-img" style="padding: 1px;"/>
												<input type="file" class="img-browse product-img-upload" index="3"/>
											</div>
											<a style="display: block;" class="btn-delete text-center important-text">Borrar</a>
										</div>
										<div class="col-sm-1 add-image" style="margin-right: 0px;
    padding: 0;
    margin-left: 15px;
    height: 110px;
    width: 110px;
    border: 1px solid #c8c8c8;
    margin-bottom: 10px;text-align: center;cursor: pointer;">
											<span style="line-height: 110px;">Agregar</span>
										</div>
									</div>
									<div class="clr"></div>
									<br/>
									<div class="createlst-tittle">Condición:</div>
									<span style="display:flex; float:left; margin-left: 15px;"><input type="radio" name="product_condition" class="product-condition" value="new" id="new_item"/></span>
									<div class="col-sm-1 important-text product-condition-responsive" style="text-align:right">
										<span>Nuevo</span></div>
									<br>
									<span style="float:left;    margin-left: 15px;"><input type="radio" name="product_condition" class="product-condition" value="Used" id="used_item"/></span>
									<div class="col-sm-1 important-text product-condition-responsive" style="text-align:right">
										<span>Usado</span></div>
									</br>
									<div class="clr"></div>
									<br>
									<div style="border:0;" class="createlst-tittle">Descripción del producto</div>
									<div class="clr"></div>
									<br>
									<div class="editor-margin">
										<main>
											<div class="adjoined-bottom">
												<div class="grid-container" style="max-width:initial;">
													<div>
														<textarea id="editor" name="editor"></textarea>
													</div>
												</div>
											</div>
										</main>
									</div>
									<span class="desc-require" style="color: red; display: inline; font-size: 12px; margin-left: 15px;">Por favor, agregá una descripción.</span>
									<div class="clr"></div>
									<br>
									<a class="btn btn-primary desc-continue pull-left" href="javascript:void(0);">Continuar</a>
								</div>
							</div>
							<div id="messages" class="tab-pane fade" role="tabpanel">
								<div style="border:0;" class="createlst-tittle">Precios</div>
								<form class="important-text">
									<br>
									<!-- *******************************************************Degradacion de precios*******************************************************************************-->
									<style type="text/css">
										.price-type input {
											
										}
										
										.tier-prices-design {
											width: 50%;
											margin-bottom: 0;
											border-collapse: collapse;
										}
										
										.tier-prices-design tr {
											height: 35px;
											background-color: #eee;
										}
										
										.tier-prices-design td {
											width: 50%;
											text-align: left;
											vertical-align: top;
											/*padding: 10px;*/
										}
										
										.tier-prices-design td:last-child {
											padding-left: 15px
										}
										
										.tier-prices-design > input {
											width: 80%;
											height: 15px;
										}
										
										.tier-prices-design label {
											display: block;
										}
										
										.not-active {
											pointer-events: none;
											cursor: default;
											
										}
										
										.tier-error {
											text-align: left;
											width: 80%;
											color: red;
											font-size: 12px;
											padding-bottom: 0px;
											margin-left: 15px;
											
											margin-top: 0px;
											line-height: 12px;
											
										}
										
										.subtitle {
											font-weight: bold;
										}
										
										.price-type, .price-type-option {
											display: inline;
										}
										
										.price {
											/*border: 2px solid black;*/
										}
										
										.input-price {
											height: 30px;
											line-height: 30px;
											padding-top: 7px;
											background-color: #eee;
											
											border-radius: 5px;
											border-style: none;
											width: 60%;
											color: black !important;
											border: 1px solid #eee;
											padding-left: 8px;
											margin-top: 9px;
											
										}
										
										.input-price:hover {
											background-color: white;
											border: 1px solid #bbb;
										}
										
										.input-price:focus {
											background-color: white;
											border: 1px solid #bbb;
										}
										
										.quantity-label-input {
											width: 30%;
											display: inline-block !important;
											text-align: right !important;
											padding-right: 5px;
										}
										
										.quantity-label-hc {
											padding-right: 38%;
										}
										
										.title-tier-price {
											background-color: #0055aa;
											text-align: center;
											color: white;
											font-weight: bold;
											padding-top: 4px;
											
										}
									</style>
									<table class="tier-prices tier-prices-design" border="0" style="margin-left:15px;">
										<tr>
											<td class="title-tier-price" style="padding-left:10%">
												Cantidad
											</td>
											<td class="title-tier-price">
												Precio
											</td>
										</tr>
									</table>
									<table class="tier-prices-design" border="0" style="margin-left:15px;width: 50%;margin-top: 15px">
										<tr>
											<td style="text-align:center;background-color: white">
												<a class="add-line btn btn-primary" href="#" style="text-align:center;display: inline-block;margin-bottom: 15px;">
													Agregar
												</a>
											</td>
											<td class="actions" style="background-color: white">
												<a class="remove-line btn btn-primary" style="margin-right:15px;visibility:hidden;" href="#" tabindex="-1">
													Quitar
												</a>
											</td>
										</tr>
										<tr style="background-color: white;padding-top:25px">
											<td style="width:100%;text-align: center;">
												<label style="display: inline;margin-right: 25px;font-weight: 600">Ver
													por: </label>
												<div class="price-type" style="text-align:center;">
													<div class="price-type-option">
														<input type="radio" name="price-type" value="unit" checked tabindex="-1">
														<span>Precio unitario</span>
													</div>
													<div class="price-type-option">
														<input type="radio" name="price-type" value="total" tabindex="-1">
														<span>Precio total</span>
													</div>
													<div class="price-type-option">
														<input type="radio" name="price-type" value="percentage" tabindex="-1">
														<span>Descuento</span>
													</div>
												</div>
											</td>
											<td>
												<a style="visibility:hidden;">Quitar</a>
											</td>
										</tr>
									</table>
									<script id="grid-template" type="text/template">
										<tr class="grid-template" style="height: 56px;border-bottom:2px solid white">
											<td class="quantity">
												<label style="text-align:center;padding-top:6%"></label>
												<input value="0" class="input-price input-quantity" style="width:40%;"/>
												<span style="display:none;" class="tier-error error-mandatory">Debes llenar este campo</span>
												<span style="display:none;" class="tier-error error-mustBeMore">El valor debe ser más alto</span>
												<span style="display:none;" class="tier-error error-must-be-integer">El valor debe no contener coma</span>
											</td>
											<td class="price">
												<span class="price-unit" style="font-size: 17px;color: #e86d00;font-weight: bold;display: inline-block;width: 15px;">$</span>
												<label style="text-align: left;display:inline-block;padding-left:8px;padding-top:6%"></label>
												<input value="0" class="input-price" data-toggle="tooltip" data-delay='{"show":"5000", "hide":"3000"}'/>
												<span style="display:none;" class="tier-error error-mandatory">Debés llenar este campo</span>
												<span style="display:none;" class="tier-error error-mustBeMore">El valor debe ser más alto</span>
												<span style="display:none;" class="tier-error error-mustBeLess">El valor debe ser más bajo</span>
												<span style="display:none;" class="tier-error error-mustBeLessPercentage">El valor debe ser menor a 100%</span>
											</td>
											<td class="actions" style="background-color:white ">
												<a class="remove-line btn btn-primary" style="margin-right:15px;display: inline-block;margin-top: 9px;" href="#" tabindex="-1">
													Quitar
												</a>
											</td>
										</tr>
									</script>
									<script>
										var unitPlaceholder = 'Precio unitario';
										var totalPlaceholder = 'Precio total';
										var percentajePlaceholder = 'Descuento';
										var initialSecondUnitLabel = '0';
										//var initialSecondUnitLabel = 'Por cantidad te regala descuentos';
										var currentPlaceholder = unitPlaceholder;
										
										
										function setPlaceholder(newValue){
											var currentSymbol = '$';
											switch(newValue){
												case 'unit':
													currentPlaceholder = unitPlaceholder;
													break;
												case 'total':
													currentPlaceholder = totalPlaceholder;
													break;
												case 'percentage':
													currentPlaceholder = percentajePlaceholder;
													currentSymbol = '%';
													break;
											}
											$('.tier-prices .price input').attr('placeholder', currentPlaceholder);
											$('.price-unit:not(:eq(0))').html(currentSymbol);
										}
										
										
										function makeLineSettings(type){
											switch(type){
												case 'unit':
													return {
														quantityType: 'span',
														quantityValue: '1',
														quantityLabel: 'X&nbsp;&nbsp;&nbsp;&nbsp;1',
														priceType: 'input',
														pricePlaceholder: unitPlaceholder,
														priceTooltip: 'Si cambia este monto, se modificaran los valores en proporcion',
														canDelete: false
													};
												case 'second':
													return {
														quantityType: 'span',
														quantityValue: '2',
														quantityLabel: 'X&nbsp;&nbsp;&nbsp;&nbsp;2',
														priceType: 'input',
														pricePlaceholder: initialSecondUnitLabel,
														priceTooltip: null,
														canDelete: false
													};
												default:
													return {
														quantityType: 'input',
														quantityLabel: 'X ',
														quantityPlaceholder: 'Cantidad',
														priceType: 'input',
														pricePlaceholder: currentPlaceholder,
														priceTooltip: null,
														canDelete: true,
														
														
													};
											}
										}
										
										function removeLine(element){
											element.parentElement.parentElement.remove();
											$('.add-line').removeClass('not-active');
										}
										
										function on(evt){
											var theEvent = evt || window.event;
											var key = theEvent.keyCode || theEvent.which;
											key = String.fromCharCode(key);
											var regex = /^[0-9.,]+$/;
											if(!regex.test(key)){
												theEvent.returnValue = false;
												if(theEvent.preventDefault){
													theEvent.preventDefault();
												}
											}
										}
										
										function addLine(line){
											
											var newRow = $($('#grid-template').html());
											
											var quantity = newRow.find('.quantity');
											quantity.find('input').val(line.quantityValue);
											
											quantity.find('label').html(line.quantityLabel);
											
											if(line.quantityType == 'input'){
												quantity.find('label').addClass('quantity-label-input');
												quantity.find('input').attr('placeholder', line.quantityPlaceholder);
											}
											else{
												quantity.find('label').addClass('quantity-label-hc');
												quantity.find('input').css('display', 'none');
											}
											
											
											var price = newRow.find('.price');
											price.find('input').val('');
											if(line.priceType == 'input'){
												price.find('label').css('display', 'none');
												price.find('input').attr('placeholder', line.pricePlaceholder);
												if(line.priceTooltip){
													price.change(function(){
														price.find('[data-toggle="tooltip"]').attr('title', line.priceTooltip);
														price.find('[data-toggle="tooltip"]').tooltip();
													});
												}
											}
											else{
												price.find('input').css('display', 'none');
												price.find('label').text(line.priceLabel);
											}
											
											if(!line.canDelete){
												newRow.find('.remove-line').css('visibility', 'hidden');
											}
											
											
											newRow.appendTo('.tier-prices');
											
											
											newRow.find('.remove-line').on('click', function(){
												removeLine(this);
												if($('.tier-prices tr').length == 6){
													$('.add-line').removeClass('not-active');
												}
												return false;
											});
											
											
											newRow.find('input').on('keydown', function(e){
												var evtobj = window.event ? event : e;
												if(evtobj.keyCode == 90 && evtobj.ctrlKey){
													return false;
												}
												
											});
											
											newRow.find('input').blur(function(){
												var itemPosition = $(this).parent().parent().index();
												var rows = $(this).parent().parent().parent().children().length - 1;
												var lastItem = itemPosition == rows;
												var isQuantityInput = $(this).hasClass('input-quantity');
												
												if(!lastItem){
													validate(false);
												}
												return true;
											});
											
											newRow.find('input').on('keypress', on);
											newRow.find('.quantity input').focus();
											setPlaceholder(priceType);
										}
										
										
										function getFromTo(from, to, quantity, price){
											var unitPrice = $('.tier-prices tr.grid-template:nth-child(2) .price input')[0].value;
											
											var round = function(num){
												return Math.round(num * 100) / 100;
											};
											if(from == 'unit' && to == 'total'){
												return round(quantity * price);
											}
											if(from == 'unit' && to == 'percentage'){
												return round(round(100 - ((price * 100) / unitPrice)));
											}
											if(from == 'total' && to == 'unit'){
												return round(price / quantity);
											}
											if(from == 'total' && to == 'percentage'){
												return round(100 - ((price / quantity * 100) / unitPrice));
											}
											if(from == 'percentage' && to == 'unit'){
												return round(unitPrice - (price * unitPrice / 100));
											}
											if(from == 'percentage' && to == 'total'){
												return round((unitPrice - (price * unitPrice / 100)) * quantity);
											}
											
											return parseFloat(price);
										}
										
										function changePriceType(from, to){
											var rows = $('.tier-prices tr.grid-template');
											
											
											for(var rowIndex in rows){
												if(rowIndex > 0){
													var quantity = $(rows.get(rowIndex)).find('.quantity input')[0].value;
													var price = $(rows.get(rowIndex)).find('.price input')[0].value;
													if(quantity == '' || price == ''){
														return;
													}
													
													var valueToEdit = $(rows.get(rowIndex)).find('.price input');
													var transformedValue = getFromTo(from, to, quantity, price);
													if(rowIndex == 1){
														currentSecondUnitPrice = transformedValue;
													}
													
													
													valueToEdit.val(transformedValue);
												}
											}
											return true;
										}
										
										var priceType = 'unit';
										var currentSecondUnitPrice = 0;
										
										var showError = function(inputToShow, errorSelector, focus){
											inputToShow.parent().find(errorSelector).css('display', 'block');
											if(focus){
												inputToShow.focus();
											}
										};
										
										var validateMandatory = function(inputToValidate, focus){
											if(!inputToValidate.val()){
												showError(inputToValidate, '.tier-error.error-mandatory', focus);
												return false;
											}
											return true;
										};
										
										
										var validateLessThan = function(inputValue, previousInputValue, input, focus){
											if(inputValue >= previousInputValue){
												showError(input, '.tier-error.error-mustBeLess', focus);
												return false;
											}
											return true;
										};
										//Tomás: added special validation function for percentage in order for error messages to be coherent.
										var validateMoreThanPercentage = function(inputValue, previousInputValue, input, focus, i){
											if (inputValue > previousInputValue){
												showError(input, '.tier-error.error-mustBeMore', focus);
												return false;
											}
											return true;
										}
										
										//Tomás: added i (line number) parameter so that it doesn't compare percentage vs value in the first discount line.
										var validateLessThanPercentage = function(inputValue, previousInputValue, input, focus, i){
											if(inputValue >= 100){
												showError(input, '.tier-error.error-mustBeLessPercentage', focus);
												return false;
											}
											else if((inputValue > previousInputValue) && (i>1)){
												showError(input, '.tier-error.error-mustBeMore', focus);
												return false;
											}
											return true;
										};
										
										var validateMoreThan = function(inputValue, previousInputValue, input, focus){
											if(inputValue <= previousInputValue){
												showError(input, '.tier-error.error-mustBeMore', focus);
												return false;
											}
											return true;
										};
										
										
										var validateIsInteger = function(inputValue, input, focus){
											if(inputValue%1!=0){
												showError(input, '.tier-error.error-must-be-integer', focus);
												return false;
											}
											return true;
										};
										
										function validate(willFocusOnError){
											
											$('.tier-error').css('display', 'none');
											var tierLines = $('.tier-prices tr.grid-template');
											
											
											for(var i = 0; i < tierLines.length; i++){
												var line = $(tierLines[i]);
												var quantityInput = line.find('.quantity input');
												var quantityValue = parseFloat(quantityInput.val());
												
												
												//-------------------- QUANTITIY --------------------
												if(!validateMandatory(quantityInput, willFocusOnError)){
													return false;
												}
												
												
												if(!validateIsInteger(quantityValue, quantityInput, willFocusOnError)){
													return false;
												}

												if(!validateMoreThan(quantityValue, 0, quantityInput, willFocusOnError)){
													return false;
												}
												
												if(i > 1){
													var previousLine = $(tierLines[i - 1]);
													var previousQuantityValue = parseInt(previousLine.find('.quantity input').val());
													
													if(!validateMoreThan(quantityValue, previousQuantityValue, quantityInput, willFocusOnError)){
														return false;
													}
												}
												
												//-------------------- PRICE --------------------
												
												var priceInput = line.find('.price input ');
												
												if(priceType == 'percentage' && i > 0){
													if(!validateLessThanPercentage(parseFloat(priceInput.val()), 100, priceInput, willFocusOnError, i)){
														return false;
													}
												}
																								
												var priceUnitValue = getFromTo(i == 0 ? 'unit' : priceType, 'unit', quantityValue, priceInput.val());
												
												if(!(i < 2 && tierLines.length == 2)){
													if(!validateMandatory(priceInput, willFocusOnError)){
														return false;
													}
													
													if(!validateMoreThan(priceUnitValue, 0, priceInput, willFocusOnError)){
														return false;
													}
												}
												
												if(i > 1){
													var previousLine = $(tierLines[i - 1]);
													var previousQuantityValue = parseInt(previousLine.find('.quantity input').val());
													
													var previousPriceUnitValue = getFromTo(priceType, 'unit', previousQuantityValue, previousLine.find('.price input ').val());
													if(priceType != 'percentage'){
														if(!validateLessThan(priceUnitValue, previousPriceUnitValue, priceInput, willFocusOnError)){
															return false;
														}
													}
													else if (priceType == 'percentage'){
														if (!validateMoreThanPercentage(priceUnitValue, previousPriceUnitValue, priceInput, willFocusOnError)){
															return false;
														}
													}
												}
											}
											return true;
										}
										
										var currentUnitPrice = 0;
										
										$(document).ready(function(){
											addLine(makeLineSettings('unit'));
											addLine(makeLineSettings('second'));
											
											
											$('.add-line').on('click', function(){
												var linesCount = $('.tier-prices tr.grid-template').length;
												if(linesCount == 5){
													return false;
												}
												
												if(!validate(true)){
													return false;
												}
												addLine(makeLineSettings());
												
												var newLinesCount = $('.tier-prices tr.grid-template').length;
												if(newLinesCount == 5){
													$('.add-line').addClass('not-active');
												}
												
												return false;
											});
											
											
											var currentPriceTypeRadio = $('[name="price-type"]')[0];
											$('[name="price-type"]').change(function(e){
												if(!validate(true)){
													$(currentPriceTypeRadio).click();
													return false;
												}
												
												changePriceType(priceType, this.value);
												setPlaceholder(this.value);
												priceType = this.value;
												currentPriceTypeRadio = this;
											});
											
											
											var firstPrice = $('.tier-prices tr:nth-child(2) .price input');
											firstPrice.change(function(){
												
												var newPrice = parseFloat(firstPrice.val());
												if(isNaN(newPrice)){
													return;
												}
												var tierLines = $('.tier-prices tr.grid-template');
												
												if(tierLines.length == 2){
													var discount = Math.round(newPrice * 0.9 * 100) / 100;
													discount = getFromTo('unit', priceType, 2, discount);
													currentSecondUnitPrice = discount;
													$('.tier-prices tr:nth-child(3) .price input').val(discount);
												}
												else{
													var tierLines = $('.tier-prices tr.grid-template');
													for(var i = 1; i < tierLines.length; i++){
														var line = $(tierLines[i]);
														var quantityInput = line.find('.quantity input');
														var quantityValue = parseInt(quantityInput.val());
														var priceInput = line.find('.price input ');
														var priceValue = parseFloat(priceInput.val());
														if(priceType != 'percentage'){
															priceValue = getFromTo(priceType, 'unit', quantityValue, priceValue);
															
															var newUnitValue = (newPrice / currentUnitPrice * priceValue);
															newUnitValue = getFromTo('unit', priceType, quantityValue, newUnitValue);
															priceInput.val(newUnitValue.toFixed(2).replace('.00', ''));
														}
													}
												}
												
												currentUnitPrice = newPrice;
											});
											
											$('.tier-prices tr.grid-template:nth-child(3) .price input').change(function(){
												var input = parseFloat(this.value);
												if(priceType != 'percentage' && input > currentSecondUnitPrice ||
													priceType == 'percentage' && input < currentSecondUnitPrice){
													this.value = currentSecondUnitPrice;
													alert('No se puede ingresar un descuento menor que el 10% en la segunda unidad');
													$(this).focus();
												}
											});
										});
									</script>
									<!-- ***********************fin degradacion ******************************-->
									<input type="hidden" class="form-control minimum-buy" value="1">
									<div style="border:0;" class="createlst-tittle">Stock</div>
									<br>
									<div class="form-group">
										<div class="col-sm-2" style="padding-left: 15px;line-height: 35px;">Stock
											Disponible:*
										</div>
										<div class="col-sm-1" style="    line-height: 0px;">
											<input type="text" onkeypress=" return isNumber(event);" placeholder="Ej.: 50" class="form-control avail-stock">
										</div>
									</div>
									<div class="clr"></div>
									<span class="span-avail-stock" style="margin-left:15px;color:red; font-size:10px;">El stock debe ser mayor que el máximo quantity de tier price</span>
									<br>
									<div style="border:0; display:none;" class="main-heading">Payment methods and
										discounts
									</div>
									<div class="col-sm-12" style="display:none;">
										<span class="col-sm-10 span-payment-method" style="color:red; font-size:10px;">Please check atleast one payment method</span>
										<span class="col-sm-10 span-cash-and-discount" style="color:red; font-size:10px;">Please select cash payment method for discount!</span>
										<span class="col-sm-10 span-wire-and-discount" style="color:red; font-size:10px;">Please select wire payment method for discount!</span>
										<span class="col-sm-10 span-credit-and-discount" style="color:red; font-size:10px;">Please select credit card payment method for discount!</span>
										<div class="col-sm-3 hpol">
											<div class="form-group col-sm-12">
												<input type="checkbox" id="cash_check" value="Cash">
												<label for="cash-check">Cash</label>
											</div>
											<div class="form-group col-sm-12">
												<input type="checkbox" id="wire_check" value="wire">
												<label for="wire-check">Wire</label>
											</div>
											<div class="form-group col-sm-12">
												<input type="checkbox" id="credit_check" value="credit card">
												<label for="credit-check">Credit Card</label>
											</div>
										</div>
										<div class="col-sm-6 hpol rt">
											<div class="col-sm-12">
												<input type="text" placeholder="i.e, 10" class="form-control pull-left cash-discount"><i class="prcnt-icon">%</i>
											</div>
											<div class="col-sm-12">
												<input type="text" placeholder="i.e, 10" class="form-control pull-left wire-discount"><i class="prcnt-icon">%</i>
											</div>
											<div class="col-sm-12">
												<input type="text" placeholder="i.e, 10" class="form-control pull-left credit-card-discount"><i class="prcnt-icon">%</i>
											</div>
											<i title="" data-placement="right" data-toggle="tooltip" aria-hidden="true" class="fa fa-question-circle" data-original-title="Add a discount to apply for each payment method. Enter 0 if you are not offering any discount."></i>
										</div>
									</div>
									<div class="clr"></div>
									<br>
									<div style="border:0;" class="createlst-tittle">Ubicación del Producto</div>
									<div class="col-sm-6" style="text-align: center;">
										<?php if(!empty($get_address)){ ?>
											<select name="shipping_ad" class="new-shipping-addr-dropdown form-control">
												<?php foreach($get_address as $key => $option_addr){ ?>
													<option value="<?php echo $key; ?>"><?php echo $option_addr; ?></option>
												<?php } ?>
											</select>
										<?php } ?>
										<a href="javascript:void(0)" class="new-address-link btn btn-primary" style="margin-top: 10px;">
											Agregar dirección
										</a>
										<div id="new_address">
											<div class="row">
												<input name="address_1" type="hidden" class="form-control checck-address-avail" value="<?php echo $adrs; ?>" placeholder="Dirección"/>
												<div class="form-group col-sm-9">
													<label for="address">Calle</label>
													<input style="width:100%;" name="address_1" type="text" class="form-control" value="" placeholder="Dirección" id="input-address-1"/>
													<?php if($error_userdet_address_1){ ?>
														<div class="text-danger span-address-valid txtcolor"><?php echo $error_userdet_address_1; ?></div>
													<?php } ?>
												</div>
												<div class="col-xs-3 pl0">
													<label for="zip">Número *</label>
													<input style="width:100%;" type="text" name="vendor_doornumber" value="" class="form-control new-door-numb" placeholder="Número"/>
													<?php if($error_userdet_vendor_doornumber){ ?>
														<div class="text-danger span-numb-valid txtcolor"><?php echo $error_userdet_vendor_doornumber; ?></div>
													<?php } ?>
												</div>
											</div>
											<div class="form-group row">
												<div class="col-xs-4">
													<label for="zip">Piso</label>
													<div class="clearfix"></div>
													<input type="text" style="width:100%;" name="vendor_floor" value="" class="form-control new-floor" placeholder="Piso"/>
												</div>
												<div class="col-xs-4 pad_r_0">
													<label for="zip">Depto.</label>
													<input type="text" style="width:100%;" name="vendor_apartment" value="" class="form-control new-apt" placeholder="Departamento"/>
												</div>
												<div class="col-xs-4">
													<label for="zip"><?php echo $zipcode_labl; ?></label>
													<input type="text" name="postcode" value="" class="form-control new-postcode" placeholder="Código postal"/>
													<div class="text-danger span-postalcode-valid txtcolor">El código postal debe tener cuatro
														dígitos
													</div>
												</div>
											</div>
											<div class="row">
												<div class="form-group col-sm-3 mar_req_height_80" style="display: none;">
													<label for="country">Pais</label>
													<div class="clearfix"></div>
													<select style="width:100%;" name="country_id" id="input-country" class="form-control">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach($countries as $country){ ?><?php if($country['country_id'] == $country_id){ ?>
															<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
														<?php } else{ ?>
															<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
														<?php } ?><?php } ?>
													</select>
													<?php if($error_userdet_country){ ?>
														<div class="text-danger span-country-valid"><?php echo $error_userdet_country; ?></div>
													<?php } ?>
												</div>
												<div class="form-group col-sm-6 mar_req_height_80">
													<label for="country"><?php echo $province_labl; ?></label>
													<div class="clearfix"></div>
													<select style="width:100%;" name="provience_id" id="provience_id" class="form-control">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach($provience as $country){ ?><?php if($country['id'] == $country_id){ ?>
															<option value="<?php echo $country['id']; ?>" selected="selected"><?php echo $country['provincia']; ?></option>
														<?php } else{ ?>
															<option value="<?php echo $country['id']; ?>"><?php echo $country['provincia']; ?></option>
														<?php } ?><?php } ?>
													</select>
													<?php if($error_userdet_country){ ?>
														<div class="text-danger span-province-valid txtcolor">Seleccioná una
															provincia
														</div>
													<?php } ?>
												</div>
												<div class="form-group col-sm-6 mar_req_height_80 pl0">
													<label for="city"><?php echo $city_labl; ?></label>
													<div class="clearfix"></div>
													<select style="width:100%;" name="city" id="input-city" class="form-control"></select>
													<?php if($error_userdet_city){ ?>
														<div class="text-danger span-city-valid"><?php echo $error_userdet_city; ?></div>
													<?php } ?>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12" style="text-align: center;">
													<a href="javascript:void(0);" class="save-new-address btn continu pull-left" style="margin-top: 34px; margin-left: 4px;">
														Usar esta Dirección
													</a>
													<a href="javascript:void(0);" class="cancel-new-address pull-left" style="margin-top: 34px; margin-left: 4px;">
														Cancelar
													</a>
												</div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<br>
									<div class="col-sm-6 p0">
										<div style="border:0;" class="createlst-tittle">Entrega</div>
										<span class="span-shipping-select" style="color:red; font-size:10px; margin-left: 34px;">Por favor seleccioná un método de envio</span>
										<div class="form-group main-check col-sm-12 " style="line-height:0;">
											<input type="checkbox" name="new_buyer_shipping" id="buyer-pickup" class="new-buyer-shipping " value="buyer can pickup the item">
											<label class="important-text" for="buyer-pickup">Ofrecer retirar en
												persona</label>
											<div class="own-ship-default-hide">
												<input type="checkbox" name="new_vendor_shipping" id="own-ship" class="own-ship-select new-vendor-shipping" value="i provide my own shipping">
												<label class="important-text" for="own-ship">Se ofrece envío</label>
												<span style="display: block;padding-left:15px;">
                                                <input class="input-zone-delivery" type="text" name="vendor_zone_delivery" placeholder="Describí el metodo de entrega" style="width: 70%;margin-top: 5px;margin-bottom: 5px;height: 28px;"/></span>
												<span class="span-zone-delivery" style="color:red; font-size:10px;">Es obligatorio!</span>
											</div>
											<input type="checkbox" name="new_xenvios_shipping" id="use_porcan" class="new-xenvios-shipping" value="user porcantidad shipping">
											<label class="important-text" for="use-porcan">Utilizar Xenvios</label>
											<div class="form-group col-sm-12 shipping-attr">
												<div class="col-sm-10 pull-right">
													<span class="span-shipping-required">Below attributes is required!</span>
													<input type="checkbox" name="" id="free-ship" class="porcantidad-free-ship" value="porcantidad free shipping">
													<label class="important-text" for="free-ship" style="margin-bottom:10px;">Gratis (yo pagaré el envio)</label>
													<div class="clearfix"></div>
													<div class="form-inline">
														<label class="important-text" style="width:17%;">Ancho</label>
														<input type="text" style="width:70px;" placeholder="16" name="" class="form-control input-shipping-width"/>
														<select style="width:20%;" class="form-control option-shipping-width">
															<option value="centimeters">Centímetros</option>
															<option value="meters">Metros</option>
														</select>
													</div>
													<div class="form-inline">
														<label class="important-text" style="width:17%;">Alto</label>
														<input type="text" style="width:70px;" placeholder="16" name="" class="form-control input-shipping-width"/>
														<select style="width:20%;" class="form-control option-shipping-width">
															<option value="centimeters">Centímetros</option>
															<option value="meters">Metros</option>
														</select>
													</div>
													<div class="form-inline">
														<label class="important-text" style="width:17%;">Profundidad</label>
														<input type="text" style="width:70px;" placeholder="16" name="" class="form-control input-shipping-depth"/>
														<select style="width:20%;" class="form-control option-shipping-depth">
															<option value="centimeters">Centímetros</option>
															<option value="meters">Metros</option>
														</select>
													</div>
													<div class="form-inline">
														<label class="important-text" style="width:17%;">Peso</label>
														<input type="text" style="width:70px;" placeholder="16" name="" class="form-control input-shipping-weight"/>
														<select style="width:20%;" class="form-control option-shipping-weight">
															<option value="grams">Gramos</option>
															<option value="kilos">Kilos</option>
														</select>
													</div>
												</div>
												<br>
											</div>
											<div class="clr"></div>
											<br>
											<!---own ship hide close-->
											<div class="clr"></div>
											<br>
										</div>
									</div>
									<div class="clr"></div>
									<div style="border:0;" class="createlst-tittle">Garantía</div>
									<div class="col-sm-12 ">
										<span class="span-product-warranty" style="color:red; font-size:10px;">Por favor, seleccioná alguna garantía.</span>
										<input type="radio" name="warranty" id="my-warranty" value="I provide warranty">
										<label class="important-text" for="my-warranty">Garantía propia</label>
										<br>
										<input type="radio" name="warranty" id="maker-warranty" value="Maker provides warranty">
										<label class="important-text" for="maker-warranty">Garantía del fabricante</label>
										<br>
										<input type="radio" name="warranty" id="no-warranty" value="No warranty available">
										<label class="important-text" for="no-warranty">Sin garantía</label>
									</div>
								</form>
								<br></br>
								<br>
								<a href="javascript:void(0);" class="btn btn-primary submit-quantity-price">Continuar</a>
							</div>
							<div id="settings" class="tab-pane fade" role="tabpanel">
								<div style="border:0;" class="main-heading">Seleccioná el tipo de venta</div>
								<span class="col-sm-10 span-listing-type" style="color:red;font-size:10px;">Por favor, seleccioná un tipo de venta.</span>
								<div class="col-sm-4">
									<div class="gratis listing-type" id="1">
										<h4>Publicación Gratis</h4>
										<p>Duración de la campaña: <strong class="big_green">60 dias</strong></p>
										<p>Costo por publicar: <strong class="big_green sc">$0 <sup>00</sup></strong></p>
										<p>Comisión por venta: <strong class="big_green sc">5%</strong><br><span class="k_pr">del total de la venta</span>
										</p>
										<ul>
											<li>Tus productos serán ordenados de acuerdo a tus ventas y tu reputación</li>
											<li>No Aparecerás en la página de inicio</li>
										</ul>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="destacade listing-type" id="2">
										<h4>Publicacion Destacada</h4>
										<p>Duración de la campaña: <strong class="big_orange">llimitada</strong></p>
										<p>Costo por publicar: <strong class="big_orange sc">$0 <sup>00</sup></strong></p>
										<p>Comisión por venta: <strong class="big_orange sc">6%</strong><br><span class="k_pr">del total de la venta</span>
										</p>
										<ul>
											<li>Tus productos apareceran cerca de la cima de la búsqueda</li>
											<li>Aparecerás en el listado como Artículos Recomendados</li>
											<li>Compartirás espacio en la pagina de inicio</li>
										</ul>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="liquidacion listing-type" id="3">
										<h4>Liquidación</h4>
										<p>Duración de la campaña: <strong class="big_blue">llimitada</strong></p>
										<p>Costo por publicar: <strong class="big_blue sc">$0 <sup>00</sup></strong></p>
										<p>Comisión por venta: <strong class="big_blue sc">7.5%</strong><br><span class="k_pr">del total de la venta</span>
										</p>
										<ul>
											<li>Compartirás espacio en la página de inicio y en lo más alto de la
												categorías
											</li>
											<li>Tus productos aparecerán en las primeras 2 filas tituladas "Liquidación"
											</li>
											<li>Aparecerás en el listado de Liquidaciones</li>
										</ul>
									</div>
								</div>
								<a class="btn btn-primary review-product-submit" href="javascript:void(0);">Publicar</a>
							</div>
						</div>
					</div>
				</div>
				<div class="hidden-xs hidden-sm col-md-2 col-lg-2">&nbsp;</div>
			</div>
		</div>
	</div>
	<div id="category_names" style="display: none;"></div>
	<div class="modal fade" id="login_panal_modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body" style="padding-top: 0px;">
					<div class="col-sm-8 error-login"></div>
					<div class="col-sm-8 p0" id="quick-login">
						<div class="main-heading col-sm-8">Ingresá</div>
						<div class="clr"></div>
						<div class="form-group required">
							<input type="text" name="email" value="" placeholder="E-Mail" id="input-email" class="form-control btn-inp-rad"/>
						</div>
						<div class="form-group required">
							<input type="password" name="password" value="" id="input-password" placeholder="Contraseña" class="form-control pass btn-inp-rad"/>
						</div>
						<div class="form-group">
							<button type="button" class="continu loginaccount col-sm-12 btn-reg-rad" data-loading-text="<?php echo $text_loading; ?>">
								Ingresar
							</button>
							<span class="pull-left" style="color:black;"><input type="checkbox"/> No cerrar sesión</span>
							<a href="index.php?route=account/forgotten" class="pull-right" style="color:#312783;">
								Olvide mi contraseña
							</a>
						</div>
						<div class="clr"></div>
						<div style="border-bottom:1px solid #e5e5e5; height:20px;"></div>
						<br/>
						<div class="body" style="color:black;"> No estás registrado?
							<a href="<?php echo $base; ?>index.php?route=account/register" style="color:#312783;">Registrate aqui.
								here.
							</a>
						</div>
						<div class="clr" style="height:20px;"></div>
						<a href="<?php //echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
					</div>
					-->
				</div>
			</div>
		</div>
	</div></div>  <!--Login Modal start-->
	<div id='login_model' class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin:10px">
					<span aria-hidden="true">&times;</span>
				</button>
				<div class="modal-body ">
					<div class="col-sm-8  midbox error-login"></div>
					<div class="col-sm-8 midbox p0" id="quick-login" style="margin-top:-100px!important;padding-top:0px">
						<div class="main-heading col-sm-12 midbox">Ingresar</div>
						<div class="clr"></div>
						<div class="form-group required">
							<input type="text" name="email" value="" placeholder="E-Mail" id="input-email" class="form-control btn-inp-rad"/>
						</div>
						<div class="form-group required">
							<input type="password" name="password" value="" id="input-password" placeholder="Password" class="form-control pass btn-inp-rad"/>
						</div>
						<div class="form-group">
							<button type="button" class="continu loginaccount col-sm-12 btn-reg-rad" data-loading-text="Loading...">
								Ingresar
							</button>
							<span class="pull-left" style="font-size: 12px;"><input type="checkbox"/> No cerrar sesión</span>
							<a href="index.php?route=account/forgotten" class="pull-right" style="font-size: 12px;">
								Olvidé mi contraseña
							</a>
						</div>
						<div class="clr"></div>
						<div style="border-bottom:1px solid #e5e5e5; height:20px;"></div>
						<br/>
						<div class="" style="font-size: 12px;"> No estás registrado?
							<a href="<?php echo $base; ?>index.php?route=account/register" style="font-size: 12px;">Registrate aquí.
							</a>
						</div>
						<div class="clr" style="height:20px;"></div>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->si
	</div><!-- /.modal -->  <!--Login modal end-->
	<script id="attribute-template" type="x-tmpl-mustache">
	{{#.}}
	<select class="attribute-group">
		{{#attributes}}
			<option value="{{ attribute_id }}" >{{ attribute_value }}</option>
		{{/attributes}}
		</select>
	{{/.}}
	
	</script>
	
	<script>
		$('select#input-country').find('option:first').remove();
		
		var check_current_customer_login = $('.current_customer_id').val();
		var leafCategorySelected = false;
		if(check_current_customer_login == '' && check_current_customer_login == 0){
			$('#login_model').modal('show');
			check_current_customer_login_flag = 0;
		}
		else{
			check_current_customer_login_flag = 1;
		}
		
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
		
		var new_address_value_dropdown = $('.new-shipping-addr-dropdown').val();
		
		$('.new-shipping-addr-dropdown').on('change', function(){
			new_address_value_dropdown = $(this).val();
		});
		
		
		var validate_address = 0;
		var check_add_val = '';
		
		check_add_val = $('.checck-address-avail').val();
		
		if(check_add_val != ''){
			validate_address = 1;
			
			$('.cancel-new-address').show();
			$('.new-address-required').hide();
			$('#new_address').hide();
			
		}
		else{
			$('.cancel-new-address').hide();
			$('.new-address-required').show();
			$('.new-address-link').hide();
			$('#new_address').show();
			$('.save-new-address').hide();
		}
		
		
		var new_address_flag = 0;
		
		
		$('.new-address-link').click(function(){
			new_address_flag = 1;
			$('#new_address').show();
			$('.new-shipping-addr-dropdown').hide();
			$('.new-address-link').hide();
			$('.save-new-address').hide();
			
			
		});
		
		
		$('.cancel-new-address').click(function(){
			new_address_flag = 0;
			$('.new-shipping-addr-dropdown').show();
			$('.new-address-link').show();
			$('#new_address').hide();
		});
		
		
		var get_cat_id = '';
		
		var product_title, product_short_description, product_tags, product_condition, get_editor_html = '';
		var product_sku = '';
		
		var desc = 0;
		var quant = 0;
		var review = 0;
		var db_flag = 0;
		
		var flag_product_id = 0;
		
		var product_condition_radio = '';
		$('.span-product-condition').hide();
		
		$('.product-condition').on('change', function(){
			product_condition_radio = $('input[name="product_condition"]:checked').val();
			
		});
		
		
		$(".minimum-buy").val("1");
		$(".avail-stock").val("2");
		
		$('#new_item').click();
		$('#no-warranty').click();
		$('#cash_check').trigger('click');
		$('.cash-discount').val('10');
		
		
		$(document).ready(function(){
			$.ajax({
				url: 'index.php?route=createlisting/category/check_login',
				type: 'post',
				success: function(data){
					if(data === 'not_logged_in'){
					}
				}
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
						complete: function(){
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
								$('#modal-quicksignup').modal('hide');
							}
						}
					});
			}
			$('#sub_cat_1,.second-category-select').hide();
			$('#sub_cat_2,.third-category-select').hide();
			$('#sub_cat_3,.forth-category-select').hide();
			$('#sub_cat_4,.fifth-category-select').hide();
			
			function getAttributes(catId){
				var promise = $.Deferred();
				$.ajax({
					url: 'index.php?route=Porcantidad/Firstactions/getAttributes',
					type: 'POST',
					dataType: 'json',
					data: {cat_id: catId},
					success: function(data){
						console.log(JSON.stringify(data));
						promise.resolve(data);
					}
				});
				return promise;
			}
			
			
			function fetchCategoriesFromLeafNode(){
				debugger;
				var leafNodeSelecetedCategoryId = parseInt($('select:visible').last().val());
				getAttributes(leafNodeSelecetedCategoryId).then(function(data){
					var attributeGroups = _.groupBy(data, 'attribute_group_id');
					var attributesMapped = _.map(attributeGroups, function(value, key){
						return {
							attributeGroup: key,
							attributes: value
						}
					});
					var template = $('#attribute-template').html();
					var rendered = Mustache.render(template, attributesMapped);
					$('.list-cate-main').append(rendered);
				});
			}
			
			
			function scrollCategories(){
				var element = $('.list-cate-main');
				var maxScrollLeft = element[0].scrollWidth - element[0].clientWidth;
				element.scrollLeft(maxScrollLeft);
			}
			
			$('.main-cat option').click(function(){
				
				$('.main-cat,.first-category-select').show();
				$('#sub-cat-1').hide();
				$('#sub_cat_2,.third-category-select').hide();
				$('#sub_cat_3,.forth-category-select').hide();
				$('#sub_cat_4,.fifth-category-select').hide();
				$('.second-category-select').hide();
				$('.first-category-select').text(this.innerHTML.replace('&nbsp;', ''));
				$('#category_names').html(this.value);
				$.ajax({
					url: 'index.php?route=createlisting/category/check_category',
					type: 'post',
					data: {"id": this.value},
					dataType: 'text',
					success: function(response){
						
						if(response != ''){
							$('#sub_cat_1').show();
							$('.sub-cat-1').html(response);
							$('.sub-cat-1 option').click(function(){
								$('.main-cat,.first-category-select').show();
								$('#sub_cat_1,.second-category-select').show();
								$('#sub_cat_2').hide();
								$('#sub_cat_3,.forth-category-select').hide();
								$('#sub_cat_4,.fifth-category-select').hide();
								$('.third-category-select').hide();
								$('.second-category-select').text(" > " + this.innerHTML.replace('&nbsp;', ''));
								$('#category_names').html(this.value);
								$.ajax({
									url: 'index.php?route=createlisting/category/check_second_sub_category',
									type: 'post',
									data: {"id": this.value},
									dataType: 'text',
									success: function(response){
										if(response != ''){
											$('#sub_cat_2').show();
											$('.sub-cat-2').html(response);
											$('.sub-cat-2  option').click(function(){
												$('.main-cat,.first-category-select').show();
												$('#sub_cat_1,.second-category-select').show();
												$('#sub_cat_2,.third-category-select').show();
												$('#sub_cat_3').hide();
												$('#sub_cat_4,.fifth-category-select').hide();
												$('.forth-category-select').hide();
												$('.third-category-select').text(" > " + this.innerHTML.replace('&nbsp;', ''));
												$('#category_names').html(this.value);
												$.ajax({
													url: 'index.php?route=createlisting/category/check_third_sub_category',
													type: 'post',
													data: {"id": this.value},
													dataType: 'text',
													success: function(response){
														if(response != ''){
															$('#sub_cat_3').show();
															$('.sub-cat-3').html(response);
															scrollCategories();
															$('.sub-cat-3  option').click(function(){
																
																
																$('.main-cat,.first-category-select').show();
																$('#sub_cat_1,.second-category-select').show();
																$('#sub_cat_2,.third-category-select').show();
																$('#sub_cat_3,.forth-category-select').show();
																$('#sub_cat_4').hide();
																$('.fifth-category-select').hide();
																$('.forth-category-select').text(" > " + this.innerHTML.replace('&nbsp;', ''));
																$('.forth-category-select').css('color', '#332690');
																$('#category_names').html(this.value);
																$.ajax({
																	url: 'index.php?route=createlisting/category/check_forth_sub_category',
																	type: 'post',
																	data: {"id": this.value},
																	dataType: 'text',
																	success: function(response){
																		if(response != ''){
																			$('#sub_cat_4').show();
																			$('.sub-cat-4').html(response);
																			scrollCategories();
																			$('.sub-cat-4  option').click(function(){
																				$('.fifth-category-select').show();
																				$('.fifth-category-select').text(" > " + this.innerHTML.replace('&nbsp;', ''));
																				$('#category_names').html(this.value);
																				fetchCategoriesFromLeafNode();
																				$('.forth-category-select').css('color', '#332690');
																				$('.fifth-category-select').css('color', '#e86d00');
																			leafCategorySelected = true;
																			});
																	}
																		else{
																			fetchCategoriesFromLeafNode();
																			$('.forth-category-select').css('color', '#e86d00');
																			leafCategorySelected = true;
																		}
																	}
															});
															});
															
															
														}
														else{
															fetchCategoriesFromLeafNode();
															leafCategorySelected = true;
															$('.third-category-select').css('color', '#e86d00');
													}
													}
											});
											});
											
										}
										else{
											fetchCategoriesFromLeafNode();
											$('.second-category-select').css('color', '#e86d00');
											leafCategorySelected = true;
									}
									}
							});
							});
						}
						else{
							fetchCategoriesFromLeafNode();
							leafCategorySelected = true;
							$('.first-category-select').css('color', '#e86d00');
							$('#continuebox').show();
					}
				}
			});
				
			});
			
			
			$(".disable-desc").on("click", function(e){
				if(desc == 0){
					return false;
				}
			});
			
			$(".disable-quantity-price").on("click", function(e){
				if(quant == 0){
					return false;
				}
			});
			
			
			$(".disable-review-listing").on("click", function(e){
				if(review == 0){
					return false;
				}
			});
			
			function first_tabs_check(){
				get_cat_id = $('#category_names').text();
				if(!leafCategorySelected){
					$('.select-catgegory-error').show();
					return false;
				}
				
				if(get_cat_id != ''){
					desc = 1;
					myparent = $('.disable-desc').attr("aria-expanded", "true").parent();
					myparent.addClass("active");
					myparent.removeClass("tab-nolink");
					$('.disable-cat').attr("aria-expanded", "false").parent().removeClass("active");
					$('#home').removeClass('active in');
					$('#profile').addClass('active in');
					$('#step_two').parent().addClass('step-active');
					$("html, body").animate({scrollTop: 0}, "fast");
					
					return true;
				}
			}
			
			$('.choose-cat-continue').click(
				function(){
					$('.select-catgegory-error').hide();
					if(check_current_customer_login_flag == 0){
						$('#login_model').modal('show');
				}
					
					if(first_tabs_check()){
						$('.product-title').focus();
				}
				});
			
			
			var maxLength = 64;
			
			$('.product-title').keyup(function(){
				var length = $(this).val().length;
				var length = maxLength - length;
				$('#prod_chars').text(length);
			});
			
			$('.product-short-description').keyup(function(){
				var length1 = $(this).val().length;
				var length1 = maxLength - length1;
				$('#desc_chars').text(length1);
			});
			
			$('.span-product-sku').hide();
			
			$(".products-sku").focusout(function(){
				product_sku = '';
				var sku_value = $(this).val();
				
				if(sku_value != ''){
					$.ajax({
						url: 'index.php?route=createlisting/category/product_sku',
						type: 'post',
						data: {"product_sku": sku_value},
						success: function(sku){
							if(sku == '1'){
								$('.products-sku').val('');
								$('.span-product-sku').show();
							}
							else{
								product_sku = sku_value;
								$('.span-product-sku').hide();
							}
					}
				});
				}
			});
			
			
			$('.desc-require').hide();
			function second_tabs_check(){
				
				var form_error = false;
				
				product_title = $('.product-title').val();
				product_tags = $('.products-tag').val();
				product_condition = product_condition_radio;//$('.product-condition').val();
				
				
				if(product_title == ''){
					$('.error-product-title').show();
					$('.product-title').focus();
					form_error = true;
				}
				else{
					$('.error-product-title').hide();
				}
				
				if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)){
					
				}
				else{
					
				}
				
				
				get_editor_html = CKEDITOR.instances['editor'].getData();
				if(!form_error && get_editor_html == ''){
					$('.desc-require').show();
					CKEDITOR.instances['editor'].focus();
					return false;
				}
				else{
					$('.desc-require').hide();
				}
				
				if(product_title != '' && get_editor_html != '' && product_condition_radio != ''){
					quant = 1;
					
					myparent1 = $('.disable-quantity-price').attr("aria-expanded", "true").parent();
					myparent1.addClass("active");
					myparent1.removeClass("tab-nolink");
					$('.disable-desc').attr("aria-expanded", "false").parent().removeClass("active");
					$('#profile').removeClass('active in');
					$('#messages').addClass('active in');
					$('#step_three').parent().addClass('step-active');
					$("html, body").animate({scrollTop: 0}, "fast");
					$('.tier-prices tr:nth-child(2) .price input').focus();
					return true;
				}
				else{
					if(product_title == '' || get_editor_html == '' || product_condition_radio == ''){
						
						
						myparent1 = $('.disable-desc').attr("aria-expanded", "true").parent();
					myparent1.addClass("active");
						$('.disable-cat').attr("aria-expanded", "false").parent().removeClass("active");
						$('.disable-quantity-price').attr("aria-expanded", "false").parent().removeClass("active");
						$('.disable-review-listing').attr("aria-expanded", "false").parent().removeClass("active");
						
						$('#profile').addClass('active in');
						$('#home').removeClass('active in');
						$('#messages').removeClass('active in');
						$('#settings').removeClass('active in');
						
						return 'uncomplete';
				}
			}
				
				
			}
			
			$('.desc-continue').click(function(){
				second_tabs_check();
			});
			
			
		})
		;
		
		
		var main_product_image = '';
		var store_product_image = [];
		var imageIndex = 0;
		$('.photoBox').hide();
		
		
		function callAjax(target, type, form_data){
			var promise = $.Deferred();
			$.ajax({
				url: target,
				type: type,
				data: form_data,
				contentType: false,
				processData: false,
				success: function(data){
					if(data.indexOf('Warning') < 0){
						promise.resolve(data);
					}
					else{
						promise.reject(data);
					}
				}
			});
			return promise;
		}
		
		function SaveImage(index, image){
			var urlTarget = "index.php?route=createlisting/category/upload_product_img";
			if(index == 0){
				urlTarget = 'index.php?route=createlisting/category/upload_product_main_img';
			}
			var form_data = new FormData();
			form_data.append("file", image);
			
			callAjax(urlTarget, 'post', form_data).then(function(data){
				if(index == 0){
					main_product_image = data;
				}
				else{
					store_product_image[index] = data;
				}
				var image = $('.photobox-wrapper .photoBox:nth-child(' + (index + 1) + ') img');
				image.load(function(){
					$(this).parent().parent().show();
				});
				image.attr('src', '<?php echo $base?>image/' + data);
			});
		}
		
		$('#product_main_image, .product-img-upload').change(function(){
			
			var files = $(this).prop("files");
			var index = $('#product_main_image, .product-img-upload').index(this);
			var endIndex = index + files.length;
			for(var i = index; i < endIndex; i++){
				SaveImage(i, files[i - index]);
				if(imageIndex == 5){
					$('.add-image').hide();
					break;
				}
				if(i == imageIndex){
					imageIndex++;
				}
			}
		});
		
		$('.add-image').click(function(){
			$('.photobox-wrapper .photoBox:nth-child(' + (imageIndex + 1) + ') input').click();
		});
		
		$('.btn-delete').hide().click(function(){
			var index = $('.btn-delete').index(this);
			if(index == 0){
				main_product_image = null;
			}
			else{
				store_product_image[index] = null;
			}
			var image = $('.photobox-wrapper .photoBox:nth-child(' + (index + 1) + ') img');
			image.attr('src', '<?php echo $base; ?>image/no-image.png');
		});
		
		
		/* Third tab script start   price-quantity*/
		function isNumber(evt){
			
			var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
			if(iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
				return false;
			}
			return true;
		}
		
		
		$('.span-avail-stock').hide();
		$('.span-price-one').hide();
		$('.span-price-two').hide();
		$('.span-price-three').hide();
		$('.span-price-four').hide();
		$('.span-price-five').hide();
		
		$('.span-qty-two').hide();
		$('.span-minimum-buy').hide();
		$('.span-product-warranty').hide();
		
		$('.span-payment-method').hide();
		
		
		$('.span-shipping-select').hide();
		
		$('.span-zone-delivery').hide();
		
		
		var paymeny_method_flag = 0;
		
		var require_shipping = '';
		var use_porcantidad_or_own_shipping = '';
		var buyer_pay_or_free_shipping = '';
		
		var check_shipping_value = '';
		var check_shipping_vendor_value = 0;
		var check_shipping_porcantidad_value = 0;
		
		var new_vendor_shipping = '';
		var zone_delivery = '';
		
		var new_buyer_shipping = '';
		
		var new_xenvios_shipping = '';
		
		
		var porcantidad_pay_shipping_checkbox = '';
		
		var input_shipping_width = '';
		var option_shipping_width = '';
		
		var input_shipping_height = '';
		var option_shipping_height = '';
		
		var input_shipping_depth = '';
		var option_shipping_depth = '';
		
		var input_shipping_weight = '';
		var option_shipping_weight = '';
		
		
		var product_warranty = 'No warranty available';
		
		
		$('.shipping-attr').hide();
		
		$('.span-shipping-required').hide();
		
		var avail_stock = '';
		var price_one = '';
		
		var qty_two = '';
		var price_two = '';
		
		var qty_three = '';
		var price_three = '';
		
		var qty_four = '';
		var price_four = '';
		
		var qty_five = '';
		var price_five = '';
		var minimum_buy = '';
		
		
		var cash_checkbox = 'Cash';
		var wire_checkbox = '';
		var credit_checkbox = '';
		
		var cash_checkbox_value = 'Cash';
		var wire_checkbox_value = '';
		var credit_checkbox_value = '';
		
		
		var cash_discount = '10';
		var wire_discount = '';
		var credit_card_discount = '';
		
		$('.span-cash-and-discount').hide();
		$('.span-wire-and-discount').hide();
		$('.span-credit-and-discount').hide();
		
		
		$('#cash_check').change(function(){
			if(this.checked){
				cash_checkbox = this.value;
			}
			else{
				cash_checkbox = '';
			}
		});
		$('#wire_check').change(function(){
			if(this.checked){
				wire_checkbox = this.value;
			}
			else{
				wire_checkbox = '';
			}
		});
		
		$('#credit_check').change(function(){
			if(this.checked){
				credit_checkbox = this.value;
			}
			else{
				credit_checkbox = '';
			}
		});
		
		
		$('.porcantidad-free-ship').on('change', function(){
			
			porcantidad_pay_shipping_checkbox = this.checked ? this.value : '';
		});
		
		$('.new-vendor-shipping').on('change', function(){
			
			new_vendor_shipping = this.checked ? this.value : '';
			if(new_vendor_shipping === 'i provide my own shipping'){
				check_shipping_vendor_value = 1;
			}
			else{
				check_shipping_vendor_value = 0;
			}
			
			
		});
		
		$('.new-buyer-shipping').on('change', function(){
			
			new_buyer_shipping = this.checked ? this.value : '';
		});
		
		$('.new-xenvios-shipping').on('change', function(){
			
			new_xenvios_shipping = this.checked ? this.value : '';
			if(new_xenvios_shipping === 'user porcantidad shipping'){
				check_shipping_porcantidad_value = 1;
				$('.shipping-attr').show();
			}
			else{
				check_shipping_porcantidad_value = 0;
				$('.shipping-attr').hide();
			}
			
			
		});
		
		function third_tabs_check(){
			
			var required_field = false;
			
			avail_stock = $('.avail-stock').val();
			
			
			minimum_buy = $('.minimum-buy').val();
			
			
			if(!validate(true)){
				return;
			}
			
			var lastQuantity = parseInt($('.tier-prices tr .quantity input').last().val());
			var availStockInt = parseInt(avail_stock);
			
			if(avail_stock == '' || availStockInt < lastQuantity){
				$('.span-avail-stock').show();
				$('.avail-stock').focus();
				required_field = true;
				return;
			}
			else{
				$('.span-avail-stock').hide();
			}
			
			var inputs = $('.tier-prices tr input');
			var inputNumbers = ['first', 'second', 'third', 'forth', 'fifth'];
			var valuesToAdd = [];
			for(var i = 0; i < inputs.length; i = i + 2){
				var nodeNumber = (i / 2);
				var quantityToAdd = {id: inputNumbers[nodeNumber] + '_quantity', value: inputs.get(i).value};
				valuesToAdd.push(quantityToAdd);
				var priceToAdd = {id: inputNumbers[nodeNumber] + '_price', value: inputs.get(i + 1).value};
				valuesToAdd.push(priceToAdd);
			}
			
			
			price_one = valuesToAdd[1].value;

			qty_two = valuesToAdd[2].value;
			price_two = valuesToAdd[3].value;
			
			qty_three = valuesToAdd[4].value;
			price_three = valuesToAdd[5].value;
			
			qty_four = valuesToAdd[6].value;
			price_four = valuesToAdd[7].value;
			
			qty_five = valuesToAdd[8].value;
			price_five = valuesToAdd[9].value;
			
			
			if(minimum_buy == ''){
				$('.span-minimum-buy').show();
				required_field = true;
			}
			else{
				$('.span-minimum-buy').hide();
			}
			
			if(product_warranty == ''){
				$('.span-product-warranty').show();
				required_field = true;
			}
			else{
				$('.span-product-warranty').hide();
			}
			
			
			if(cash_checkbox == '' && wire_checkbox == '' && credit_checkbox == ''){
				$('.span-payment-method').show();
				paymeny_method_flag = 1;
			}
			else{
				paymeny_method_flag = 0;
				$('.span-payment-method').hide();
				
				cash_checkbox_value = cash_checkbox;
				wire_checkbox_value = wire_checkbox;
				credit_checkbox_value = credit_checkbox;
			}
			
			
			cash_discount = $('.cash-discount').val();
			wire_discount = $('.wire-discount').val();
			credit_card_discount = $('.credit-card-discount').val();
			
			if(cash_discount != '' && cash_checkbox_value == ''){
				$('.span-cash-and-discount').show();
			}
			else{
				$('.span-cash-and-discount').hide();
			}
			if(wire_discount != '' && wire_checkbox_value == ''){
				$('.span-wire-and-discount').show();
			}
			else{
				$('.span-wire-and-discount').hide();
			}
			
			if(credit_card_discount != '' && credit_checkbox_value == ''){
				$('.span-credit-and-discount').show();
			}
			else{
				$('.span-credit-and-discount').hide();
			}
			
			var price_quantity = [];
			$('.price-quantity').each(function(index){
				if($(this).val()){
					price_quantity[index] = $(this).val();
				}
			});
			
			if(new_vendor_shipping == '' && new_buyer_shipping == '' && new_xenvios_shipping == ''){
				$('.span-shipping-select').show();
				return false;
			}
			else{
				$('.span-shipping-select').hide();
			}
			
			
			zone_delivery = $('.input-zone-delivery').val();
			if(check_shipping_vendor_value == 1 && zone_delivery == ''){
				$('.span-zone-delivery').show();
				return false;
			}
			else{
				$('.span-zone-delivery').hide();
			}
			
			
			input_shipping_width = $('.input-shipping-width').val();
			option_shipping_width = $('.option-shipping-width').val();
			input_shipping_height = $('.input-shipping-height').val();
			option_shipping_height = $('.option-shipping-width').val();
			input_shipping_depth = $('.input-shipping-depth').val();
			option_shipping_depth = $('.option-shipping-depth').val();
			input_shipping_weight = $('.input-shipping-weight').val();
			option_shipping_weight = $('.option-shipping-weight').val();
			
			
			if(check_shipping_porcantidad_value == 1){
				
				if(input_shipping_width == '' || option_shipping_width == '' || input_shipping_height == '' || option_shipping_height == '' || input_shipping_depth == '' || option_shipping_depth == '' || input_shipping_weight == '' || option_shipping_weight == ''){
					$('.span-shipping-required').show();
					return false;
				}
				else{
					$('.span-shipping-required').hide();
				}
				
			}
			
			if(validate_address === 0 || new_address_flag === 1){
				validate_new_address();
				return 'uncomplete';
				
			}
			
			if(avail_stock != '' && price_one != '' && qty_two != '' && price_two != '' && minimum_buy != '' && paymeny_method_flag != 1){
				if((cash_discount != '' && cash_checkbox_value == '') || (wire_discount != '' && wire_checkbox_value == '') || (credit_card_discount != '' && credit_checkbox_value == '')){
					myparent4444 = $('.disable-quantity-price').attr("aria-expanded", "true").parent();
					myparent4444.addClass("active");
					myparent4444.removeClass("tab-nolink");
					$('.disable-cat').attr("aria-expanded", "false").parent().removeClass("active");
					$('.disable-desc').attr("aria-expanded", "false").parent().removeClass("active");
					$('.disable-review-listing').attr("aria-expanded", "false").parent().removeClass("active");
					
					$('#messages').addClass('active in');
					$('#home').removeClass('active in');
					$('#profile').removeClass('active in');
					$('#settings').removeClass('active in');
					
					return 'uncomplete';
				}
				
				
				review = 1;
				product_information();
				
				myparent2 = $('.disable-review-listing').attr("aria-expanded", "true").parent();
				myparent2.addClass("active");
				myparent2.removeClass("tab-nolink");
				$('.disable-quantity-price').attr("aria-expanded", "false").parent().removeClass("active");
				$('#messages').removeClass('active in');
				$('#settings').addClass('active in');
				
				$('#step_four').parent().addClass('step-active');
				$("html, body").animate({scrollTop: 0}, "fast");
				$('.gratis.listing-type').click();
				
				
			}
			else{
				if(avail_stock == '' || price_one == '' || qty_two == '' || price_two == '' || minimum_buy == '' || paymeny_method_flag == 1){
					
					
					myparent2 = $('.disable-quantity-price').attr("aria-expanded", "true").parent();
					myparent2.addClass("active");
					$('.disable-cat').attr("aria-expanded", "false").parent().removeClass("active");
					$('.disable-desc').attr("aria-expanded", "false").parent().removeClass("active");
					$('.disable-review-listing').attr("aria-expanded", "false").parent().removeClass("active");
					
					$('#messages').addClass('active in');
					$('#home').removeClass('active in');
					$('#profile').removeClass('active in');
					$('#settings').removeClass('active in');
					
					return 'uncomplete';
				}
			}
			
		}
		
		
		var new_addredss_add = '';
		var new_province_add = '';
		var new_numb_add = '';
		var new_country_add = '';
		var new_city_add = '';
		var new_floor_add = '';
		var new_apt_add = '';
		var new_postcode_add = '';
		
		
		$('#provience_id').change(function(){
			new_province_add = $(this).val();
		});
		
		
		$('.span-address-valid').hide();
		$('.span-province-valid').hide();
		$('.span-numb-valid').hide();
		$('.span-country-valid').hide();
		$('.span-city-valid').hide();
		$('.span-postalcode-valid').hide();
		
		
		$('select#input-country').find('option[value="10"]').prop('selected', true);
		
		function validate_new_address(call_validate){
			
			if(validate_address != 1 || new_address_flag === 1){
				
				var new_addre_required_field = false;
				
				new_addredss_add = $('#input-address-1').val();
				new_numb_add = $('.new-door-numb').val();
				new_country_add = $('#input-country').val();
				new_city_add = $('#input-city').val();
				new_floor_add = $('.new-floor').val();
				new_apt_add = $('.new-apt').val();
				new_postcode_add = $('.new-postcode').val();
				if(new_addredss_add == ''){
					$('.span-address-valid').show();
					$('#input-address-1').focus();
					return true;
				}
				else{
					$('.span-address-valid').hide();
				}
				
				
				if(new_numb_add == ''){
					$('.span-numb-valid').show();
					$('.new-door-numb').focus();
					return true;
				}
				else{
					$('.span-numb-valid').hide();
				}
				
				if(new_postcode_add == '' || new_postcode_add.length < 4){
					$('.span-postalcode-valid').show();
					$('.new-postcode').focus();
					return true;
				}
				else{
					$('.span-postalcode-valid').hide();
				}
				
				
				if(new_province_add == ''){
					$('.span-province-valid').show();
					$('#provience_id').focus();
					return true;
				}
				else{
					$('.span-province-valid').hide();
				}
				
				if(new_city_add == ''){
					$('.span-city-valid').show();
					$('#input-city').focus();
					return true;
				}
				else{
					$('.span-city-valid').hide();
				}
				
				
				$.ajax({
					url: 'index.php?route=createlisting/category/add_new_address',
					type: 'post',
					data: {
						"address": new_addredss_add,
						"door_number": new_numb_add,
						"floors_val": new_floor_add,
						"apt": new_apt_add,
						"postcde": new_postcode_add,
						"city": new_city_add,
						"country_id": new_country_add,
						"province": new_province_add
					},
					dataType: 'text',
					success: function(response){
						var parse_jsons = $.parseJSON(response);
						$('.new-shipping-addr-dropdown').append("<option value=" + parse_jsons.last_id + ">" + parse_jsons.comp_addr + "</option>");
						$("select.new-shipping-addr-dropdown option[value=" + parse_jsons.last_id + "]").attr("selected", "selected");
						new_address_value_dropdown = parse_jsons.last_id;
						validate_address = 1;
						new_address_flag = 0;
						$('.new-address-link').show();
						$('#new_address').hide();
						$('.new-shipping-addr-dropdown').show();
						third_tabs_check();
						
					}
				});
				return false;
			}
			
			
		}
		
		
		$('.save-new-address').click(function(){
			validate_new_address();
		});
		
		$('.submit-quantity-price').click(function(){
			third_tabs_check();
		});
		
		
		$('.quantity-price-back').click(function(){
			
			price_quantity_back = $('.disable-desc').attr("aria-expanded", "true").parent();
			price_quantity_back.addClass("active");
			$('.disable-cat').attr("aria-expanded", "false").parent().removeClass("active");
			$('.disable-quantity-price').attr("aria-expanded", "false").parent().removeClass("active");
			$('.disable-review-listing').attr("aria-expanded", "false").parent().removeClass("active");
			
			$('#profile').addClass('active in');
			$('#home').removeClass('active in');
			$('#messages').removeClass('active in');
			$('#settings').removeClass('active in');
			
			$("html, body").animate({scrollTop: 0}, "fast");
			
			
		});
		
		
		$("input:radio[name=new_shipping]").click(function(){
			require_shipping = $(this).val();
			
			if(require_shipping === 'i provide my own shipping'){
				check_shipping_vendor_value = 1;
				check_shipping_porcantidad_value = 0;
				$('.shipping-attr').hide();
			}
			else{
				if(require_shipping === 'buyer can pickup the item'){
					check_shipping_vendor_value = 0;
					check_shipping_porcantidad_value = 0;
					$('.shipping-attr').hide();
				}
				else{
					if(require_shipping === 'user porcantidad shipping'){
						check_shipping_vendor_value = 0;
						check_shipping_porcantidad_value = 1;
						$('.shipping-attr').show();
					}
				}
			}
		});
		
		$("input:radio[name=warranty]").click(function(){
			product_warranty = $(this).val();
		});
		
		function product_information(){
			
			$.ajax({
				url: 'index.php?route=createlisting/category/product_information',
				type: 'post',
				//cache: false,
				data: {
					"cat_id": get_cat_id,
					"prod_title": product_title,
					"prod_tags": product_tags,
					"product_sku": product_sku,
					"prod_condition": product_condition,
					"prod_main_img": main_product_image,
					"store_product_image": store_product_image,
					"prod_desc": get_editor_html,
					"avail_stock": avail_stock,
					"qty_one": '1',
					"price_one": price_one,
					"qty_two": qty_two,
					"price_two": price_two,
					"qty_three": qty_three,
					"price_three": price_three,
					"qty_four": qty_four,
					"price_four": price_four,
					"qty_five": qty_five,
					"price_five": price_five,
					"minimum_buy": minimum_buy,
					"cash_checkbox_value": cash_checkbox_value,
					"wire_checkbox_value": wire_checkbox_value,
					"credit_checkbox_value": credit_checkbox_value,
					"cash_discount": cash_discount,
					"wire_discount": wire_discount,
					"credit_card_discount": credit_card_discount,
					
					"new_vendor_shipping": new_vendor_shipping,
					"new_buyer_shipping": new_buyer_shipping,
					"new_xenvios_shipping": new_xenvios_shipping,
					
					"product_warranty": product_warranty,
					
					"zone_delivery": zone_delivery,
					"porcantidad_pay_shipping_checkbox": porcantidad_pay_shipping_checkbox,
					"input_shipping_width": input_shipping_width,
					"option_shipping_width": option_shipping_width,
					"input_shipping_height": input_shipping_height,
					"option_shipping_height": option_shipping_height,
					"input_shipping_depth": input_shipping_depth,
					"option_shipping_depth": option_shipping_depth,
					"input_shipping_weight": input_shipping_weight,
					"option_shipping_weight": option_shipping_weight,
					
					"location_id": new_address_value_dropdown,
					"customer_id": check_current_customer_login,
					
					"flag_product_id": flag_product_id,
					"attributes": _.map($('.attribute-group'), function(item){
						return item.value
					})
				},
				async: false,
				success: function(response){
					db_flag = 1;
					flag_product_id = response;
					iframe_url = '<?php echo $base?>index.php?route=Productdetails/productdtls&amount=$0&quantity=0&pxs=';
					$('#product_review_iframe').attr("src", iframe_url + flag_product_id);
				},
			});
		}
		
		/* Third tab script end  */
		
		/* forth tab script start  */
		
		
		var listing_type = '';
		$(".listing-type").click(function(){
			listing_type = $(this).attr("id");
			$('.listing-type').removeClass('selected-listing-type');
			$(this).addClass('selected-listing-type');
		});
		
		$('.span-listing-type').hide();
		
		$(".disable-review-listing").click(function(){
			if(db_flag == 1){
				var check_value_of_second_tabs = second_tabs_check();
				
				if(check_value_of_second_tabs == 'uncomplete'){
					
					$('.disable-review-listing').attr("aria-expanded", "false").parent().removeClass("active");
					$('#settings').removeClass('active in');
					return false;
				}
				var check_values_of_third_tab = third_tabs_check();
				if(check_values_of_third_tab == 'uncomplete'){
					return false;
				}
				else{
					if(check_value_of_second_tabs != 'uncomplete' && check_values_of_third_tab != 'uncomplete'){
						third_tabs_check();
					}
				}
			}
		});
		
		
		var warning_popup = window.location.href.match(/(localhost|desa|tst|rafa|alejo|sergio)/) ? 1 : 0;
		
		
		$(".review-product-submit").click(function(){
			
			
			if(listing_type == ''){
				$('.span-listing-type').show();
				return false;
			}
			else{
				$('.span-listing-type').hide();
				product_information();
				
				reviewparent = $('.disable-review-listing').attr("aria-expanded", "true").parent();
				reviewparent.addClass("active");
				$('.disable-quantity-price').attr("aria-expanded", "false").parent().removeClass("active");
				$('#messages').removeClass('active in');
				$('#settings').addClass('active in');
				
				$.ajax({
					url: 'index.php?route=createlisting/category/product_listing_update',
					type: 'post',
					data: {"prod_id": flag_product_id, "listing_type_id": listing_type},
					async: false,
					success: function(response){
						warning_popup = 1;
						$("html, body").animate({scrollTop: 0}, "fast");
						window.location.href = "<?php echo $base;?>index.php?route=Productdetails/productdtls&zamr=$" + price_one + "&xqtn=1&pxs=" + flag_product_id;
					},
				});
			}
		});
		
		/* forth tab script end  */
		
		$('[data-toggle="tooltip"]').tooltip();
		
		
		window.onbeforeunload = return_not_saved;
		
		function return_not_saved(){
			if(warning_popup == 0){
				return "unsaved changes";
			}
		}
		
		
		$(document).ready(function(){
			CKEDITOR.config.removePlugins = 'image';
		});
	</script>
	<script src="catalog/view/javascript/assets/ckeditor/ckeditor.js"></script>
	<script src="catalog/view/javascript/assets/ckeditor/sample.js"></script>
	<link href="catalog/view/javascript/assets/ckeditor/samples.css" rel="stylesheet" media="screen"/>
	<script>
		initSample();
	</script>
	<script>
		var check_img = '';
		var check_img1 = '';
		$(".addphotos-wrap > input").mouseover(function(){
			
			check_img = $(this).prevAll('img').first().attr("src");
			no_img = '<?php echo $base; ?>image/no-image.png';
			if(check_img == no_img){
				check_img = $(this).prevAll('img').first().attr("src", "<?php echo $base; ?>image/no-image-hover.png");
			}
			else{
			}
			
			
		});
		$(".addphotos-wrap > input").mouseout(function(){
			
			check_img1 = $(this).prevAll('img').first().attr("src");
			no_img1 = '<?php echo $base; ?>image/no-image-hover.png';
			
			
			if(check_img1 == no_img1){
				check_img1 = $(this).prevAll('img').first().attr("src", "<?php echo $base; ?>image/no-image.png")
			}
			else{
			}
			
			
		});
	</script>
	<style>
		#login_panal_modal {
			left: 50%;
			height: 414px !important;
		}
		
		#login_panal_modal .modal-content {
			box-shadow: none;
			border: 0;
		}
		
		.solo-en-block {
			margin-top: 8px;
		}
		
		.search-input-block {
			height: 41px;
		}
		
		.search-bar-container {
			font-size: 14px;
		}
		
		.search-up-down {
			line-height: 1.3;
		}
		
		.top-icons-container {
			padding-top: 14px;
		}
		
		.listing-type {
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">
		$('select[name=\'provience_id\']').on('change', function(){
			var data_attribute = this.value;
			$.ajax({
				url: 'index.php?route=customuserdetail/userdetail/cities_lc',
				type: 'POST',
				dataType: 'json',
				data: {city_id: data_attribute},
				success: function(data){
					if(data == ''){
						$('#input-city').html('<option value="0" selected="selected">none</option>');
					}
					var resulted_data = '';
					for(i = 0; i < data.length; i++){
						resulted_data = resulted_data + "<option value = " + data[i].id + ">" + data[i].localidad + "</option>"
					}
					$('#input-city').html(resulted_data);
					
				}
			});
		});
		
		$('select[name=\'country_id\']').trigger('change');
		$('#buyer-pickup').trigger('click');
	</script>
<?php echo $footer; ?>