<?php
 // echo "<pre>";
// print_r($user_pro_que_ans);
// echo "</pre>";
// exit;
 echo $header;
 echo $header1;
?>


<style>

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
            <div class="col-sm-6 pull-left"><h2>Preguntas</h2></div>
            <div class="col-sm-6 text-right mrtop32"><span>Preguntas de los últimos 40 dias</span></div>

        </div>
        <br />

        <?php
        $aa=0;
		 // echo "<pre>";
      // print_r($user_pro_que_ans);
	  // exit;
        if(!empty($user_pro_que_ans)){
			$i=0;
        for($index = 0 ; $index < sizeof($user_pro_que_ans); $index++)
        {
			if(isset($user_pro_que_ans[$index]['ans_que']['questions']))
			{
            ?>
            <div class="col-sm-12 top-brdr">
                <div class="col-sm-4"><img src="<?php echo $base.'/image/'.$user_pro_que_ans[$index]['image'];   ?>" height="50px" width="40px" />&nbsp;&nbsp;&nbsp;<?php echo $user_pro_que_ans[$index]['name'];  ?></div>
                <div class="col-sm-3 linehclass">$ &nbsp;<?php echo $user_pro_que_ans[$index]['price']; ?></div>
            <?php 
            if($user_pro_que_ans[$index]['product_stock']=='In Stock'){
            
            $stock="Avaiable";
            }else{
            $stock="Unavaiable";
            }
            
            ?>
            
            
            
            <div class="col-sm-2 linehclass"><?php $user_pro_que_ans[$index]['product_stock'];  ?> Disponible</div>
            <div class="col-sm-3 linehclass">Termina en 13 Dias</div>

        </div>

        <br />
      <div class="question-block">
                    <?php
                        
                        // if(isset($user_pro_que_ans[$index]['ans_que']))
                        // {
							
                            for($i=0; $i< sizeof($user_pro_que_ans[$index]['ans_que']['questions']); $i++)
                            {
                                // if(isset($user_product['ans_que'][$i]['question']))
                                // {
                                    ?>
                                    <div class="first-question">
                                        <div class="quew-arrow-block">
                                            <img src="<?php echo $base; ?>image/assets/images/ques-comm-arrow.png" alt="">
                                        </div>
                                        <div id="<?php echo $user_pro_que_ans[$index]['ans_que']['questions'][$i]['question_id']; ?>" class="get_question_id ques-txt-block">
                                            <?php
												echo $user_pro_que_ans[$index]['ans_que']['questions'][$i]['firstname'].' '.$user_pro_que_ans[$index]['ans_que']['questions'][$i]['lastname'].' : ';
                                                echo $user_pro_que_ans[$index]['ans_que']['questions'][$i]['question'];
                                            ?>
                                            &nbsp;&nbsp;&nbsp;
                                            <span>
                                                <i class="fa fa-calendar"></i>
                                                <?php  
                                                
                                                
                                                $added_time = new DateTime($user_pro_que_ans[$index]['ans_que']['questions'][$i]['date_time']);
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
                                            <span style="float:right;">
                                                <?php echo $user_pro_que_ans[$index]['ans_que']['questions'][$i]['q_role'];?>
                                            </span>
                                        </div>
                                    </div>
                                    <?php
                                //}
									for($j=0; $j< sizeof($user_pro_que_ans[$index]['ans_que']['answers'][$i]); $j++)
									{
										// if(isset($user_pro_que_ans[$index]['ans_que']['answers'][$i][$j]))
										// {
                                    ?>
                                    <div class="first-question">
                                        <div class="ques-txt-block-white">
                                                <?php
													echo $user_pro_que_ans[$index]['seller_name'].' : ';
                                                    echo $user_pro_que_ans[$index]['ans_que']['answers'][$i][$j]['answer'];
                                                ?>
                                                &nbsp;&nbsp;&nbsp;
                                                <span>
                                                    <i class="fa fa-calendar"></i>
                                                    <?php 
                                                    
                                                    
                                                    $added_time = new DateTime($user_pro_que_ans[$index]['ans_que']['answers'][$i][$j]['date_time']);
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
                                                    //exit;
                                                    
                                                    ?>
                                                    
                                                    
                                                    
                                                    
                                                    
                                                </span>
                                                <span style="float:right;">
                                                    <?php //echo $user_pro_que_ans[$index]['ans_que']['answers'][$i][$j]['a_role'];?>
                                                </span>
                                        </div>
                                        <div class="quew-arrow-block-white">
                                            <img src="<?php echo $base; ?>image/assets/images/white-msg-block.png" alt="">
                                        </div>
                                    </div>
                                    <?php
                                //}
							}
                            }
                        //}
                    ?>
                </div>
				<form action="<?php echo $addQuesAction;?>" name="" method="POST">
				<div class="col-sm-12 margin_20">
		
			<div class="col-sm-9">
				<textarea name="question"  class="ask-que-area" required placeholder="May I pay cash" required></textarea>
			</div>
			<input type="hidden" name="product_id" value="<?php echo $user_pro_que_ans[$index]['product_id']; ?>">
            <input type="hidden" name="page_uri" value="<?php echo urlencode($_SERVER['REQUEST_URI']);?>">
			<div class="col-sm-3">		
				<button type="submit" class="btn btn-default">Ask</button>
			
			</div>
		</div>
		</form>
        <?php 
		}
		}
        }
        ?>
		
    </div>
    <!-- /.container -->
    <?php  echo $footer;  ?>


