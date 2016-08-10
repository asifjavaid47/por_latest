<?php echo $header; ?>
<style type="text/css">
    @media(max-width: 767px){
        #loginbox{
            background-color: inherit !important;
            font-size: 14px;
        }
    }
</style>
	<div class="container plm0 prm0" style="padding-top:0px">
	 <div class="row col-sm-4 col-xs-12 product-main-container midbox" style="background-color: white" id="loginbox">
		 <div class="col-sm-12 error-login"></div>
		<div class="col-sm-12 p0" id="quick-login">
			<div class="main-heading col-sm-12">Iniciar Sesión</div>
					 <div class="clr"></div>
					<div class="form-group required">
						<input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control btn-inp-rad" />
					</div>
					<div class="form-group required">
						<input type="password"  name="password" value="" id="input-password"  placeholder="<?php echo $entry_password; ?>" class="form-control pass btn-inp-rad" />
					</div>
					<div class="form-group">
						<button type="button" style="width: 100%;" class="btn btn-primary btn-lg btn-block loginaccount col-sm-12 btn-reg-rad"
								data-loading-text="<?php echo $text_loading; ?>"><?php echo $button_login ?></button>
						<span class="pull-left" style="color:black;"><input type="checkbox"
																			style="    margin-top: 0;vertical-align: middle"/> No cerrar sesión</span>
					<a href="index.php?route=account/forgotten" class="pull-right" style="color:#312783;">
					 <?php echo $forget_password; ?>?</a>
					</div>
					 <div class="clr"></div>

		<div class="" style="color:black;text-align: center;width: 100%;padding-top: 10px;padding-bottom: 10px;"> No estás
			registrado? <a href="<?php echo $base; ?>index.php?route=account/register" style="color:#312783;">Registrate
				aquí.</a></div>
			</div>
		</div>
	</div>


            
 <script type="text/javascript">
 $('#input-password').keypress(function(e) {
        if(e.which == 13) {
           	user_login();
        }
    });

$('#quick-login .loginaccount').click(function() {
	user_login();
 });

     function user_login(){
	
		  $.ajax({
				url: 'index.php?route=account/register/login_login',
				type: 'post',
				data: $('#quick-login input[type=\'text\'], #quick-login input[type=\'password\']'),
				dataType: 'json',
				beforeSend: function() {
					$('#modal-quicksignup .alert-danger').remove();
				},
				complete: function() {
				},
				success: function(json) {
					$('#modal-quicksignup .form-group').removeClass('has-error');
					if(json['islogged']){
						 window.location.href='<?php echo $base;?>';
					}
					if (json['error']) {
						$('.error-login').html('<div class="col-sm-12 alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
						$('#quick-login #input-email').parent().addClass('has-error');
						$('#quick-login #input-password').parent().addClass('has-error');
						$('#quick-login #input-email').focus();
					}
		
					if(json['success']){
						loacation();
						$('#modal-quicksignup').modal('hide');
					}
				}
			});
     }



	user_login_mouse_flag = 0;
	$("#quick-login").mouseenter(function(){
	 user_login_mouse_flag = 1;
		 $(document).keypress(function(e) {
			 if(user_login_mouse_flag == 1){
				if(e.which == 13) {
					user_login();
				}
			 }
		});
	});
	
	
	
	$("#quick-login").mouseleave(function(){
		user_login_mouse_flag = 0;
	});
</script>

<script type="text/javascript">
function loacation() {
	window.location.href='<?php echo $base;?>';//"index.php?route=customuserdetail/editaccount";
}
</script>
<?php echo $footer;?>