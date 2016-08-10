<?php echo $header; ?>


    <!--modal-box Name start-->
<div class="modal_box22 modal_name">
    <div class="modall_content11 text-center" style="max-width: 400px;">
        <a href="javascript:void(0);" class="close_11" id="modal_name_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar nombre
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="name" class="form-control name-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;    margin-top: 15px;">
                <button class="btn btn-primary name_save">Guardar</button>
                <button class="khali_11" id="modal_name_close">cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box name end-->

    <!--modal-box Sure Name start-->
<div class="modal_box22 modal_surename">
    <div class="modall_content11 text-center" style="max-width: 400px;">
        <a href="javascript:void(0);" class="close_11" id="modal_surename_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Apellido
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="surename" class="form-control surename-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;    margin-top: 15px;">
                <button class="btn btn-primary surename_save">Guardar</button>
                <button class="khali_11" id="modal_surename_close">cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box Sure name end-->


    <!--modal-box---------->
<div class="modal_box22 modal_email">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="close_11"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Email
        </h2>
        <div class="row">
            <label for="" class="col-md-3 text-right">Nuevo Email:</label>

            <div class="col-md-9">
                <input type="text" name="email" class="form-control email-val">
            </div>
        </div>
        <div class="row">
            <label class="col-md-3 text-right">
                Repetir nuevo Email:
            </label>

            <div class="col-md-9">
                <input type="text" name="repeat_newemail" class="form-control repeat-email-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center">
                <button class="btn btn-primary email_save">Guardar</button>
                <button class="khali_11" id="close_11">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box---------->

    <!--modal-box Phone start-->
<div class="modal_box22 modal_phone">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_phone_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Teléfono
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="phone" class="form-control phone-val edit-phone-only">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary save_phone">Guardar</button>
                <button class="khali_11" id="modal_phone_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box Phone end-->

    <!--modal-box Tax ID start-->
<div class="modal_box22 modal_taxid">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_taxid_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Cuil/Cuit
		</h2>
        <span id='error_message_tax_id_update' style='display:none;' class='alert alert-danger'></span>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="taxid" class="form-control taxid-val" id="taxid_mask">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary save_txid">Guardar</button>
                <button class="khali_11" id="modal_taxid_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box Tax ID end-->

    <!--modal-box Contact name start-->
<div class="modal_box22 modal_contactname">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_contactname_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Nombre de Contacto
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="contactname" class="form-control contactname-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary save_contactname">Guardar</button>
                <button class="khali_11" id="modal_contactname_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box Contact name end-->

    <!--modal-box Contact phone start-->
<div class="modal_box22 modal_contactphone">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_contactphone_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Teléfono de Contacto
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="contactphone" class="form-control contactphone-val edit-contact-phone-only">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary contact_phone">Guardar</button>
                <button class="khali_11" id="modal_contactphone_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box  Contact phone end-->


    <!--modal-box  Contact email start-->
<div class="modal_box22 modal_contactemail">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_contactemail_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Email de Contacto
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="contactemail" class="form-control contactemail-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary save_contactemail">Guardar</button>
                <button class="khali_11" id="modal_contactemail_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box  Contact email end-->


    <!--modal-box  Company Name start-->
