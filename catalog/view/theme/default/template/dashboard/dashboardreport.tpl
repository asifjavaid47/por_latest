<?php 
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
		<div class="col-sm-12 pull-left"><h2>Report Dashboard</h2></div>

	  </div>

	   <div class="col-sm-12">
	  <div class="col-sm-6">
	  <?php
				if($reported_products['type_of_issue']==1){
					echo"<p><b>Report Type:&nbsp;It has contact detail</b></p>";
				}
				
				if($reported_products['type_of_issue']==2){
				echo"<p><b>Report Type:&nbsp;Post a lower then accuitly paid</b></p>";
			}
				if($reported_products['type_of_issue']==3){
				echo"<p><b>Report Type:&nbsp;It is evident that sells a copy or forgery</b></p>";
				
				}
				if($reported_products['type_of_issue']==4){
				
				echo"<p><b>Report Type:&nbsp;Sells a product that dose not meet the term and condition of the site</b></p>";
				}
				if($reported_products['type_of_issue']==5){
				echo"<p><b>Report Type:&nbsp;Others</b></p>";
				}
				?>
	  		 <div class="col-sm-2"><img src="image/<?php echo $reported_products['image']; ?>" height="84px" width="61px"></div>
	  		 <div class="col-sm-10">
	  		 		<p><?php echo $reported_products['name']; ?></p>
	  		 		<p><?php echo $reported_products['comments']; ?></p>
	  		 		<p>$ <?php echo $reported_products['price']; ?> x 1 Unit</p>

	  		 </div>	
	  	</div>
		
		 <div class="col-sm-6 text-right">
	  		
			<span>Date</span><br />	
			<span><?php  echo date(' j /m /Y ',strtotime($reported_products['date_time']));   ?></span>
			 
	  	</div>
	  </div>
	  <div class="col-sm-12">
	  <div class="col-sm-9">
		<br /><label><b>User</b></label><br />
		<br /><label><?php  echo $reported_address['v_name'];  ?></label><br />
		<label><?php echo $reported_address['v_email'];  ?></label><br />
		<!--<label><?php //echo $reported_address['v_phone']; ?></label><br /> -->
		<p><?php echo $reported_address['address']; ?></p><br />
		
                <div class="question-block">
                    <?php
                        for($i=0; $i< sizeof($que_ans_results); $i++)
                        {
                            if(isset($que_ans_results[$i]['question']))
                            {
                             if($que_ans_results[$i]['to_show']==1)
                                {
                                ?>
                                <div class="first-question">
                                    <div class="quew-arrow-block">
                                        <img src="<?php echo $base; ?>image/assets/images/ques-comm-arrow.png" alt="">
                                    </div>
                                    <div id="<?php echo $que_ans_results[$i]['question_id']; ?>" class="get_question_id ques-txt-block" data-role='buyer'>
                                        <?php
                                            echo $que_ans_results[$i]['question'];
                                        ?>
                                        &nbsp;&nbsp;&nbsp;
                                        <span>
                                            <i class="fa fa-calendar"></i>
                                            <?php echo $que_ans_results[$i]['date_time'];?>
                                        </span>
                                        <span style="float:right;">
                                            <?php echo $que_ans_results[$i]['q_role'];?>
                                        </span>
                                    </div>
                                </div>
                                <?php
                             }
                            }
                            else if(isset($que_ans_results[$i]['answer']))
                            {
                            if($que_ans_results[$i]['a_role']=='admin'){
                                ?>
                                <div class="first-question">
                                    <div class="ques-txt-block-white get_question_id" data-role='admin'>
                                            <?php
                                                echo $que_ans_results[$i]['answer'];
                                            ?>
                                            &nbsp;&nbsp;&nbsp;
                                            <span>
                                                <i class="fa fa-calendar"></i>
                                                <?php echo $que_ans_results[$i]['date_time'];?>
                                            </span>
                                            <span style="float:right;">
                                                <?php echo $que_ans_results[$i]['a_role'];?>
                                            </span>
                                    </div>
                                    <div class="quew-arrow-block-white">
                                        <img src="<?php echo $base; ?>image/assets/images/white-msg-block.png" alt="">
                                    </div>
                                </div>
                                <?php
                                }else{
                                ?>
                                <div class="first-question">
                                    <div class="ques-txt-block-white">
                                            <?php
                                                echo $que_ans_results[$i]['answer'];
                                            ?>
                                            &nbsp;&nbsp;&nbsp;
                                            <span>
                                                <i class="fa fa-calendar"></i>
                                                <?php echo $que_ans_results[$i]['date_time'];?>
                                            </span>
                                            <span style="float:right;">
                                                <?php echo $que_ans_results[$i]['a_role'];?>
                                            </span>
                                    </div>
                                    <div class="quew-arrow-block-white">
                                        <img src="<?php echo $base; ?>image/assets/images/white-msg-block.png" alt="">
                                    </div>
                                </div>
                                <?php 
                                }
                            }
                        }
                    ?>      
                </div>
		
                <br>
		
		<form action="<?php echo $addQuesAction;?>" name="question_answer_form" id="question_answer_form" method="POST">
                    <div class="col-sm-12 margin_20">
                        <div class="col-sm-9">
                            <textarea name="commentbox" class="ask-que-area" id="commentbox"></textarea>
                            <div class="col-sm-9 alert alert-warning" id="warn_message" style="display:none;"> 
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <strong>Please fill out this field</strong>
                            </div>
			</div>  
                        <input type="hidden" name="question_id_submit" id='question_id_submit' value="" />
                        <input type="hidden" name="report_id" id='report_id' value="<?php if(isset($_GET['rpt'])) echo $_GET['rpt'];?>" />
                        <input type="hidden" name="is_admin" id='is_admin' value="" />
                        <input type="hidden" name="seller_customer_id" id='seller_customer_id' value="" />
                        <input type="hidden" name="current_product_vendor" id='current_product_vendor' value="" />
                        <input type="hidden" name="login_vendor" id='login_vendor' value="" />
			<input type="hidden" name="product_id" value="<?php if(isset($_GET['xds'])) echo $_GET['xds'];?>" />
                        <input type="hidden" name="page_uri" value="<?php echo urlencode($_SERVER['REQUEST_URI']);?>" />
                        <input type="hidden" name="buyer_id" id="buyer_id" value="" />
			<div class="col-sm-3">		
                            <button type="button" class="btn btn-default" id="ask_question">Ask</button>
			</div>
                    </div>
		</form>
	  </div>
	  </div>
	  </div>

    </div>
	<script>
