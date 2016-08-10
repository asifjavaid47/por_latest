<?php
//echo "<pre>";
//print_r($user_pro_que_ans);
//exit;
 echo $header;
 echo $header1;?>
<style>

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

    .linehclass{
        line-height: 48px;
    }
    .margin_20{
        margin-top: 50px;
    }

    .answer-margin{
        margin-top:19px;
        font-weight: bold;
    }

    .ques-txt-block {
       background: #fce7c2;
        border: 1px solid #ececec;
        border-radius: 20px;
        width: 97%;
        float: left;
        padding: 20px 15px;
        margin: 15px 0;
    }

    .mar27{

        margin-top: 27px;

    }
    
    .top-brdr{
        border-top: 2px solid;
        margin-top: 30px;
        padding-top: 27px;
        border-top-color: #f9b233;
    
    }
</style>

<div class="col-sm-9 midbox">

    <div class="col-sm-9 midbox">

        <div class="col-sm-12">
            <div class="col-sm-6 pull-left"><h2>Answers</h2></div>
            <div class="col-sm-6 text-right mrtop32"><span>Answers of the last 40 days</span></div>

        </div>
        <br />
        <?php
        $aa=0;
		 // echo "<pre>";
      // print_r($user_product);
      // echo '</pre>';
	  //exit;
        if(!empty($user_product))
		{
			for($index=0;$index<sizeof($user_product); $index++)
			{
				if(isset($user_product[$index]['ans_que']))
				{
				$has_unanswered_question = 0;
				 
				$number_of_ans_ques = sizeof($user_product[$index]['ans_que']);
				for($k=0; $k<$number_of_ans_ques ; $k++)
				{
					if(empty($user_product[$index]['ans_que'][$k]['answer']))
					{
						$has_unanswered_question = 1;
					}
				}
				if($has_unanswered_question = 1)
				{
					?>
						<div class="col-sm-12 top-brdr">
							<div class="col-sm-4"><img src="<?php echo	$base.'/image/'.$user_product[$index]['image'];   ?>" height="50px" width="40px" />&nbsp;&nbsp;&nbsp;<?php echo $user_product[$index]['name'];  ?></div>
							<div class="col-sm-3 linehclass">$ &nbsp;<?php echo $user_product[$index]['price']; ?></div>
							<?php 
							if($user_product[$index]['product_stock']=='In Stock'){

							$stock="Avaiable";
							}else{
							$stock="Unavaiable";
							}

							?>

							<div class="col-sm-2 linehclass"><?php $user_product[$index]['product_stock'];  ?> Available</div>
							<div class="col-sm-3 linehclass">Ends In 13 Days</div>	  

						</div>
						<br />
						<div class="question-block">
							<?php
							for($i=0; $i< $number_of_ans_ques; $i++)
                            {   
                                if(empty($user_product[$index]['ans_que'][$i]['answer']))
                                {
                                    ?>
                                    <div class="first-question">
                                        <div class="quew-arrow-block">
                                            <img src="<?php echo $base; ?>image/assets/images/ques-comm-arrow.png" alt="">
                                        </div>
                                        <div id="<?php echo $user_product[$index]['ans_que'][$i]['question_id']; ?>"  class="get_question_id-<?php  echo $user_product[$index]['product_id'];  ?> ques-txt-block">
                                            <?php
                                                echo  $user_product[$index]['ans_que'][$i]['firstname']. " ".$user_product[$index]['ans_que'][$i]['lastname'].":"." ".$user_product[$index]['ans_que'][$i]['question'];
                                            ?>
                                            &nbsp;&nbsp;&nbsp;
                                            <span>
                                                <i class="fa fa-calendar"></i>
                                                <?php  
                                                
                                                
                                                $added_time = new DateTime($user_product[$index]['ans_que'][$i]['date_time']);
                                                $ptime = $added_time->getTimestamp();
                                                $date = new DateTime();
                                                $timestamp_now = $date->getTimestamp();
                                                $etime = $timestamp_now - $ptime;
                                                if($etime >= 0 and $etime <= 60)
                                                {
                                                    $message = $etime. 'seconds ago';
                                                }
                                                else if($etime > 60 and $etime <= 3600)
                                                {
                                                    $message = round(($etime/60)). 'minutes ago';
                                                }
                                                else if($etime > 3600 and $etime <= 86400)
                                                {
                                                    $message = round(($etime/3600)). 'hours ago';
                                                }
                                                else if($etime > 86400)
                                                {
                                                    $message = round(($etime/(3600*24))). 'Days ago';
                                                }
                                                
                                                  echo $message;
                                                ?>
                                                
                                            </span>
                                           <!-- <span style="float:right;">
                                                <?php echo $user_product[$index]['ans_que'][$i]['firstname']. " ".$user_product[$index]['ans_que'][$i]['lastname'];?>
                                            </span>-->
                                        </div>
                                         
                                    </div>
                                    <form action="<?php echo $addanswerAction;?>" id="form_submit-<?php echo $user_product[$index]['ans_que'][$i]['question_id']; ?>" name="" method="POST">
				<div class="col-sm-12 margin_20">
		
			<div class="col-sm-9">
				<textarea name="answer"  class="ask-que-area" required placeholder="May I pay cash" required></textarea>
			</div>
			<input type="hidden" name="product_id" value="<?php echo $user_product[$index]['product_id']; ?>">
			<input type="hidden" name="customer_id" value="<?php echo $user_product[$index]['ans_que'][$i]['customer_id']; ?>">
			<input type="hidden" name="que_of_ans_id" id="que_of_ans_id-<?php echo $user_product[$index]['ans_que'][$i]['question_id']; ?>" value="">
                        <input type="hidden" name="page_uri" value="<?php echo urlencode($_SERVER['REQUEST_URI']);?>">
			<div class="col-sm-3">		
				<button type="button" data-id="<?php echo $user_product[$index]['ans_que'][$i]['question_id']; ?>" class="btn btn-default ans_form">Reply</button>
			
			</div>
		</div>
		</form>
                                    
                          <span style="float:right; cursor:pointer;" class="delete_question" id="del_question-<?php echo $user_product[$index]['ans_que'][$i]['question_id']; ?>">Delete question</span>          
                                    <?php
                                }
                                
                                // show answers 
                               // else if(isset($user_product['ans_que'][$i]['answer']))
                                //{
                                    ?>
                                    <!--<div class="first-question">
                                        <div class="ques-txt-block-white">
                                                <?php
                                                    echo $user_product[$index]['ans_que'][$i]['answer'];
                                                ?>
                                                &nbsp;&nbsp;&nbsp;
                                                <span>
                                                    <i class="fa fa-calendar"></i>
                                                    <?php
                                                    ?>
                                                   
                                                    <?php echo $message;?>
                                                </span>
                                                <span style="float:right;">
                                                    <?php echo $user_product[$index]['ans_que'][$i]['a_role'];?>
                                                </span>
                                        </div>
                                       
                                        <div class="quew-arrow-block-white">
                                            <img src="<?php echo $base; ?>image/assets/images/white-msg-block.png" alt="">
                                        </div>
                                    </div>-->
                                    <?php
                               // }
                            }
                           
                       
                    ?>
                    
                </div>
				
        <?php 
					
				
				}
		}
		 }
		 
        }
        ?>
		
    </div>
    <script>
    $(document).ready(function(){
    $(".delete_question").click(function(){
        var qusetion_id=$(this).attr("id");
        qusetion_id=qusetion_id.split("-");
       del_question_id=qusetion_id[1];
        $.ajax({
         type:"POST",
         url:"index.php?route=dashboard/answer/delete_question",
         data:{del_question_id:del_question_id},
         success:function(data){
             
             if(data=='sussess'){
           location.reload();
       }
     } 
        
        });
     });
     
     //for submit ans
     $(".ans_form").click(function(){
     var question_id=$(this).attr("data-id");
     $("#que_of_ans_id-"+question_id).val(question_id);
        $("#form_submit-"+question_id).submit();
    });
     
     
  });
        
    </script>
    
    
    <!-- /.container -->
    <?php  echo $footer;  ?>