<div class="modal_box22 modal_companyname">
    <div class="modall_content11 text-center" style="max-width: 400px;    margin-top: 15px;">
        <a href="javascript:void(0);" class="close_11" id="modal_companyname_close"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Nombre de Compania
        </h2>
        <div class="row">
            <div class="col-md-12">
                <input type="text" name="companyname" class="form-control companyname-val">
            </div>
        </div>
        <div class="row text-left">
            <div class="col-md-12" style="text-align: center;">
                <button class="btn btn-primary save_companyname">Guardar</button>
                <button class="khali_11" id="modal_companyname_close">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<!--modal-box Company Name  end-->


    <div class="container" style="padding-top: 10px;">
        <div class="row">
            <div id="content" class="col-sm-8 col-sm-offset-2 ">
                <div class="common-content edit_account" style="    padding-left: 30px;    padding-bottom: 50px;">
			    <div  class="main-heading" style="text-align:center"  >Editar Cuenta</div>
                    <div style="padding-left: 15%">
					<div class="row" style="margin-top:10px;">
                        <div class="createlst-tittle">Detalles de Usuario</div>
					</div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 "> Nombre :</div>
						<span class="nameupdate text-update"><?php echo isset($get_basic_detail->row['firstname'])?$get_basic_detail->row['firstname']:''; ?> </span><a class="modify_name" href="javascript:void(0);"> Modificar</a>
					</div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Apellido :</div>
						<span class="updatesurename text-update"><?php echo isset($get_basic_detail->row['lastname'])?$get_basic_detail->row['lastname']:''; ?></span> <a class="modify_surename" href="javascript:void(0);"> Modificar</a>
                    </div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Email :</div>
                        <span class="updateemail text-update"><?php echo isset($get_basic_detail->row['email'])?$get_basic_detail->row['email']:''; ?></span><a href="javascript:void(0);" class="Edit_email11"> Modificar</a>
					 </div>
					 <div class="row" style="margin-top:10px;">
                         <div class="col-sm-3 ">Contraseña :</div>
                        <span class="updateemail text-update">**********</span><a id="sell" href="<?php echo $base;?>index.php?route=customuserdetail/resetpwd"> Modificar</a>
					 </div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 "> Teléfono :</div>
						<span class="updatephone text-update"><?php echo isset($get_basic_detail->row['fax'])?$get_basic_detail->row['fax']:''; ?></span><a class="modify_phone"href="javascript:void(0);"> Modificar</a>
					</div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Cuil/Cuit:</div>
                        <span class="updatetax text-update"><?php echo isset($get_tax_id->row['lc_tax_id'])?$get_tax_id->row['lc_tax_id']:''?></span> <a class="modify_taxid" href="javascript:void(0);"> Modificar</a>
                    </div> 
					<div class="row" style="margin-top:10px;">
                        <div class="createlst-tittle">Detalles de Contacto</div>
					</div>
					<div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Contacto:</div>
                        <span class="updatecontactname text-update"><?php echo isset($get_contact_detail->row['v_name'])?$get_contact_detail->row['v_name']:''; ?> </span><a class="modify_contactname" href="javascript:void(0);"> Modificar</a>
                    </div>
                    <div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Teléfono de Contacto:</div>
						<span class="updatecontactphone text-update"><?php echo isset($get_contact_detail->row['v_phone'])?$get_contact_detail->row['v_phone']:''?> </span> <a class="modify_contactphone" href="javascript:void(0);"> Modificar</a>
                    </div>
                    <div class="row" style="margin-top:10px;">
                        <div class="col-sm-3 ">Email de Contacto:</div>
						<span class="updatecontactemail text-update"><?php echo isset($get_contact_detail->row['v_email'])?$get_contact_detail->row['v_email']:''; ?></span> <a class="modify_contactemail" href="javascript:void(0);"> Modificar</a>
                     </div>
                        <div class="row" style="margin-top:10px;">
                            <div class="col-sm-3 ">Mis direcciones :</div>
                    <a id="sell" href="<?php echo $base;?>index.php?route=customuserdetail/addressbook"> Administrar Direcciones</a>
                        </div>
                        <div style="display: none;">
                    <div class="row" style="margin-top:10px;">
						<div class="createlst-tittle" style="padding-left:25px">Detalles de Empresa</div>
					</div>
					<div class="row" style="margin-top:10px;">	
						<div class="col-sm-3 right-align">Nombre de Empresa:</div>
                    	<span class="updatecompanyname text-update"><?php echo isset($get_company_detail->row['company_name'])?$get_company_detail->row['company_name']:'';?></span> <a class="modify_companyname" href="javascript:void(0);"> Modificar</a>
                    </div>     
                    <div class="row" style="margin-top:10px;">	
                    <div class="col-sm-3 right-align">Logo:</div>
					<div class="col-sm-6">
					<div class="row">
						<div class="input-group">
							<input type="text" class="form-control clogovl" value="<?php echo isset($get_company_detail->row['company_logo'])?$get_company_detail->row['company_logo']:''; ?>" placeholder="Company Logo">
								<span class="input-group-btn">
									<span class="btn btn-secondary input_btn22 " type="button">Subir                                      
										<form id='image_upload_form' enctype="multipart/form-data">
									</span>
									<input type="file" name="company_logo" accept="img/*" value="" class="clogo updatelogoimg">  
										</form>
                                                
                                </span>
                        </div>
						
					</div>
					
						<div class="row">
							<div class="img-holder" >
								<img class="displaylogo" src="<?php echo $base;?>image/companylogo/<?php echo isset($get_company_detail->row['company_logo'])?$get_company_detail->row['company_logo']:'no_image.png'; ?>" alt="">
							</div>
						</div>
						</div>
					</div>
						
					<div class="row" style="margin-top:10px;">	
						<div class="col-sm-3 right-align">Banner:</div>
                            <div class="col-sm-6">
								<div class="row">
									<div class="input-group">
                                        <input type="text" class="form-control clogovl logoval"  value="<?php echo isset($get_company_detail->row['company_banner'])?$get_company_detail->row['company_banner']:''?>"placeholder="Company Banner">
                                            <span class="input-group-btn">
												<span class="btn btn-secondary input_btn22 " type="button">Subir 
                                                
                                                    <form id='image_upload_form1' enctype="multipart/form-data">
                                                <input type="file" name="company_banner" accept="img/*" value="" class="clogo combanner">  </span>
                                                    </form>

                                            </span>
                                    </div>
								</div>
								<div class="row">
									<div class="banner-holder ">
										<img class="displaybanner" src="<?php echo $base;?>image/companybanner/<?php echo isset($get_company_detail->row['company_banner'])?$get_company_detail->row['company_banner']:'no_image.png'; ?>" alt="">
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

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<!--modal -js-->
<script type="">
$(document).ready(function(){

    $("body").on("click",".Edit_email11",function(){
        $(".modal_email").fadeIn(500);
    });

    $("body").on("click","#close_11",function(){
        $(".modal_email").fadeOut(500);
    });




    $("body").on("click",".modify_name",function(){
        $(".modal_name").fadeIn(500);
    });

    $("body").on("click","#modal_name_close",function(){
        $(".modal_name").fadeOut(500);
    });



    $("body").on("click",".modify_surename",function(){
        $(".modal_surename").fadeIn(500);
    });

    $("body").on("click","#modal_surename_close",function(){
        $(".modal_surename").fadeOut(500);
    });


    $("body").on("click",".modify_phone",function(){
        $(".modal_phone").fadeIn(500);
    });

    $("body").on("click","#modal_phone_close",function(){
        $(".modal_phone").fadeOut(500);
    });


    $("body").on("click",".modify_taxid",function(){
		$('#error_message_tax_id_update').css('display', 'none');
        $(".modal_taxid").fadeIn(500);
    });

    $("body").on("click","#modal_taxid_close",function(){
        $(".modal_taxid").fadeOut(500);
    });




    $("body").on("click",".modify_contactname",function(){
        $(".modal_contactname").fadeIn(500);
    });

    $("body").on("click","#modal_contactname_close",function(){
        $(".modal_contactname").fadeOut(500);
    });



    $("body").on("click",".modify_contactphone",function(){
        $(".modal_contactphone").fadeIn(500);
    });

    $("body").on("click","#modal_contactphone_close",function(){
        $(".modal_contactphone").fadeOut(500);
    });




    $("body").on("click",".modify_contactemail",function(){
        $(".modal_contactemail").fadeIn(500);
    });

    $("body").on("click","#modal_contactemail_close",function(){
        $(".modal_contactemail").fadeOut(500);
    });






    $("body").on("click",".modify_companyname",function(){
        $(".modal_companyname").fadeIn(500);
    });

    $("body").on("click","#modal_companyname_close",function(){
        $(".modal_companyname").fadeOut(500);
    });







});
</script>

