<?php 
echo $header;
 
global $loader, $registry;
$loader->model('dashboard/product');
$tier_price = $registry->get('model_dashboard_product');
echo $header1;

?>

<style>
.add-new-tier{
	display:block;
	text-align:center;
	font-size:1.4em;
}
.new-price-append{
	margin-top:5px;
}

}
/***
Bootstrap Line Tabs by @keenthemes
A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme
Licensed under MIT
***/

/* Tabs panel */
.tabbable-panel {
	padding: 10px;
}
/* Default mode */
.tabbable-line > .nav-tabs {
	border: none;
	margin: 0px;
}
.tabbable-line > .nav-tabs > li {
	margin-right: 2px;
}
.tabbable-line > .nav-tabs > li > a {
	border: 0;
	margin-right: 0;
	color: #737373;
}
.tabbable-line > .nav-tabs > li > a > i {
	color: #a6a6a6;
}
.tabbable-line > .nav-tabs > li.open, .tabbable-line > .nav-tabs > li:hover {
	border-bottom: 4px solid #fbcdcf;
}
.tabbable-line > .nav-tabs > li.open > a, .tabbable-line > .nav-tabs > li:hover > a {
	border: 0;
	background: none !important;
	color: #333333;
}
.tabbable-line > .nav-tabs > li.open > a > i, .tabbable-line > .nav-tabs > li:hover > a > i {
	color: #a6a6a6;
}
.tabbable-line > .nav-tabs > li.open .dropdown-menu, .tabbable-line > .nav-tabs > li:hover .dropdown-menu {
	margin-top: 0px;
}
.tabbable-line > .nav-tabs > li.active {
	border-bottom: 4px solid #f3565d;
	position: relative;
}
.tabbable-line > .nav-tabs > li.active > a {
	border: 0;
	color: #333333;
}
.tabbable-line > .nav-tabs > li.active > a > i {
	color: #404040;
}
.tabbable-line > .tab-content {
	margin-top: -3px;
	background-color: #fff;
	border: 0;
	border-top: 1px solid #eee;
	padding: 15px 0;
}
.portlet .tabbable-line > .tab-content {
	padding-bottom: 0;
}
/* Below tabs mode */

.tabbable-line.tabs-below > .nav-tabs > li {
	border-top: 4px solid transparent;
}
.tabbable-line.tabs-below > .nav-tabs > li > a {
	margin-top: 0;
}
.tabbable-line.tabs-below > .nav-tabs > li:hover {
	border-bottom: 0;
	border-top: 4px solid #fbcdcf;
}
.tabbable-line.tabs-below > .nav-tabs > li.active {
	margin-bottom: -2px;
	border-bottom: 0;
	border-top: 4px solid #f3565d;
}
.tabbable-line.tabs-below > .tab-content {
	margin-top: -10px;
	border-top: 0;
	border-bottom: 1px solid #eee;
	padding-bottom: 15px;
}
</style>

<div class="search-product-head-container">
  <div class="container">
    <div class="search-produ-head"> 
      <!--<div class="breadcum-block product-detai-bread">
        <ul>
          <li>Home</li>
          <li>></li>
          <li>Shop</li>
          <li>></li>
          <li>T-Shirt</li>
        </ul>
      </div>--> 
    </div>
  </div>
