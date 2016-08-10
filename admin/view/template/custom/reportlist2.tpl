<?php 
$status="";
$issuetype="";
$seller="";
if(isset($_POST['status'])){
	
	$_SESSION["status"] =$_POST['status'];
	$status=$_SESSION["status"];
}else{
	$status=$_SESSION["status"];	
}
if(isset($_POST['seller_name'])){
	$_SESSION["seller_name"] = $_POST['seller_name'];
	$seller=$_SESSION["seller_name"];
}else{
	$seller=$_SESSION["seller_name"];
}
if(isset($_POST['issuetype'])){
	
	$_SESSION["issuetype"]=$_POST['issuetype'];
	$issuetype=$_SESSION["issuetype"] ;
}else{
	$issuetype=$_SESSION["issuetype"];
}

if(isset($_POST['user_ranking'])){
	$_SESSION["user_ranking"] = $_POST['user_ranking'];
	$user_ranking=$_SESSION["user_ranking"];
	
}else{
	$user_ranking=$_SESSION["user_ranking"];
}
 ?>

<?php echo $header;
	echo $column_left;

  ?>
	<style>
	
	.content_move{
		transition: all ease-out .4s;
		-webkit-transition: all ease-out .4s;
		transform:translateX(0px);
		-webkit-transform:translateX(0px);
	}
	.movenow{
		transform:translateX(108px);
		-webkit-transform:translateX(108px);
	}
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
		
		select option { width:40px; }

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
    <div class="col-sm-10 midbox content_move">
	<div class="clearfix"></div>
      <div class="col-sm-12 brdr">
		<div class="col-sm-12 pull-left"><h2>Report Publications</h2></div>
	  </div>
	  <?php 
	  $token='&token='.$_GET['token'];
	  ?>
	  
	  <form action="index.php?route=custom/reportlist/search<?php echo $token; ?>" method="post" id="search_form">
	  <div class="col-sm-12">
		<div class="col-sm-2"><label class="center">Filters<label></div>
		<div class="col-sm-2">
			<select name="status" class="form-control">
				<option value="0">Open</option>
				<option value="1">Closed</option>
			</select>
		</div>
		<div class="col-sm-2">
			<input type="text" name="seller_name" class="form-control" placeholder="Buyer Or Seller Name" />
		</div>
		<div class="col-sm-2">
			<select name="issuetype" class="form-control">
				<option value="">Any Reason</option>
				<option value="1">It has contact detail</option>
				<option value="2">Post a lower then accuitly paid</option>
				<option value="3" style="width:10px;">It is evident that sells a copy or forgery</option>
				<option value="4">Sells a product that dose not meet the term and condition of the site</option>
				<option value="5">Others</option>
			</select>
		</div>
		<div class="col-sm-2">
			<input type="text" name="user_ranking" class="form-control" placeholder="Ranking" onkeypress=" return isNumber(event);" />
		</div>
		<div class="col-sm-2">
			<button type="submit" class="btn btn-primary">Search</button>
		</div>
	  </div>
	  </form>
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
	  		 <div class="col-sm-2"><img src="../image/<?php echo $products['image']; ?>" height="84px" width="61px"></div>
	  		 <div class="col-sm-10">
	  		 		<p><b><?php echo $products['name']; ?></b></p>
	  		 		<p>$<?php echo $products['price']; ?>  x 1 Unit</p>
	  		 </div>	
	  	</div>
		 <div class="col-sm-6 text-right">
			<?php  if($aa==0){
				
			 ?>
			<span>Date</span><span class="caret sort" id="down_arrow" data-value="ASC" style="cursor:pointer;" ></span><span class="dropup" ><span class="caret sort" id="up_arrow" data-value="DESC" style="cursor:pointer;" ></span></span><br />
			<?php } ?>			
			<span><?php  echo date(' j /m /Y ', strtotime($products['date_time']));  ?></span>
	  	</div>
	  <?php 
	  if(isset($_GET['token'])){
		  
	  $token='&token='.$_GET['token'];
	  }else{
		  $token="";
	  }
	  ?>
	  <div class="col-sm-12">
	  <div class="col-sm-9">
		<br/><label><b>User</b></label><br />
		<br /><label><?php echo $products['v_name']; ?></label><br />
		<label><?php echo $products['v_phone']; ?></label><br />
		<label><?php echo $products['v_email']; ?></label><br />
		<p><?php echo $products['address'];   ?> </p><br />
		<a href="index.php?route=custom/dashboardreport&xds=<?php echo $products['product_id'].$token	;?>">View Details</a>
	  </div>
	  </div>
	  </div>
	  <?php $aa++; } ?>
	  </div>
    </div>
<div class="clearfix"></div>
<script type="text/javascript">
$(document).ready(function(){
	var view = localStorage.getItem("up_arrow");
		if (view){
			$("#" + view).hide();
		} else{
			$("#down_arrow").hide();
		}
$("#down_arrow").click(function(){
	localStorage.setItem("up_arrow", "down_arrow");
	$("#down_arrow").hide();
	$("#up_arrow").show();
});	
$("#up_arrow").click(function(){
	localStorage.setItem("up_arrow", "up_arrow");
	$("#up_arrow").hide();
	$("#down_arrow").show();
});	
$(".sort").on("click" ,function(){
	var value=$(this).attr('data-value');
	var ids=$(this).attr('id');
	change_location(value);
});

if($('#column-left').hasClass('active')){
		
		$('.content_move').addClass('movenow');
	} else{
		$('.content_move').removeClass('movenow');
	}
	$('#button-menu').click(function(){
		//alert('asas');
		if($('#column-left').hasClass('active')){
		
		$('.content_move').addClass('movenow');
	} else{
		$('.content_move').removeClass('movenow');
	}	
	});
	
	$('#container').css('display', 'table');
	$('#container').css('width', '100%');
});
function change_location(value){
		current_location = window.location.href;
		if(current_location.indexOf("orderby") > 0){
			splitted_location = current_location.split("&orderby=");
			location = splitted_location[0]+ '&orderby=' + value;
		}
		else{
			location = location + '&orderby=' + value;
		}
	}
</script>
<script>
	$(document).ready(function()
	{
		$('select[name=status]').val(<?php echo $status; ?>);
		$('input[name=seller_name]').val("<?php echo $seller; ?>");
		$('select[name=issuetype]').val("<?php echo $issuetype; ?>");
		$('input[name=user_ranking]').val(<?php echo $user_ranking; ?>);
	});
</script>
<script type="text/javascript">
 function isNumber(evt)
 {
   var iKeyCode = (evt.which) ? evt.which : evt.keyCode
   if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
   {
    return false;
  }
  return true;
}
</script>
    <?php echo $footer;  ?>