<!--modal -js-->


<script type="text/javascript"><!--
$('.name_save').click(function() {
	
	var form_error = false;
	
	var nameval = $('.name-val').val();
	if(nameval == ''){	
		$('.name-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.name-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_name',
		type: 'post',
		data: {"name":nameval},
		dataType: 'text',
		success: function(response) {
			$('.nameupdate').text(nameval);
			 window.location.href="index.php?route=customuserdetail/editaccount";
			
		}
	});
	
	
	
 });


$('.surename_save').click(function() {
	
	var form_error = false;
	
	var surenameval = $('.surename-val').val();
	if(surenameval == ''){	
		$('.surename-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.surename-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_surename',
		type: 'post',
		data: {"surename":surenameval},
		dataType: 'text',
		success: function(response) {
			$('.updatesurename').text(surenameval);
			 window.location.href="index.php?route=customuserdetail/editaccount";
			
		}
	});

});




$('.email_save').click(function() {
	
	var form_error = false;
	
	var emailval = $('.email-val').val();
	if(emailval == ''){	
		$('.email-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}
	
	var emailrept = $('.repeat-email-val').val();
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_newemail',
		type: 'post',
		data: {"email":emailval,"repeat_newemail":emailrept},
		dataType: 'text',
		success: function(response) {
			if(response == 'Not Valid'){
				$('.email-val').css('border','1px solid red');
				alert("Please enter valid email");
			}else if(response == 'already available'){
				$('.email-val').css('border','1px solid red');
			    alert("already available");
			}else if(response == 'required'){
				alert("Please repeat new email");
			}else if(response == 'not match'){
				
				$('.repeat-email-val').css('border','1px solid red');
				alert("both email should match");
			}else{
				$('.email-val').css('border','1px solid green');
				$('.repeat-email-val').css('border','1px solid green');
				$('.updateemail').text(emailval);
				 window.location.href="index.php?route=customuserdetail/editaccount";
			}
		}
	});

});