$('.reply_form').hide();
var reply_id = '';
	$(".reply-link").click(function()
	{
		$('.reply_form').hide();
		reply_id = $(this).attr("id");
		$("#reply_"+reply_id).show();
	});
	$("#block_user").click(function(){
	var product_id=$("input[name=product_id]").val();
	$.ajax({
	type:"POST",
	url:"index.php?route=dashboard/dashboardreport/block_user",
	data:{product_id:product_id},
	success:function(){
	$("#success_message").show();
	
	}
	});
	});
	$("#cancel_product").click(function(){
		var product_id=$("input[name=product_id]").val();
		$.ajax({
		type:"POST",
		url:"index.php?route=dashboard/dashboardreport/block_products",
		data:{product_id:product_id},
		success:function(){
		}
		});
		});
	$(".res-find-what").click(function()
	{
		$(".show-in-mobile").slideToggle("slow");
	});
	//$('.bxslider').bxSlider();
	$('.bxslider').bxSlider(
	{
		nextText: "",
		prevText: ""
	});
   $('#product-discription').easyResponsiveTabs(
   {
	   type: 'default', //Types: default, vertical, accordion           
	   width: 'auto', //auto or any width like 600px
	   fit: true,   // 100% fit in a container
	   closed: 'accordion', // Start closed if in accordion view
	   activate: function(event)
	   { // Callback function if tab is switched
			var $tab = $(this);
			var $info = $('#tabInfo');
			var $name = $('span', $info);
			$name.text($tab.text());
			$info.show();
	   }
	});
	$('#verticalTab').easyResponsiveTabs(
	{
		type: 'vertical',
		width: 'auto',
		fit: true
	});
</script>

<script type="text/javascript">
$(document).ready(function(){
    
var is_admin;	// to show or hide reply link
	$("#ask_question").click(function()
        {
             question_elements = $('.get_question_id');
         if (question_elements.length === 0)
            {
                is_admin='no';
                question_id = 'notset';
            }
            else  if($(".get_question_id").last().attr("data-role")=='admin')
            {
             is_admin='yes';   
             
                question_id = question_elements[0].id;
            } 
            else{
                is_admin='no';
                question_id = question_elements[0].id;
                
            }
            $('#question_id_submit').val(question_id);
            $('#current_product_vendor').val(<?php echo $reported_products['seller_id']; ?>);
            $('#login_vendor').val(<?php echo $check_vendor_id->row['id'];?>);
            $('#is_admin').val(is_admin);
            $("#seller_customer_id").val(<?php echo $reported_address['customer_id']; ?>);
            $("#buyer_id").val(<?php echo $buyer_id; ?>);
            if($("#commentbox").val().length>0)
            {
                $('#question_answer_form').submit();
            }
            if($("#commentbox").val().length==0)
            {		
                $("#warn_message").show();
            }
	});
	
	
	
	
	var check_vendor_idsss = <?php echo isset($check_vendor_id->row['id'])?$check_vendor_id->row['id']:'09898676576'; ?>;
	if(parseInt(<?php echo $reported_products['seller_id']; ?>) == check_vendor_idsss)
	{	
		$('.reply-link').show();
		$('.question-hide-own-seller').hide();
                $("#report_product").hide();
	}
	else
	{
		$('.reply-link').hide();
		$('.question-hide-own-seller').show();
	}
});


</script>
    <?php echo $footer;  ?>