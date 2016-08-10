<?php
//echo "<pre>";
//print_r($reported_address);
//exit;

echo $header;  ?>
	<style>
		.navbar-inverse {
		
			    background-color: #312783;
				border-color: #312783;
		
		}
		.nav.navbar-nav.pull-right li a{
			color: #ddd;
			font-weight:bold;
		}
		
		.navbar-brand span{
			color:#ddd;
		}
		
		.mrtop32{
			    margin-top: 32px;
		}
		
		.brdr{
		    border-bottom: 2px solid;
			margin-bottom: 19px;
		}
		.textarea{
		width: 100%;
		height: 152px;
		border-color: #ddd;
		border-radius: 13px;
		}
		
		.midbox{
		margin: 30px auto;
		float: none;
		display: block;
		}
		.linehclass{
		line-height: 48px;
		}

	</style>	
    <!-- Navigation -->
    <nav class="navbar navbar-inverse" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="summary.html"><i class="glyphicon glyphicon-dashboard" style="color:white;">&nbsp</i><span>DASHBOARD</span></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav pull-right">
                    <li>
                        <a href="summary.html">Summary</a>
                    </li>
                    <li>
                       <a href="questions.html">Questions</a>
                    </li>
                    <li>
                        <a href="Purchase.html">Purchases</a>
                    </li>
					<li>
                        <a href="#">My Products</a>
                    </li>
					<li>
                        <a href="#">Answers</a>
                    </li>
					<li>
                        <a href="#">Sales</a>
                    </li>
				</ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
    <!-- Page Content -->
    <div class="col-sm-10 midbox">
	<div class="clearfix"></div>
      <div class="col-sm-12 brdr">
		<div class="col-sm-12 pull-left"><h2>Report Publications</h2></div>
	  </div>
	  <div class="col-sm-12">
		<div class="col-sm-2"><label class="center">Filters<label></div>
		<div class="col-sm-2">
			<select name="status" class="form-control">
				<option value="">Open</option>
				<option value="">Closed</option>
			</select>
		</div>
		<div class="col-sm-2">
			<input type="" class="form-control" placeholder="Buyer Or Seller Name" />
		</div>
		<div class="col-sm-2">
			<select name="status" class="form-control">
				<option>Any Reason</option>
				<option>I Did not Get the Product</option>
			</select>
		</div>
		<div class="col-sm-2">
			<input type="" class="form-control" placeholder="Ranking" />
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-primary">Search</button>
		</div>
	  </div>
	  <br />
	  
	   <?php
	  $aa=0;
	foreach($reported_products  as $products){
	  ?>
	  <div class="col-sm-12" style="margin-top:81px;">
	 
	  <div class="col-sm-6">
				<?php
				if($products['type_of_issue']==1){
					echo"<p><b>Report Type:&nbsp;It has contact detail</b></p>";
				}
				
				if($products['type_of_issue']==2){
				echo"<p><b>Report Type:&nbsp;Post a lower then accuitly paid</b></p>";
				}
				if($products['type_of_issue']==3){
				echo"<p><b>Report Type:&nbsp;It is evident that sells a copy or forgery</b></p>";
				
				}
				if($products['type_of_issue']==4){
				
				echo"<p><b>Report Type:&nbsp;Sells a product that dose not meet the term and condition of the site</b></p>";
				}
				if($products['type_of_issue']==5){
				echo"<p><b>Report Type:&nbsp;Others</b></p>";
				}
				?>
	  		 <div class="col-sm-2"><img src="image/<?php echo $products['image']; ?>" height="84px" width="61px"></div>
	  		 <div class="col-sm-10">
	  		 		<p><b><?php echo $products['name']; ?></b></p>
	  		 		<p>$<?php echo $products['price']; ?>  x 1 Unit</p>
	  		 </div>	
	  	</div>
		 <div class="col-sm-6 text-right">
			<span>Date</span><br />	
			<span><?php  echo date(' j /m /Y ', strtotime($products['date_time']));  ?></span>
	  	</div>
	  
	  
	  <div class="col-sm-12">
	  <div class="col-sm-9">
		<br/><label><b>User</b></label><br />
		<br /><label><?php echo $reported_address[$aa]['v_name']; ?></label><br />
		<label><?php echo $reported_address[$aa]['telephone']; ?></label><br />
		<label><?php echo $reported_address[$aa]['email']; ?></label><br />
		<p><?php echo $reported_address[$aa]['v_address'];   ?> </p><br />
                <a href="index.php?route=dashboard/dashboardreport&xds=<?php echo $products['product_id'];?>&cust=<?php echo $reported_address[$aa]['customer_id'];   ?>">View Details</a>
	  </div>
	  </div>
	  </div>
	  <?php $aa++; } ?>
	  </div>
    </div>
<div class="clearfix"></div>
    <?php echo $footer;  ?>