$('.save_phone').click(function() {
	
	var form_error = false;
	
	var phoneval = $('.phone-val').val();
	if(phoneval == ''){	
		$('.phone-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.phone-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/update_phone',
		type: 'post',
		data: {"phone":phoneval},
		dataType: 'text',
		success: function(response) {
			$('.updatephone').text(phoneval);
			
			 window.location.href="index.php?route=customuserdetail/editaccount";
		}
	});

});

$('.save_txid').click(function()
{
	$('#error_message_tax_id_update').css('display', 'none');
	var form_error = false;
	
	var taxval = $('.taxid-val').val();
	if(taxval == '')
	{	
		$('.taxid-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}
	else
	{
		$('.taxid-val').css('border','1px solid green');
	}
		
	$.ajax(
	{
		url: 'index.php?route=customuserdetail/editaccount/update_taxid',
		type: 'post',
		data: {"taxid":taxval},
		dataType: 'text',
		success: function(response)
		{
			if(response == '0')
			{
				$('#error_message_tax_id_update').text('Tax ID is not valid!');
				$('#error_message_tax_id_update').css('display', 'block');
				$('.taxid-val').css('border','1px solid red');
			}
			else if(response == '1')
			{
				$('.taxid-val').css('border','1px solid green');
				$('.updatetax').text(taxval);
			    window.location.href="index.php?route=customuserdetail/editaccount";
			}
			
			else if(response == '2')
			{
				$('#error_message_tax_id_update').text('This Tax ID already exist. Use an other one.');
				$('#error_message_tax_id_update').css('display', 'block');
				$('.taxid-val').css('border','1px solid red');
			}
		}
	});

});







$('.save_contactname').click(function() {
	
	var form_error = false;
	
	var contactname = $('.contactname-val').val();
	if(contactname == ''){	
		$('.contactname-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.contactname-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_contact_name',
		type: 'post',
		data: {"contactname":contactname},
		dataType: 'text',
		success: function(response) {
			$('.updatecontactname').text(contactname);
			 window.location.href="index.php?route=customuserdetail/editaccount";
			 
		}
	});

});



$('.contact_phone').click(function() {
	
	var form_error = false;
	
	var contactphone = $('.contactphone-val').val();
	if(contactphone == ''){	
		$('.contactphone-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.contactphone-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_contact_phone',
		type: 'post',
		data: {"contactphone":contactphone},
		dataType: 'text',
		success: function(response) {
			$('.updatecontactphone').text(contactphone);
			 window.location.href="index.php?route=customuserdetail/editaccount";
			
		}
	});

});




$('.save_contactemail').click(function() {
	
	var form_error = false;
	
	var contactemail = $('.contactemail-val').val();
	if(contactemail == ''){	
		$('.contactemail-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.contactemail-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_contact_email',
		type: 'post',
		data: {"contactemail":contactemail},
		dataType: 'text',
		success: function(response) {
			if(response == 'Not Valid'){
				$('.contactemail-val').css('border','1px solid red');
				alert("Please enter valid email");
			}else{
				$('.contactemail-val').css('border','1px solid green');
				$('.updatecontactemail').text(contactemail);
				 window.location.href="index.php?route=customuserdetail/editaccount";
			}
		}
	});

});


      $("body").keydown(function(e){

               var hell=e.keyCode;
               if( hell == 27 ){
                   $(".modal_box22").fadeOut(500);
               }
            });

      $('.modal_box22').click(function(evt){

            if($(evt.target).closest('.modall_content11').length)
                return;
            $('.modal_box22').fadeOut(500);
        });





$('.save_companyname').click(function() {
	
	var form_error = false;
	
	var companyname = $('.companyname-val').val();
	if(companyname == ''){	
		$('.companyname-val').css('border','1px solid red');
		form_error =  true;
		return false;
	}else{
		$('.companyname-val').css('border','1px solid green');
	}
		
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/save_company_name',
		type: 'post',
		data: {"companyname":companyname},
		dataType: 'text',
		success: function(response) {
			$('.updatecompanyname').text(companyname);
			window.location.href="index.php?route=customuserdetail/editaccount";
			
		}
	});

});

    $('.updatelogoimg').change( function(){
		
		
		var formData = new FormData(jQuery('#image_upload_form')[0]);
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/updatelogo',
		type: 'post',
		data: formData,
		//dataType: 'formData,',
		success: function(data) {
		
		var json = JSON.parse(data);
        var logoss11 = $('.displaylogo').attr("src","<?php echo $base;?>image/companylogo/"+json['encryptedname']+"");
			$('.clogovl').val(json['logoname']);
		},
		contentType: false,
		processData: false
	});

    });







    $('.combanner').change( function(){
		
		var formData = new FormData(jQuery('#image_upload_form1')[0]);
	$.ajax({
		url: 'index.php?route=customuserdetail/editaccount/updatebanner',
		type: 'post',
		data: formData,
		//dataType: 'formData,',
		success: function(data) {
		
		var json = JSON.parse(data);
        var logoss11 = $('.displaybanner').attr("src","<?php echo $base;?>image/companybanner/"+json['encryptedbanner']+"");
		    $('.combanner').val(json['encryptedbanner']);
		},
		contentType: false,
		processData: false
	});

    });












$(".edit-phone-only").keydown(function(event) {
		// Allow only backspace and delete
		if ( event.keyCode == 46 || event.keyCode == 8 ) {
			// let it happen, don't do anything
		}
		else {
			// Ensure that it is a number and stop the keypress
			if (event.keyCode < 48 || event.keyCode > 57 ) {
				event.preventDefault();	
			}	
		}
})




$(".edit-contact-phone-only").keydown(function(event) {
		// Allow only backspace and delete
		if ( event.keyCode == 46 || event.keyCode == 8 ) {
			// let it happen, don't do anything
		}
		else {
			// Ensure that it is a number and stop the keypress
			if (event.keyCode < 48 || event.keyCode > 57 ) {
				event.preventDefault();	
			}	
		}
})





//--></script>

<script src="catalog/view/javascript/assets/js/maskinput.js" type="text/javascript"></script>
<script>
$(function($){
   $("#taxid_mask").mask("99-99999999-9",{placeholder:""});
});
</script>

<?php echo $footer; ?>