<?php
error_reporting (0);
 echo $header; 

global $loader, $registry;
$loader->model('catalog/category');
$modelCat = $registry->get('model_catalog_category');
?>
<style>
    button.no-border{
        border: 0px;
        background-color: #F5F5F5;
    }
</style>  

<div class="search-product-head-container">
   <div class="container">
       <div class="search-produ-head">
           <div class="breadcum-block">
                <ul>
                    <li>Home</li>
                    <li>&gt;</li>
                    <li><?php if(isset($_GET['loc'])) echo $_GET['loc'];?></li>
                </ul>
           </div>
       </div>
   </div>
</div>


<div class="container">

  <div class="row">

    <?php echo $productsidebar;?>

    <div class="col-sm-9 col-md-9 col-lg-9 col-w-940 products-area">
     <?php 
     if ($products) {
     
     ?>
		<div class="produ-list-top-block">
           <div class="items-block">
             <?php echo $results; ?>&nbsp;&nbsp;&nbsp;
           </div>
           <div class="list-gread-block">
             <button type="button" id="list-view" class="no-border list-grid-switch" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
             <button type="button" id="grid-view" class="no-border list-grid-switch" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th-large grid-acti"></i></button>
           </div>
           <div class="drop-btn-relev">
             <div class="dropdown-btn">
               <select id="input-sort" style="width:30px;" class="highprice-select" onchange="location = this.value;">
                <?php foreach ($sorts as $sorts) { ?>
                <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="drop-btn-relev">
           <div class="dropdown-btn">
             <select id="input-limit" style="width:30px;" class="highprice-select" onchange="location = this.value;">
              <?php foreach ($limits as $limits) { ?>
              <?php if ($limits['value'] == $limit) { ?>
              <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>   

        <div class="clr"></div>
      </div>
      <div class="clr"></div>
      <div class="product-main-container">
        <div id="grid-view-area" >   
          <?php
          $prod_count = 1;
          foreach ($products as $product) { ?>   
          <div class="product-one-main product-one-block <?php if($prod_count%4 == 0) echo 'block-last-child';?>">
			<?php
				if($product['listing_type']==3)
				{
					$date1 = new DateTime(date('y-m-d'));
					$date2 = new DateTime($product['date_added']);
					$diff = $date2->diff($date1)->format("%a");
					if($diff < 30){
						 echo'<span class="liquidation_ribbon"></span>';
					}
				}
				else if($product['listing_type']==2)
				{
					echo'<span class="destacada_ribbon"></span>';
				}
				else if($product['listing_type']==1)
				{
					echo'<span class="gratics_ribbon"></span>';
				}
			?>
		   
		   <div class='grid-overflow'>
		   <a href="#" class="whole_product_redirections prevent_default2"  quantity = 1 amount = <?php echo $product['price']; ?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $product['price']; ?> ></a>
			<div class="product-img-block"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
			</div>
			<div class="product-title">
				<?php echo $product['name']; ?>
			</div>
           <?php
           /******View all discounted quantities******/
           $disQuantities = $modelCat->getProductDiscounts($product['product_id']);
           $minPrice; $maxPrice;
           if ($product['onlyPrice']) {
           $minPrice = round($product['onlyPrice'], 0);
           $maxPrice = round($product['onlyPrice'], 0);
         }
         $tier_count = 0;
         $disQuantities;
         $disLen = count($disQuantities);
         foreach ($disQuantities as $disQuantity) {
         if ($tier_count == 0) {
         
       } else if ($tier_count == $disLen - 1) {
       $minPrice = round($disQuantity['price'], 0);
     }
     $tier_count++; 
   }
   ?>
   <?php ?>
   <div class="amt-block-container">
    <div class="unit-price-block">
        <div class="price-block-container">
            <?php 

            ?>
            <?php echo $currencySymb.$maxPrice;?>
        </div>
        <div class="price-content-container">
            Precio Unit
        </div>
    </div>
    <div class="min-price-block">
        <div class="">
            <?php echo $currencySymb.$minPrice;?>
        </div>
        <div class="price-content-container">
            Más Barato
        </div>
    </div>
    <div class="clr"></div>


    <div class="shipping-truck-block col-sm-6">
       <div class="shipping-content-container">
        Shipping
    </div>
</div>
<br>

<div class="product-condition-block col-sm-12 padding0">
    <div class="col-sm-7 padding0 text-left product-address-block">
        <div class="product-address-content-container">
            Capital Federal
        </div>
    </div>
    <div class="col-sm-5 product-condition-content-container padding0 text-right">
       Artículo Nuevo
   </div>

</div>

<div class="clr"></div>
</div>
   
   <div class="over-table-block">
   
     <div class="clr"></div>
	<div class='fix_tier_price_at_bottom'>
	<div class="product_title_tier_prices"><?php echo $product['name'];?></div>
     <!--unit price instance-->   
     <div class="first-amt-block">
       <a href="#" class='prevent_default' quantity = 1 amount = <?php echo $currencySymb.$maxPrice;?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?> >
         <div class="one-no-block prod-list-amt-first">
           1
         </div>
         <div class="one-block-amt prod-list-amt-first">
           <?php echo $currencySymb.$maxPrice;?>
         </div>
       </a>
     </div>   
     <?php
     /******View all discounted quantities******/  
     foreach ($disQuantities as $disQuantity) {
     ?>   
     <div class="first-amt-block">
       <a href="#" class='prevent_default' quantity = <?php echo $disQuantity['quantity']; ?> amount = <?php echo $currencySymb.round($disQuantity['price'],0)?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?> >
         <div class="one-no-block prod-list-amt-first">
           <?php echo $disQuantity['quantity'];?>
         </div>
         <div class="one-block-amt prod-list-amt-first">
           <?php echo $currencySymb.round($disQuantity['price'],0)?>
         </div>
       </a>
     </div>
     <?php
   }
   ?>
   <div class="col-sm-6" style="padding: 0 4px 0;">
     <div class="in-stock-block produ-list-in-stock">
       <?php echo $product['stock'];?> en Stock
     </div>
     <div class="stock-content">
       Palermo, Buenos Aires
     </div>
   </div>
	<div class="col-sm-6 b_x_2">
		<span class="percentage_saved"></span>
		<br>
		<span class="total_amount_saved"></span>
  </div>
  </div>
</div>
<div class="prod-bottom-bar grid_view_item">
	<span style="float:left" class="escala-font">
		<img src="https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfl1/v/t1.0-9/13507178_10209719049803807_9121710258395629353_n.jpg?oh=4646fb6e51c66048a89075d7a4d6650c&amp;oe=58063436&amp;__gda__=1479859703_4073f4d5403df5081fc0703dd0b49c3a" width="23px" height="23px"> 
		ESCALA DE DESCUENTOS
	</span>
</div>
</div>
</div>

<?php
$prod_count++;
}
?>   
<div class="clr"></div> 
</div>

<div id="list-view-area" style="display:none;">   
  <?php
  foreach ($products as $product) { ?> 

  <div class="product-list-block">
   <div class="row">
    <div class="col-sm-7 col-md-7 col-lg-8">
     <div class="list-hover-view">
	 
     <div class="product-img-block">
       <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
     </div>
     <div class="list-view-name">
       <div class="product-head">
        <?php echo $product['name']; ?>
      </div>
                            <?php if(!empty($product['location'])){?>
                             <div class="location-list">
                              <i class="fa fa-map-marker"></i> 
                              <?php echo $product['location'];?>
                            </div>
                            <?php }?>
                          </div>
                          <?php
                          $disQuantities = $modelCat->getProductDiscounts($product['product_id']); 

                          $minPrice; $maxPrice;
                          if ($product['onlyPrice']) {
                          $minPrice = round($product['onlyPrice'], 0);
                          $maxPrice = round($product['onlyPrice'], 0);
                        }
                        $tier_count = 0;
                        $disQuantities;
                        $disLen = count($disQuantities);
                        foreach ($disQuantities as $disQuantity) {
                        if ($tier_count == 0) {
                        
                      } else if ($tier_count == $disLen - 1) {
                      $minPrice = round($disQuantity['price'], 0);
                    }
                    $tier_count++; 
                  }?>
					<div class="table-responsive over-table-block">
						<table class="table">
							<tbody>
								<tr class="first-amt-block">
									<td style="cursor:pointer"  class='prevent_default_list' hover_effect_selector='0' quantity = 1 amount = <?php echo $currencySymb.$maxPrice;?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?>>1</td>
									<?php /******View all discounted quantities******/
										$effect_value=1;
										foreach($disQuantities as $disQuantity)
										{
											?> 
											<td style="cursor:pointer"  class='prevent_default_list' hover_effect_selector='<?php echo $effect_value ?>' quantity = <?php echo $disQuantity['quantity']; ?> amount = <?php echo $currencySymb.round($disQuantity['price'],0)?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?> ><?php echo $disQuantity['quantity'];?></td>
											<?php 
											$effect_value++;
										}
									?>
									<td rowspan="2">
										<span class='list_view_saved_percent'>
											-0%
										</span>
										<br>
										<span class='list_view_saved_amount_keyword'>
											Ahorra
										</span>
										<br>
										<span class='list_view_saved_amount_value'>
											$0!
										</span>
									</td>
								</tr>
								<tr class="first-amt-block">
									<td style="cursor:pointer" class='prevent_default_list' hover_effect_selector='0' quantity = 1 amount = <?php echo $currencySymb.$maxPrice;?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?> ><?php echo $currencySymb.$maxPrice;?></td>
										<?php
											/******View all discounted prices******/    
											$effect_value=1;
											foreach ($disQuantities as $disQuantity)
											{
												?>
												<td style="cursor:pointer"  class='prevent_default_list hover_effect' hover_effect_selector='<?php echo $effect_value ?>' quantity = <?php echo $disQuantity['quantity']; ?> amount = <?php echo $currencySymb.round($disQuantity['price'],0)?> product_id=<?php echo $product['product_id']?> original_quantity=1 original_price=<?php echo $currencySymb.$maxPrice;?> ><?php echo $currencySymb.round($disQuantity['price'],0)?></td>
												<?php
												$effect_value++;
											}
										?>
								</tr>
								<tr>
									<td colspan="6"><span id="feature_dialogue"><?php echo $product['name']; ?></span>
										<br>
										<span id="feauture_d_after">Stock <?php echo $product['stock'];  ?> - <?php echo $product['location'];  ?></span>
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
			<div class="col-sm-5 col-md-5 col-lg-4">
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
								<?php  echo $currencySymb.$minPrice;; ?>
							</div>
							<div class="min-content-container">
								Más Barato
							</div>
						</div>
						<div class="clr"></div>

						    <div class="shipping-truck-block col-sm-6">
							   <div class="shipping-content-container">
								::before
								Envio
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
</div>

</div>
<div class="product-pagi-block">
 <?php echo $pagination; ?>
</div>


<?php
}
?>
</div>

<div class="col-sm-12 col-md-12 col-lg-12">
 <div class="banner-block">                   
   <a href="#">Learn more</a>
   <div class="clr"></div>
 </div>
</div>

</div>
</div>

<script>
$('.prevent_default').click(function(event)
{
	event.preventDefault();
	this_element = $(this);
	var quantity = this_element.attr('quantity');
	var amount = this_element.attr('amount');
	var product_id = this_element.attr('product_id');
	window.location.href="<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr="+amount+"&xqtn="+quantity+"&pxs="+product_id;
});

$('.prevent_default2').click(function(event)
{
	event.preventDefault();
	this_element = $(this);
	var quantity = this_element.attr('quantity');
	var amount = this_element.attr('amount');
	var product_id = this_element.attr('product_id');
	window.location.href="<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr="+amount+"&xqtn="+quantity+"&pxs="+product_id;
});

var setTimeoutConst_grid;
$('.prevent_default').mouseover(function(event)
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
			
		discounted_price = product_amount_final;
		
		discounted_price_remaining = Math.round(original_price) - discounted_price;
		discounted_percent = (discounted_price_remaining / Math.round(original_price)) * 100;
		
		this_element.parents().eq(1).children().last().children(0)[0].innerHTML = "-"+Math.round(discounted_percent)+"%";

		saved_amount = discounted_price_remaining * product_quantity_final;
		
		this_element.parents().eq(1).children().last().children(0)[2].innerHTML = "Ahorra $"+Math.round(saved_amount)+"!";
	}, 1000);
}).mouseleave(function(event)
{
	clearTimeout(setTimeoutConst_grid);
});


var setTimeoutConst;
$('.prevent_default_list').mouseover(function(event)
{
	this_element = $(this);
	hover_effect_selectors = this_element.attr('hover_effect_selector');
	this_element.parents().eq(1).find('td[hover_effect_selector = '+hover_effect_selectors+']').addClass('hover_effect_selector');
	
	setTimeoutConst = setTimeout(function()
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

		discounted_price = product_amount_final;

		discounted_price_remaining = Math.round(original_price) - discounted_price;
		discounted_percent = (discounted_price_remaining / Math.round(original_price)) * 100;
		
		this_element.siblings('.hover_selected_tier_price').removeClass('hover_selected_tier_price');
		this_element.addClass('hover_selected_tier_price');
		
		saved_amount = discounted_price_remaining * product_quantity_final;
	
		this_element.parents().eq(1).find('.list_view_saved_percent').text("-"+Math.round(discounted_percent)+"%");
		this_element.parents().eq(1).find('.list_view_saved_amount_value').text("$"+Math.round(saved_amount)+"!");
	}, 1000);
}).mouseleave(function(event)
{
	clearTimeout(setTimeoutConst);
	hover_effect_selectors = $(this).attr('hover_effect_selector');	
	$('td[hover_effect_selector = '+hover_effect_selectors+']').removeClass('hover_effect_selector');
});

$('.prevent_default_list').click(function (event)
{
	this_element = $(this);
	var quantity = this_element.attr('quantity');
	var amount = this_element.attr('amount');
	var product_id = this_element.attr('product_id');
	window.location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?route=Productdetails/productdtls&zamr=" + amount + "&xqtn=" + quantity + "&pxs=" + product_id;
});

$('.prod-bottom-bar.grid_view_item').click(function()
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

$('.prod-bottom-bar.right').click(function()
{
	if($(this).siblings('.over-table-block').css('display') == 'none')
	{
		$(this).siblings('.over-table-block').show("slide", { direction: "right" }, 1000);
		$(this).css('left','89%');
	}
	else
	{
		$(this).siblings('.over-table-block').hide("slide", { direction: "right" }, 1000);
		$(this).css('left','100%');
	}
});
</script>
<?php echo $footer; ?>