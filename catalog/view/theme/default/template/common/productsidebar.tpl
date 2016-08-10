<?php
global $loader, $registry;
$price="";
$search="";
$loader->model('catalog/productsidebar');
$modelSidebar = $registry->get('model_catalog_productsidebar');

$loader->model('catalog/category');
$modelCat = $registry->get('model_catalog_category');
?>
<?php
if(isset($_GET['price'])){
	$price='&price='.$_GET['price'];
	
}else{
	$price='';
}
if(isset($_GET['search'])){
	$search='&search='.$_GET['search'];
	
}else{
	$search='';
}

 ?>
<style>
.search_box
{
	padding:6px !important;
}


</style>
    <div class="col-sm-2 col-md-4 col-lg-6 col-w-600">
       <div class="list-cate-main">
            <div class="populer-cate-container">
               <div class="populer-cate-head">
			   <?php  
	if(isset($_GET['path'])){
		
			   $cat_id=$_GET['path'];
			
			  $tree_name_get = $modelCat->get_category_tree_name($cat_id);
			  print_r($tree_name_get);

	}
else{
	$cat_id="";
}
			   ?>
                 <?php      ?>
               </div>
               <div class="populer-cate-content">
                  <?php
                  /******View all categories******/
                  $categories = $modelSidebar->getCategories();  
                  foreach ($categories as $category) {
                        $prducts_count = $modelSidebar->getCatProductsCount($category['category_id']);
						
						if($_GET['path']==0){
							
						
                  ?>
				  
                       <div class="first-popu-cate">
                           <a href="<?php echo $base.'index.php?route=product/category&path='.$category['category_id']; ?>" class=""><?php echo $category['name']; ?> <span>(<?php echo $prducts_count;?>)</span></a>
                       </div>
                      <?php
					  }
					  
                      if(isset($_GET['path'])){ 
                           // if($_GET['path'] == $category['category_id']){
							   // echo "if lulu";
                                // $children = $modelSidebar->getCategories($category['category_id']);
                                // foreach ($children as $child) {
                                    // $prducts_count = $modelSidebar->getCatProductsCount($child['category_id']);
                                // ?>
                                     <!--<div class="first-popu-cate">
                                        <a href="<?php //echo $base.'index.php?route=product/category&path='.$child['category_id']; ?>" class="">&nbsp;&nbsp;&nbsp;- <?php //echo $child['name']; ?> <span>(<?php //echo $prducts_count; ?>)</span></a>
                                     </div>  --> 
                                 <?php
                                // }
                            // }
                            // else 
                            
                            
                            
								if($_GET['path'] != 0){
							
                            
                                 $children = $modelSidebar->getCategories($_GET['path']);
                                 foreach ($children as $child) {
                                    $prducts_count = $modelSidebar->getCatProductsCount($_GET['path']);
                                 }

                            	$children = $modelCat->get_sub_cat($_GET['path']);
								//echo "<pre>"; print_r($children); echo "</pre>";
                               // exit;
                                
                                $parent_id = $modelSidebar->getCatParentId($_GET['path']);
                                foreach ($children as $child) {
                                    //if($parent_id == $child['parent_id']){
                                        $prducts_count = $modelSidebar->getCatProductsCount($_GET['path']);
                                ?>
                                        <div class="first-popu-cate">
                                            <a href="<?php echo $base.'index.php?route=product/category&path='.$child['category_id'].$search.$price; ?>" class="">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?>
                                        </div>   
                                <?php
                                    //}
                                }
                            }
                        }
						
						if($_GET['path'] != 0){
							break;
						}
						
						
				  }
					  
                  ?>
               </div>
           </div>
       </div>
   </div>





   
   
   