</div>
<div class="min-height">
  <div class="container">
    <div class="row">
      <div class="col-sm-10 midbox">
        <div class="col-sm-12 pull-left">
          <h2>My Products</h2>
        </div>
        <div class="clearfix"></div>
        <div class="">
          <div class="">
            <div class="col-md-12">
              <div class="tabbable-panel">
                <div class="tabbable-line">
                  <ul class="nav nav-tabs ">
                    <li class="active"> <a href='#tab_default_1'; data-toggle="tab" onClick='active_url()' > Active </a> </li>
                    <li> <a href="#tab_default_2" data-toggle="tab" onClick='pause_url()' > Paused </a> </li>
                    <li> <a href="#tab_default_3" data-toggle="tab" onClick='finalize_url()' > Finilized </a> </li>
                  </ul>
                  <div class="tab-content">
                    <div class="tab-pane active" id="tab_default_1">
                      <p>
                      <div id="no-more-tables" class="alert" style="overflow:auto; width:100%;">
                        <table class="col-md-12 table-bordered table-striped table-condensed cf">
                          <thead class="cf">
                            <tr>
                              <th><input type="checkbox" name="checkallactive" class="check-all-active"></th>
                              <th>Title</th>
                              <th class="numeric">Type</th>
                              <th class="numeric">Visit</th>
                              <th class="numeric">Item Number</th>
                              <th class="numeric">Stock</th>
                              <th class="numeric">Price</th>
                              <th class="numeric">EDV</th>
                            </tr>
                          </thead>
                          <tbody>
                          <?php 
                          $i=0;
                          foreach($product as $prodVal){?>
                            <tr>
                              <td data-title="Code"><input type="checkbox" name="" class="active-product-checkbox" value="<?php echo $prodVal['product_id']; ?>"/></td>
                              
                              <td data-title="Price" class="numeric"><?php echo $prodVal['name'];?></td>
                              <td data-title="Change" class="numeric">
                                 <?php if($prodVal['listing_type'] == 1){ echo "Normal";}?>
                                 <?php if($prodVal['listing_type'] == 2){ echo "Prominent";}?>
                                 <?php 
                                       if($prodVal['listing_type'] == 3)
                                       {
                                       
                                          $get_saleOff_Days = new DateTime($prodVal['date_added']);
                                          $date_added_timestamp = $get_saleOff_Days->getTimestamp();
                                          
                                          $current_timestamp = time();
                                          
                                          $days_after_added_product_timestamp = $current_timestamp - $date_added_timestamp;
                                          $days_after_added_product = (($days_after_added_product_timestamp / 60) / 60 ) / 24;
                                          $remaining_days = round(30 - $days_after_added_product);
                                          
                                         // echo $remaining_days;
  
                                          echo "Sale Off ".$remaining_days." Days Left";
                                        
                                       }
                                  ?>
                                
                                  <?php  if($prodVal['listing_type'] != 3){?>
                                  <a href="javascript:void(0);" class="change-type-link change_type_text_<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                  <?php  } ?>
                                  <span class="product-type listing-type-<?php echo $prodVal['product_id']; ?>">
                                     <select class="change-type">
                                     <?php  if($prodVal['listing_type'] == 1){?>
                                       <option value="1">Normal</option>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php }else if($prodVal['listing_type'] == 2) {?>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php  } ?>

                                     </select>
                                     <button class="update-type btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>">OK</button>
                                  </span>
                                </td>
                              

                              </td>
                              <td data-title="Change %" class="numeric"><?php echo $prodVal['viewed']?></td>
                              <td data-title="Open" class="numeric"><?php echo $prodVal['sku']?></td>
                              <td data-title="High" class="numeric">
                                 
                                 <span class="current-stock current-stock-ids-<?php echo $prodVal['product_id']; ?>"><?php echo $prodVal['quantity']?></span>
                                 <a href="javascript:void(0);" class="change-stock-link" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                 
                                 <span class="span-stock stock-change-<?php echo $prodVal['product_id']; ?>">
                                     <input type="text" name="stock" class="update-stock-val-<?php echo $prodVal['product_id']; ?>" size="10">
                                     <button id="<?php echo $prodVal['product_id']; ?>" class="save-stock btn btn-warning btn-xs">OK</button>
                                 </span>
                              </td>
                              <td data-title="Low" class="numeric">
                                    <span class="current-sngl-prc-<?php echo $prodVal['product_id']; ?>">$ <?php echo number_format((float)$prodVal['price'], 2, '.', '');?></span>
                                   <span class="span-single-price">
                                       <input type="" class="input-single-price prc-val-<?php echo $prodVal['product_id']; ?>" placeholder="$" size="8" value="<?php echo number_format((float)$prodVal['price'], 2, '.', '');?>">
                                       <button class="edit-single-price pull-right btn btn-warning btn-xs edit-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-single-price btn btn-warning btn-xs save-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                   <div class="clearfix"></div>
                                   </span>
                                 
                                  
                                 <?php
                                 $terprc = $tier_price->getDiscountPrice($prodVal['product_id']);
                                 $count = 1;
                                 foreach($terprc as $prcval){
                                 ?>
                                    <div class="clearfix"></div>
                                    <br />
                                     <span class="current-tier-prc-<?php echo $prcval['product_discount_id']; ?>">$ <?php echo number_format((float)$prcval['price'], 2, '.', '');?></span>
                                     <span class="span-tier-price span-ter-prc-<?php echo $prcval['product_discount_id']; ?>">
                                       <input type="text" class="input-tier-quantity qty-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="6"  value="<?php echo $prcval['quantity'];?>">
                                       <input type="text" class="input-tier-price prc-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="8" placeholder="$" value="" data-tier="<?php echo number_format((float)$prcval['price'], 2, '.', '');?>">
                                       <button  class="del-tier-price btn btn-danger btn-xs pull-right del-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" my-id="<?php echo $prodVal['product_id']; ?>"><i class="glyphicon glyphicon-trash"></i></button>
                                       <button class="edit-tier-price btn btn-warning btn-xs pull-right edit-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-tier-price btn btn-warning btn-xs pull-right save-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" >OK</button>
                                   
                                     </span>
                                      
                                 <?php
                                  $count+=1;
                                 }
                                 ?>
                                 <!--<input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $i;?>" />-->
                                 <input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $prodVal['product_id']; ?>" />
                                 
                                 <div class="new-price-append-<?php echo $prodVal['product_id']; ?>">
                                 </div>
                                 
                                 <!--<span class="add-new-box extend-new-tier-<?php echo $i;?>">-->
                                 <span class="add-new-box extend-new-tier-<?php echo $prodVal['product_id']; ?>">
                                 
                                  <input type="text" class="new-qty-<?php echo $prodVal['product_id']; ?>" size="6" placeholder="QTY" />
                                  <input type="text" class="new-price<?php echo $prodVal['product_id']; ?>"  size="8"  placeholder="$" />
                                   <input type="hidden" class="prd-ter-id-<?php echo $prodVal['product_id']; ?>" value="<?php echo $prodVal['product_id']; ?>">
                                  <!--<button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $i;?>" >OK</button>-->
                                  <button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                 </span>
                                 <br/>
                                <?php  if($count < 5){ $display =  "style='cursor:pointer'"; } else{ $display = "style='display:none'"; } ?>
                                 <!--<span class="add-new-tier add-new-tier-<?php echo $i;?>"  <?php echo $display; ?> id="<?php echo $i;?>" >+</span>-->
                                 <span class="add-new-tier add-new-tier-<?php echo $prodVal['product_id']; ?>"  <?php echo $display; ?> id="<?php echo $prodVal['product_id']; ?>" >+</span>
                                 
                              </td>
                              <td data-title="Volume" class="numeric">
                                <a href="javascript:void(0);" class="pause-product" id="<?php echo $prodVal['product_id']; ?>">
                                <p class="">Paused</p>
                                </a> 
                                <a href="<?php echo $base;?>index.php?route=createlisting/category&updateproduct=<?php echo $prodVal['product_id']; ?>">
                                <p>Modify</p>
                                </a> 
                                <a href="javascript:void(0);" class="finalize-product" id="<?php echo $prodVal['product_id']; ?>" >
                                <p>Finilized</p>
                                </a>
                              </td>
                            </tr>
                            <?php
                            $i++;
                             } 
                             ?> 
                         </tbody>
                        </table>
                      </div>
                      <div class="b_links alert">
                      	<a href="javascript:void(0);" class="bulk-pause">Pause</a> | 
                        <a href="javascript:void(0);" class="bulk-finalize">Finalize</a> | 
                        <a href="javascript:void(0);" data-toggle="modal" data-target="#myModal" class="bulk-price-change">Change price</a>
                      </div>
                      </p>
                      <!--<p class="col-sm-3 pull-rikght"> <br />
                        <select class="form-control">
                          <option>Change Price</option>
                        </select>
                      </p>-->
                    </div>
                    <div class="tab-pane" id="tab_default_2">
                       
                     <p>
                      <div id="no-more-tables" class="alert" style="overflow:auto; width:100%;">
                        <table class="col-md-12 table-bordered table-striped table-condensed cf">
                          <thead class="cf">
                            <tr>
                              <th><input type="checkbox" name="checkallpause" class="check-all-pause"></th>                            
                              <th>Title</th>
                              <th class="numeric">Type</th>
                              <th class="numeric">Visit</th>
                              <th class="numeric">Item Number</th>
                              <th class="numeric">Stock</th>
                              <th class="numeric">Price</th>
                              <th class="numeric">EDV</th>
                            </tr>
                          </thead>
                          <tbody>
                          <?php 
                          $i=0;
                          foreach($pause_product as $prodVal){?>
                            <tr>
                              <td data-title="Code"><input type="checkbox" name="" class="pause-product-checkbox" value="<?php echo $prodVal['product_id']; ?>"/></td> 
                              <td data-title="Price" class="numeric"><?php echo $prodVal['name'];?></td>
                              <td data-title="Change" class="numeric">
                                 <?php if($prodVal['listing_type'] == 1){ echo "Normal";}?>
                                 <?php if($prodVal['listing_type'] == 2){ echo "Prominent";}?>
                                 <?php if($prodVal['listing_type'] == 3){ echo "Sale Off 5 Days Left";}?>
                                
                                  <?php  if($prodVal['listing_type'] != 3){?>
                                  <a href="javascript:void(0);" class="change-type-link" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                  <?php } ?>
                                  <span class="product-type listing-type-<?php echo $prodVal['product_id']; ?>">
                                     <select class="change-type">
                                     <?php  if($prodVal['listing_type'] == 1){?>
                                       <option value="1">Normal</option>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php }else if($prodVal['listing_type'] == 2) {?>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php } ?>
                                     </select>
                                     <button class="update-type btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>">OK</button>
                                  </span>
                                </td>
                              

                              </td>
                              <td data-title="Change %" class="numeric"><?php echo $prodVal['viewed']?></td>
                              <td data-title="Open" class="numeric"><?php echo $prodVal['sku']?></td>
                              <td data-title="High" class="numeric">
                                 
                                 <span class="current-stock current-stock-ids-<?php echo $prodVal['product_id']; ?>"><?php echo $prodVal['quantity']?></span>
                                 <a href="javascript:void(0);" class="change-stock-link" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                 
                                 <span class="span-stock stock-change-<?php echo $prodVal['product_id']; ?>">
                                     <input type="text" name="stock" class="update-stock-val-<?php echo $prodVal['product_id']; ?>" size="10">
                                     <button id="<?php echo $prodVal['product_id']; ?>" class="save-stock btn btn-warning btn-xs">OK</button>
                                 </span>
                              </td>
                              <td data-title="Low" class="numeric">
                                    <span class="current-sngl-prc-<?php echo $prodVal['product_id']; ?>">$ <?php echo number_format((float)$prodVal['price'], 2, '.', '');?></span>
                                   <span class="span-single-price">
                                       <input type="" class="input-single-price prc-val-<?php echo $prodVal['product_id']; ?>" placeholder="$" size="8" value="<?php echo number_format((float)$prodVal['price'], 2, '.', '');?>">
                                       <button class="edit-single-price pull-right btn btn-warning btn-xs edit-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-single-price btn btn-warning btn-xs save-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                   <div class="clearfix"></div>
                                   </span>
                                 
                                 
                                 <?php
                                 $terprc = $tier_price->getDiscountPrice($prodVal['product_id']);
                                 $count = 1;
                                 foreach($terprc as $prcval){
                                 ?>
                                    <div class="clearfix"></div>
                                    <br />
                                     <span class="current-tier-prc-<?php echo $prcval['product_discount_id']; ?>">$ <?php echo number_format((float)$prcval['price'], 2, '.', '');?></span>
                                     <span class="span-tier-price span-ter-prc-<?php echo $prcval['product_discount_id']; ?>">
                                       <input type="text" class="input-tier-quantity qty-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="6"  value="<?php echo $prcval['quantity'];?>">
                                       <input type="text" class="input-tier-price prc-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="8" placeholder="$" value="" data-tier="<?php echo number_format((float)$prcval['price'], 2, '.', '');?>">
                                       <button  class="del-tier-price btn btn-danger btn-xs pull-right del-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" my-id="<?php echo $prodVal['product_id']; ?>"><i class="glyphicon glyphicon-trash"></i></button>
                                       <button class="edit-tier-price btn btn-warning btn-xs pull-right edit-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-tier-price btn btn-warning btn-xs pull-right save-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" >OK</button>
                                   
                                     </span>
                                      
                                 <?php
                                  $count+=1;
                                 }
                                 ?>
                                 <!--<input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $i;?>" />-->
                                 <input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $prodVal['product_id']; ?>" />
                                 
                                 <div class="new-price-append-<?php echo $prodVal['product_id']; ?>">
                                 </div>
                                 
                                <!-- <span class="add-new-box extend-new-tier-<?php echo $i;?>">-->
                                <span class="add-new-box extend-new-tier-<?php echo $prodVal['product_id']; ?>">
                                  <input type="text" class="new-qty-<?php echo $prodVal['product_id']; ?>" size="6" placeholder="QTY" />
                                  <input type="text" class="new-price<?php echo $prodVal['product_id']; ?>"  size="8" placeholder="$" />
                                   <input type="hidden" class="prd-ter-id-<?php echo $prodVal['product_id']; ?>" value="<?php echo $prodVal['product_id']; ?>">
                                 <!-- <button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $i;?>" >OK</button>-->
                                  <button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                 </span>
                                 <br/>
                                <?php  if($count < 5){ $display =  "style='cursor:pointer'"; } else{ $display = "style='display:none'"; } ?>

                                 <!--<span class="add-new-tier add-new-tier-<?php echo $i;?>"  <?php echo $display; ?> id="<?php echo $i;?>" >+</span>-->
                                <span class="add-new-tier add-new-tier-<?php echo $prodVal['product_id']; ?>"  <?php echo $display; ?> id="<?php echo $prodVal['product_id']; ?>" >+</span>
                                 
                                 
                              </td>
                              <td data-title="Volume" class="numeric">
                                <a href="javascript:void(0);" class="active-product" id="<?php echo $prodVal['product_id']; ?>">
                                <p class="">Active</p>
                                </a> 
                                <a href="<?php echo $base;?>index.php?route=createlisting/category&updateproduct=<?php echo $prodVal['product_id']; ?>">
                                <p>Modify</p>
                                </a> 
                                <a href="javascript:void(0);" class="finalize-product" id="<?php echo $prodVal['product_id']; ?>" >
                                <p>Finilized</p>
                                </a>
                              </td>
                            </tr>
                            <?php
                            $i++;
                             } 
                             ?> 
                         </tbody>
                        </table>
                      </div>
                      <div class="b_links alert">
                      	<a href="javascript:void(0);" class="pause-bulk-active">Active</a> |
                        <a href="javascript:void(0);" class="pause-bulk-finalize">Finalize</a> |
                        <a href="javascript:void(0);" data-toggle="modal" data-target="#myModal1" class="bulk-price-change">Change price</a>
                      </div>
                      </p>
                       
                       
                    </div>
                    
                    
                    
                    <div class="tab-pane" id="tab_default_3">
 
 
                      <p>
                      <div id="no-more-tables" class="alert" style="overflow:auto; width:100%;">
                        <table class="col-md-12 table-bordered table-striped table-condensed cf">
                          <thead class="cf">
                            <tr>
                              <th><input type="checkbox" name="checkallfinalize" class="check-all-finalize"></th>                            
                              <th>Title</th>
                              <th class="numeric">Type</th>
                              <th class="numeric">Visit</th>
                              <th class="numeric">Item Number</th>
                              <th class="numeric">Stock</th>
                              <th class="numeric">Price</th>
                              <th class="numeric">EDV</th>
                            </tr>
                          </thead>
                          <tbody>
                          <?php 
                          $i=0;
                          foreach($finalize_product as $prodVal){?>
                            <tr>
                              <td data-title="Code"><input type="checkbox" name="" class="finalize-product-checkbox" value="<?php echo $prodVal['product_id']; ?>" /></td> 
                              <td data-title="Price" class="numeric"><?php echo $prodVal['name'];?></td>
                              <td data-title="Change" class="numeric">
                                 <?php if($prodVal['listing_type'] == 1){ echo "Normal";}?>
                                 <?php if($prodVal['listing_type'] == 2){ echo "Prominent";}?>
                                 <?php if($prodVal['listing_type'] == 3){ echo "Sale Off 5 Days Left";}?>
                                
                                   <?php  if($prodVal['listing_type'] != 3){?>
                                    <a href="javascript:void(0);" class="change-type-link" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                   <?php  } ?>
                                  <span class="product-type listing-type-<?php echo $prodVal['product_id']; ?>">
                                     <select class="change-type">
                                     <?php  if($prodVal['listing_type'] == 1){?>
                                       <option value="1">Normal</option>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php }else if($prodVal['listing_type'] == 2) {?>
                                       <option value="2">Prominent</option>
                                       <option value="3">Sale Off</option>
                                       <?php } ?>
                                     </select>
                                     <button class="update-type btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>">OK</button>
                                  </span>
                                </td>
                              

                              </td>
                              <td data-title="Change %" class="numeric"><?php echo $prodVal['viewed']?></td>
                              <td data-title="Open" class="numeric"><?php echo $prodVal['sku']?></td>
                              <td data-title="High" class="numeric">
                                 
                                 <span class="current-stock current-stock-ids-<?php echo $prodVal['product_id']; ?>"><?php echo $prodVal['quantity']?></span>
                                 <a href="javascript:void(0);" class="change-stock-link" id="<?php echo $prodVal['product_id']; ?>">Change</a>
                                 
                                 <span class="span-stock stock-change-<?php echo $prodVal['product_id']; ?>">
                                     <input type="text" name="stock" class="update-stock-val-<?php echo $prodVal['product_id']; ?>" size="10">
                                     <button id="<?php echo $prodVal['product_id']; ?>" class="save-stock btn btn-warning btn-xs">OK</button>
                                 </span>
                              </td>
                              <td data-title="Low" class="numeric">
                                    <span class="current-sngl-prc-<?php echo $prodVal['product_id']; ?>">$ <?php echo number_format((float)$prodVal['price'], 2, '.', '');?></span>
                                   <span class="span-single-price">
                                       <input type="" class="input-single-price prc-val-<?php echo $prodVal['product_id']; ?>" placeholder="$" size="8" value="<?php echo number_format((float)$prodVal['price'], 2, '.', '');?>">
                                       <button class="edit-single-price pull-right btn btn-warning btn-xs edit-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-single-price btn btn-warning btn-xs save-single-<?php echo $prodVal['product_id']; ?>" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                   <div class="clearfix"></div>
                                   </span>
                                 
                                 
                                 <?php
                                 $terprc = $tier_price->getDiscountPrice($prodVal['product_id']);
                                 $count = 1;
                                 foreach($terprc as $prcval){
                                 ?>
                                    <div class="clearfix"></div>
                                    <br />
                                     <span class="current-tier-prc-<?php echo $prcval['product_discount_id']; ?>">$ <?php echo number_format((float)$prcval['price'], 2, '.', '');?></span>
                                     <span class="span-tier-price span-ter-prc-<?php echo $prcval['product_discount_id']; ?>">
                                       <input type="text" class="input-tier-quantity qty-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="6"  value="<?php echo $prcval['quantity'];?>">
                                       <input type="text" class="input-tier-price prc-ter-val-<?php echo $prcval['product_discount_id']; ?>" size="8" placeholder="$" value="" data-tier="<?php echo number_format((float)$prcval['price'], 2, '.', '');?>">
                                       <button  class="del-tier-price btn btn-danger btn-xs pull-right del-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" my-id="<?php echo $prodVal['product_id']; ?>"><i class="glyphicon glyphicon-trash"></i></button>
                                       <button class="edit-tier-price btn btn-warning btn-xs pull-right edit-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" ><i class="glyphicon glyphicon-pencil"></i></button>
                                       <button class="save-tier-price btn btn-warning btn-xs pull-right save-tier-<?php echo $prcval['product_discount_id']; ?>" id="<?php echo $prcval['product_discount_id']; ?>" >OK</button>
                                   
                                     </span>
                                      
                                 <?php
                                  $count+=1;
                                 }
                                 ?>
                                 <!--<input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $i;?>" />-->
                                 <input type="hidden" value="<?php echo $count; ?>" class="tier-count-<?php echo $prodVal['product_id']; ?>" />
                                 
                                 <div class="new-price-append-<?php echo $prodVal['product_id']; ?>">
                                 </div>
                                 
                                 <!--<span class="add-new-box extend-new-tier-<?php echo $i;?>">-->
                                 <span class="add-new-box extend-new-tier-<?php echo $prodVal['product_id']; ?>">
                                  <input type="text" class="new-qty-<?php echo $prodVal['product_id']; ?>" size="6" placeholder="QTY" />
                                  <input type="text" class="new-price<?php echo $prodVal['product_id']; ?>"  size="8" placeholder="$" />
                                  <input type="hidden" class="prd-ter-id-<?php echo $prodVal['product_id']; ?>" value="<?php echo $prodVal['product_id']; ?>">
                                  <!--<button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $i;?>" >OK</button>-->
                                  <button class="save-new-tier btn btn-warning btn-xs" id="<?php echo $prodVal['product_id']; ?>" >OK</button>
                                 </span>
                                 <br/>
                                <?php  if($count < 5){ $display =  "style='cursor:pointer'"; } else{ $display = "style='display:none'"; } ?>

                                 <!--<span class="add-new-tier add-new-tier-<?php echo $i;?>"  <?php echo $display; ?> id="<?php echo $i;?>" >+</span>-->
                                 <span class="add-new-tier add-new-tier-<?php echo $prodVal['product_id']; ?>"  <?php echo $display; ?> id="<?php echo $prodVal['product_id']; ?>" >+</span>
                                 
                              </td>
                              <td data-title="Volume" class="numeric">
                                <a href="javascript:void(0);" class="active-product" id="<?php echo $prodVal['product_id']; ?>">
                                <p class="">Active</p>
                                </a> 
                                <a href="<?php echo $base;?>index.php?route=createlisting/category&updateproduct=<?php echo $prodVal['product_id']; ?>">
                                <p>Modify</p>
                                </a> 
                               <!-- <a href="javascript:void(0);" class="pause-product" id="<?php //echo $prodVal['product_id']; ?>" >
                                <p>Pause</p>
                                </a>-->
                              </td>
                            </tr>
                            <?php
                            $i++;
                             } 
                             ?> 
                         </tbody>
                        </table>
                      </div>
                      <div class="b_links alert">
                      	<a href="javascript:void(0);" class="finalize-bulk-active">Active</a> |
                        <!--<a href="javascript:void(0);" class="finalize-bulk-pause">Pause</a> |-->
                        <a href="javascript:void(0);" data-toggle="modal" data-target="#myModal2" class="bulk-price-change">Change price</a>
                      </div>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
  <div class="modal-dialog">
   <div class="col-sm-12">
	 <div class="col-sm-8" style="margin:0 auto;float:none;">
  	
      <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">Increase Price by %</h4>
      </div>
      <div class="modal-body">
        <p>
         <input type="text" name="changeprice" class="form-control col-sm-3 change-price" style="width: 30%;" required>
         &nbsp;<button class="btn btn-primary get-percentage" style="height: 33px;">Ok</button>
       </p>
      </div>
      <div class="modal-footer">        
      </div>
    </div>
  </div>
</div>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<div class="modal fade" id="myModal1" tabindex="-1" role="dialog">
  <div class="modal-dialog">
   <div class="col-sm-12">
	 <div class="col-sm-8" style="margin:0 auto;float:none;">
  	
      <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">Increase Price by %</h4>
      </div>
      <div class="modal-body">
        <p>
         <input type="text" name="changeprice" class="form-control col-sm-3 change-price-pause" style="width: 30%;" required>
         &nbsp;<button class="btn btn-primary get-percentage-pause" style="height: 33px;">Ok</button>
       </p>
      </div>
      <div class="modal-footer">        
      </div>
    </div>
  </div>
</div>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<div class="modal fade" id="myModal2" tabindex="-1" role="dialog">
  <div class="modal-dialog">
   <div class="col-sm-12">
	 <div class="col-sm-8" style="margin:0 auto;float:none;">
  	
      <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">Increase Price by %</h4>
      </div>
      <div class="modal-body">
        <p>
         <input type="text" name="changeprice" class="form-control col-sm-3 change-price-finalize" style="width: 30%;" required>
         &nbsp;<button class="btn btn-primary get-percentage-finalize" style="height: 33px;">Ok</button>
       </p>
      </div>
      <div class="modal-footer">        
      </div>
    </div>
  </div>
</div>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->






<script>
		if(window.location.hash) 
		{
			  var hash = window.location.hash.substring(1); //Puts hash in variable, and removes the # character
		
			  if(hash === 'active')
			  {
				   $( "ul.nav.nav-tabs" ).children().removeClass("active");
				   $( "ul.nav.nav-tabs" ).children().eq(0).addClass("active");
				   
				   $( "div.tab-content" ).children().removeClass("active");
				   $( "div.tab-content" ).children().eq(0).addClass("active");
			  }
			  else if(hash === 'pause')
			  {
				   $( "ul.nav.nav-tabs" ).children().removeClass("active");
				   $( "ul.nav.nav-tabs" ).children().eq(1).addClass("active");
				   
				   $( "div.tab-content" ).children().removeClass("active");
				   $( "div.tab-content" ).children().eq(1).addClass("active");
			  }
		
			  else if(hash === 'finalize')
			  {
				   $( "ul.nav.nav-tabs" ).children().removeClass("active");
				   $( "ul.nav.nav-tabs" ).children().eq(2).addClass("active");
				   
				   $( "div.tab-content" ).children().removeClass("active");
				   $( "div.tab-content" ).children().eq(2).addClass("active");
			  }
		
		
		}
		else 
		{
			  // No hash found
		}
		
		function active_url()
		{
			new_location = window.location.href.split('#');
			window.location.href = new_location[0] + "#active";
		}
		
		function pause_url()
		{
			new_location = window.location.href.split('#');
			window.location.href = new_location[0] + "#pause";
		}
		
		function finalize_url()
		{
			new_location = window.location.href.split('#');
			window.location.href = new_location[0] + "#finalize";
		}

		function priceformat(n) 
		{
			return  n.toFixed(2).replace(/./g, function(c, i, a) {
				return i > 0 && c !== "." && (a.length - i) % 3 === 0 ? "," + c : c;
			});
		}


	$( document ).ready(function() {

			var product_type = 1;
			var id = '';
			var update_type_attr = '';
			var product_id = '';
			var stock_id = '';
			var product_discount_id ='';
			var del_tier_price = '';
			
			var add_new_tier = '';
			var tier_count = '';
			var active_product = '';
			var pause_product = '';
			var finalize_product = '';
			
			
			
			$('.product-type').hide();
			$('.span-stock').hide();
			$('.save-single-price').hide();
			$('.input-single-price').hide();
			$('.input-tier-price').hide();
			$('.save-tier-price').hide();
			$('.input-tier-quantity').hide();
			
			$('.add-new-box').hide();
			
			
			
			
			
			
			$('.change-type-link').click(function(){
				$('.product-type').hide();
				id = $(this).attr('id');
				$('.listing-type-'+id).show();
			});
			
			//var change_type_text = '';
			$('.change-type').change(function(){
				product_type = $(this).val();
				  //change_type_text = $(this).find("option:selected").text();
				  
			});
			
			$('.update-type').click(function(){
				product_id = $(this).attr('id');
				$('.listing-type-'+product_id).hide();
					$.ajax({
						url: 'index.php?route=dashboard/product/updateProductType',
						type:'POST',
						//dataType: 'json',
						data: {"product_id":product_id , "product_type":product_type},
						success: function(data)
						{
							location.reload();							
						}   
					});
			});

			$('.change-stock-link').click(function(){
				$('.span-stock').hide();
				stock_id = $(this).attr("id");
				$('.stock-change-'+stock_id).show();
			});


			$('.save-stock').click(function(){
				product_id = $(this).attr('id');
				//$('.stock-change-'+product_id).hide();
				var st_val = $('.update-stock-val-'+product_id).val();
				//alert(st_val);
				st_val = $.trim(st_val);
				if(st_val === '')
				{
					return false;
				}
				else
				{
					$.ajax({
						url: 'index.php?route=dashboard/product/updateProductStock',
						type:'POST',
						data: {"product_id":product_id , "stock":st_val},
						success: function(data)
						{
							$('.current-stock-ids-'+product_id).text($('.update-stock-val-'+product_id).val());
							//$('.current-stock').text($('.update-stock-val-'+product_id).val());
							$('.stock-change-'+product_id).hide();
						}   
					});
				}
			});


			$('.edit-single-price').click(function(){
				
				$('.edit-single-price').show();
				$('.input-single-price').hide();
				$('.save-single-price').hide();
				
				product_id = $(this).attr("id");
				$('.edit-single-'+product_id).hide();
				$('.prc-val-'+product_id).show();
				$('.save-single-'+product_id).show();
				
			});
		
			$('.save-single-price').click(function(){
				
				
				product_id = $(this).attr('id');
				var prc_val = $('.prc-val-'+product_id).val();
				prc_val = $.trim(prc_val);
				
				if(prc_val === '')
				{
					return false;
				}
				else
				{
					$('.current-sngl-prc-'+product_id).text("$ "+priceformat(parseInt(prc_val)));
						$.ajax({
							url: 'index.php?route=dashboard/product/updateSinglePrice',
							type:'POST',
							data: {"product_id":product_id , "sngl_prc":prc_val},
							success: function(data)
							{
								$('.input-single-price').hide();
								$('.edit-single-'+product_id).show();
				                $('.save-single-'+product_id).hide();
							}   
						});
				}
			});
			
			var check_edit_id = 0;
			
			$('body').on('click', '.edit-tier-price', function(){
			
				$('.edit-tier-price').show();
				$('.input-tier-price').hide();
				$('.save-tier-price').hide();
				$('.input-tier-quantity').hide();

				product_discount_id = $(this).attr("id");
				
				$('.prc-ter-val-'+product_discount_id).val($('.prc-ter-val-'+product_discount_id).attr("data-tier"));
                check_edit_id = product_discount_id;
				$('.edit-tier-'+product_discount_id).hide();
				$('.prc-ter-val-'+product_discount_id).show();
				$('.qty-ter-val-'+product_discount_id).show();
				
				$('.save-tier-'+product_discount_id).show();
			});

			$('body').on('click', '.save-tier-price' , function(){
				//$('.input-tier-quantity').hide();
				//$('.input-tier-price').hide();
				product_discount_id = $(this).attr('id');
				var prc_tier_val = $('.prc-ter-val-'+product_discount_id).val();
				var qty_tier_val = $('.qty-ter-val-'+product_discount_id).val();
				
				$('.prc-ter-val-'+product_discount_id).attr("data-tier")
				//alert(prc_tier_val);
				prc_tier_val = $.trim(prc_tier_val);
				qty_tier_val = $.trim(qty_tier_val);
				if(prc_tier_val === '' || qty_tier_val === '' )
				{
					//alert("ok");
					return false;
				}
				else
			    {
				 $('.current-tier-prc-'+product_discount_id).text("$ "+priceformat(parseInt(prc_tier_val)));
					$.ajax({
						url: 'index.php?route=dashboard/product/updateTierPrice',
						type:'POST',
						data: {"product_discount_id":product_discount_id , "tier_prc":prc_tier_val , "qty_tier_val":qty_tier_val},
						success: function(data)
						{
							$('.input-tier-quantity').hide();
							$('.input-tier-price').hide();

							$('.edit-tier-'+product_discount_id).show();
							$('.save-tier-'+product_discount_id).hide();
							
							$('.prc-ter-val-'+product_discount_id).attr("data-tier",priceformat(parseInt(prc_tier_val)));
														
						}   
					});
				}
			});  


			$('body').on('click' , '.del-tier-price' ,function(){
				
				del_tier_price = $(this).attr('id');
				my_id_val = $(this).attr('my-id');
				//alert(my_id_val);
				//alert($('.tier-count-'+my_id_val).val());
				
					var current_tier_count1 =  parseInt($('.tier-count-'+my_id_val).val()) - 1;
					//alert(current_tier_count1);
				$.ajax({
						url: 'index.php?route=dashboard/product/deleteTierPrice',
						type:'POST',
						data: {"product_discount_id":del_tier_price},
						success: function(data)
						{
							$( ".span-ter-prc-"+del_tier_price ).fadeOut( "slow" );
							$('.current-tier-prc-'+del_tier_price).fadeOut("slow");
							
								var current_tier_count1 =  parseInt($('.tier-count-'+my_id_val).val()) - 1;
								//alert( current_tier_count1);
								current_tier_count1 = $('.tier-count-'+my_id_val).val(current_tier_count1);
								console.log(current_tier_count1);
								console.log(current_tier_count1[0].value);
								if(current_tier_count1[0].value < 5)
								{
									//alert(my_id_val);
									$('.add-new-tier-'+my_id_val).show();
								}
								$('span.current-tier-prc-'+del_tier_price).prev().remove();

							
							
						}   
				});
			});
			
			
			$('body').on('click' , '.add-new-tier' , function(){
				add_new_tier = $(this).attr("id");
				$('.new-qty-'+add_new_tier).val('');
				$('.new-price'+add_new_tier).val('');
				
				$('.add-new-box').hide();
				$('.extend-new-tier-'+add_new_tier).show();
			});


			$('body').on('click', '.save-new-tier' , function(){
				
				//check_edit_id = product_discount_id;
				if(check_edit_id !=0)
				{
				  $('.edit-tier-'+check_edit_id).show();
				  check_edit_id  = 0;
				}
				
				var html = '';
				add_new_tier = $(this).attr('id');
				var new_qty = $('.new-qty-'+add_new_tier).val();
				var new_prc = $('.new-price'+add_new_tier).val();
				var prod_id = $('.prd-ter-id-'+add_new_tier).val();
				
				if(new_qty == '' || new_prc == '')
				{
					return false;
				}
				else
				{
					$.ajax({
							url: 'index.php?route=dashboard/product/addTierPrice',
							type:'POST',
							data: {"new_qty":new_qty , "new_prc":new_prc , "prod_id":prod_id},
							success: function(data)
							{
								$('.add-new-box').hide();
								parse_json = JSON.parse(data);
							    //console.log(data);
								get_format_price = priceformat(parseInt(parse_json[0].price));
								html = '<div class="clearfix"></div><br>';
								html = html + '<span class="current-tier-prc-'+parse_json[0].product_discount_id+'">$ '+get_format_price+'</span>';
								html = html + '<span class="span-tier-price span-ter-prc-'+parse_json[0].product_discount_id+'" style="float:right">';
								html = html + ' <input type="text" class="input-tier-quantity qty-ter-val-'+parse_json[0].product_discount_id+'" size="6"  value="'+parse_json[0].quantity+'">';
								html = html + '<input type="text" class="input-tier-price prc-ter-val-'+parse_json[0].product_discount_id+'" size="8" placeholder="$" value="" data-tier="'+get_format_price+'">';
								html = html + ' <button class="edit-tier-price btn btn-warning btn-xs edit-tier-'+parse_json[0].product_discount_id+'" id="'+parse_json[0].product_discount_id+'" ><i class="glyphicon glyphicon-pencil"></i></button>';
								html = html + '<button  class="del-tier-price btn btn-danger btn-xs del-tier-'+parse_json[0].product_discount_id+'" id="'+parse_json[0].product_discount_id+'" my-id="'+prod_id+'" ><i class="glyphicon glyphicon-trash"></i></button>';
								html = html + ' <button class="save-tier-price btn btn-warning btn-xs save-tier-'+parse_json[0].product_discount_id+'" id="'+parse_json[0].product_discount_id+'" >OK</button>';
								html = html + '</span>';
								html = html + '<br />';
								
								$('.new-price-append-'+add_new_tier).append(html);

								$('.input-tier-price').hide();
								$('.save-tier-price').hide();
								$('.input-tier-quantity').hide();
								
								
								var current_tier_count =  + $('.tier-count-'+add_new_tier).val() + 1;
								current_tier_count = $('.tier-count-'+add_new_tier).val(current_tier_count);
								console.log(current_tier_count[0].value);
								if(current_tier_count[0].value >=5)
								{
									$('.add-new-tier-'+add_new_tier).hide();
									
								}
							}   
					});
				}
			});

			$('body').on('click' , '.pause-product' , function(){
				 pause_product = $(this).attr("id");
				 pause_products(pause_product);
				 location.reload();
			 });
			 
			 function pause_products(pause_product)
			 {
				$.ajax({
					 url: 'index.php?route=dashboard/product/pauseproduct',
					 type:'POST',
					 async:false,
					 data: {"pause_product":pause_product},
					 success: function(data)
					 {
						 //location.reload();
					 }   
				 });

			 }

			$('body').on('click' , '.active-product' , function(){
				active_product = $(this).attr("id");
				active_products(active_product);
				location.reload();

			 });
			 
			 function active_products(active_product)
			 {
				 $.ajax({
					 url: 'index.php?route=dashboard/product/activeproduct',
					 type:'POST',
					 async:false,
					 data: {"active_product":active_product},
					 success: function(data)
					 {
						
					 }   
				 });
				 
			 }

			$('body').on('click' , '.finalize-product' , function(){
				 finalize_product = $(this).attr("id");
				 finalize_products(finalize_product);
				 location.reload();
			 });
			 
			 function finalize_products(finalize_product)
			 {
				 $.ajax({
					 url: 'index.php?route=dashboard/product/finalizeproduct',
					 type:'POST',
					 async:false,
					 data: {"finalize_product":finalize_product},
					 success: function(data)
					 {
						 
					 }   
				 });
				 
			 }
			 
			 
			 
			 
			 
			 var activeArray = [];


			 $("body").on('change' , '.check-all-active' , function () {
                //$('.active-product-checkbox').not(this).prop('checked', this.checked);
				
					if(this.checked) 
					{ 
					    activeArray = [];
						$('.active-product-checkbox').each(function() 
						{ 
							this.checked = true;
							activeArray.push(this.value);                
						});
						console.log(activeArray);
					}
					else
					{
						$('.active-product-checkbox').each(function() 
						{ 
							this.checked = false; 
							get_all_index = activeArray.indexOf(this.value);

							if(get_all_index > -1)
							{
							   activeArray.splice(get_all_index , 1);
							}
						});
						console.log(activeArray);        
					}
             });



			$('body').on('change' , '.active-product-checkbox' , function(){

				if(this.checked)
				{
					activeArray.push(this.value);
				}
				else
				{
					get_index = activeArray.indexOf(this.value);
					if(get_index > -1)
					{
					   activeArray.splice(get_index , 1);
					}
			    }
				console.log(activeArray);
				console.log(activeArray.length);
			 });
			 

			$('body').on('click' , '.bulk-pause' , function(){
				console.log(activeArray[activeArray.length - 1]);
				for(var i =0; i < activeArray.length; i++ )
				{
					pause_products(activeArray[i]);
				}
				location.reload();
				
			 });


			$('body').on('click' , '.bulk-finalize' , function()
			{
				console.log(activeArray[activeArray.length - 1]);
				for(var i =0; i < activeArray.length; i++ )
				{
					finalize_products(activeArray[i]);
				}
				location.reload();
				
			});


			 var pauseArray = [];

			 $("body").on('change' , '.check-all-pause' , function () 
			 {
				
					if(this.checked) 
					{ 
					    pauseArray = [];
						$('.pause-product-checkbox').each(function() 
						{ 
							this.checked = true;
							pauseArray.push(this.value);                
						});
						console.log(pauseArray);
					}
					else
					{
						$('.pause-product-checkbox').each(function() 
						{ 
							this.checked = false; 
							get_all_index_pause = pauseArray.indexOf(this.value);

							if(get_all_index_pause > -1)
							{
							   pauseArray.splice(get_all_index_pause , 1);
							}
						});
						console.log(pauseArray);        
					}
             });



			$('body').on('change' , '.pause-product-checkbox' , function(){

				if(this.checked)
				{
					pauseArray.push(this.value);
				}
				else
				{
					get_index1 = pauseArray.indexOf(this.value);
					if(get_index1 > -1)
					{
					   pauseArray.splice(get_index1 , 1);
					}
			    }
				console.log(pauseArray);
				console.log(pauseArray.length);
			 });


			$('body').on('click' , '.pause-bulk-active' , function(){
				console.log(pauseArray[pauseArray.length - 1]);
				for(var i =0; i < pauseArray.length; i++ )
				{
					active_products(pauseArray[i]);
				}
				location.reload();
				
			 });

			$('body').on('click' , '.pause-bulk-finalize' , function(){
				console.log(pauseArray[pauseArray.length - 1]);
				for(var i =0; i < pauseArray.length; i++ )
				{
					finalize_products(pauseArray[i]);
				}
				location.reload();
				
			 });
			 
			 
			 
			 
			 
			 
			 
			 var finalizeArray = [];


			 $("body").on('change' , '.check-all-finalize' , function () 
			 {
					if(this.checked) 
					{ 
					    finalizeArray = [];
						$('.finalize-product-checkbox').each(function() 
						{ 
							this.checked = true;
							finalizeArray.push(this.value);                
						});
						console.log(finalizeArray);
					}
					else
					{
						$('.finalize-product-checkbox').each(function() 
						{ 
							this.checked = false; 
							get_all_index_pause = finalizeArray.indexOf(this.value);

							if(get_all_index_pause > -1)
							{
							   finalizeArray.splice(get_all_index_pause , 1);
							}
						});
						console.log(finalizeArray);        
					}
             });


			$('body').on('change' , '.finalize-product-checkbox' , function(){

				if(this.checked)
				{
					finalizeArray.push(this.value);
				}
				else
				{
					get_index22 = finalizeArray.indexOf(this.value);
					if(get_index22 > -1)
					{
					   finalizeArray.splice(get_index22 , 1);
					}
			    }
				console.log(finalizeArray);
				console.log(finalizeArray.length);
			 });
			 

			$('body').on('click' , '.finalize-bulk-active' , function(){

				for(var i =0; i < finalizeArray.length; i++ )
				{
					active_products(finalizeArray[i]);
				}
				location.reload();
				
			 });


			$('body').on('click' , '.finalize-bulk-pause' , function(){

				for(var i =0; i < finalizeArray.length; i++ )
				{
					pause_products(finalizeArray[i]);
				}
				location.reload();
			 });


			 


			 
			 
			 

            var change_percentage = '';
			$('body').on('click' , '.get-percentage' , function(e){
				
				form_errors = false;
				
				change_percentage = $('.change-price').val();
                
				if(change_percentage == '')
				{
					form_errors = true;
				}
				
				if(form_errors === true)
				{
					return false;
				}
				else
				{
					for(var i =0; i < activeArray.length; i++ )
					{
						changePrice(change_percentage, activeArray[i]);
					}
				 location.reload();
				}
			 });
			 
			 
			 function changePrice(percentage , procuctid)
			 {
				 $.ajax({
					 url: 'index.php?route=dashboard/product/changeprice',
					 type:'POST',
					 async:false,
					 data: {"percentage":percentage , "procuctid":procuctid},
					 success: function(data)
					 {
						 
					 }   
				 });

				 
			 }




            var change_percentage_pause = '';
			$('body').on('click' , '.get-percentage-pause' , function(e){
				
				form_errors = false;
				
				change_percentage_pause = $('.change-price-pause').val();
                
				if(change_percentage_pause == '')
				{
					form_errors = true;
				}
				
				if(form_errors === true)
				{
					return false;
				}
				else
				{
					for(var i =0; i < pauseArray.length; i++ )
					{
						changePrice(change_percentage_pause, pauseArray[i]);
					}
				location.reload();
				}
			 });
			 
			 

            var change_percentage_finalize = '';
			$('body').on('click' , '.get-percentage-finalize' , function(e){
				
				form_errors = false;
				
				change_percentage_finalize = $('.change-price-finalize').val();
                
				if(change_percentage_finalize == '')
				{
					form_errors = true;
				}
				
				if(form_errors === true)
				{
					return false;
				}
				else
				{
					for(var i =0; i < finalizeArray.length; i++ )
					{
						changePrice(change_percentage_finalize, finalizeArray[i]);
					}
				location.reload();
				}
			 });







var result = (100.98 / 43);
console.log(result);
		
	});
</script>

<?php echo $footer; ?>