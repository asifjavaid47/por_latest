<?php echo $header; ?>




<div class="container" style="padding-top: 10px;">
  <?php if ($error_warning) { ?>

  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>

  <?php } ?>

  <?php if(isset($_SESSION['default']['success']))

            {   ?>

                <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i>

                    <?php

                        echo $_SESSION['default']['success'];

                        unset($_SESSION['default']['success']);

                    ?>

                </div>

                <?php

            } ?>

  <div class="row">

  

	<div id="content" class="col-sm-8 col-sm-offset-2 ">

		<div class="common-content edit_account row">

		

		  <h1 class="section-heading"><?php echo $heading_title; ?></h1>

		  <p style="padding-left: 15px;"><?php echo $text_email; ?></p>

		  <div class="details col-md-9">

		  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">

			<fieldset>

			  <h2><?php echo $text_your_email; ?></h2>

			  <div class="form-group required">

				<label class="col-sm-3 control-label" for="input-email"></label>

				<div class="col-sm-9">

				  <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />

				</div>

			  </div>

			</fieldset>

			<div class="buttons clearfix">

			  <div >

			  

				<input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary continu pull-right" />

			  

			  </div>

			</div>
			

		  </form>

		 

		  </div>

		  

		 </div>

	 </div>


	  

	<div class="col-md-2"> &nbsp;</div>  

	  

   </div>

</div>
</div>
<?php echo $footer; ?>