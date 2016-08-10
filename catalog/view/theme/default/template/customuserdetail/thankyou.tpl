<?php 
    echo $header;
?>


      <div class="search-product-head-container">
         <div class="container">
            <div class="search-produ-head">
            </div>
         </div>
      </div>
      
      
      
      <!--modal-box---------->

<div class="modal_box22">

    <div class="modall_content11 text-center">
        <a href="javascript:void(0);" class="close_11" id="close_11"><i class="fa fa-close"></i></a>
        <h2>
            Cambiar Email
            <div class="orange_mail">
                <label for="">Email actual :</label>
                <span>SM3087@gmail.com</span>
            </div>
        </h2>

        
        <div class="row">
            <label for="" class="col-md-3 text-right">Nuevo Email:</label>
            <div class="col-md-5">
                <input type="email" class="form-control">
                <span class="small">Éste será tu nuevo Email</span>
            </div>
        </div>

        <div class="row">
            <label class="col-md-3 text-right">
                Repetir Email nuevo:
            </label>
            <div class="col-md-5">
                <input type="email" class="form-control">
            </div>
        </div>

        <div class="row text-left">
            <div class="col-md-5 col-md-offset-3">
                <button class="btn_pur">Guardar</button>
                <button class="khali_11" id="close_11">Cancelar</button>
            </div>
        </div>

    </div>

</div>

<!--modal-box---------->



<div class="min-height">
    <div class="container">
        <div class="row">

            <!-- sidebar-->
            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
                <div class="sideoptions">
                    <ul>
                        <li><a href=""><i class="fa fa-user" aria-hidden="true"></i> Mi cuenta</a></li>
                        <li><a href="<?php echo $base.'index.php?route=customuserdetail/editaccount'; ?>"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Editar cuenta</a></li>
                        <li><a href=""><i class="fa fa-key" aria-hidden="true"></i> Contraseña</a></li>
                        <li><a href=""><i class="fa fa-book" aria-hidden="true"></i> Direcciones</a></li>
                        <li><a href=""><i class="fa fa-envelope-o" aria-hidden="true"></i> my enquiry</a></li>
                        <li><a href=""><i class="fa fa-star-half-o" aria-hidden="true"></i> reward points</a></li>
                        <li><a href=""><i class="fa fa-sign-out" aria-hidden="true"></i> Cerrar sesión</a></li>
                    </ul>
                </div>
            </div>

            <!-- sidebar-->


            <div class="col-lg-9 col-md-9 col-sm-8 col-xs-12">


                <h2><?php echo $msg; ?></h2>


            </div>


            <div class="hidden-xs hidden-sm col-md-2 col-lg-2">&nbsp;</div>
        </div>
    </div>
</div>

 <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script> 
<!--modal -js-->
<script type="">
$(document).ready(function(){

    $("body").on("click",".Edit_email11",function(){
        $(".modal_box22").fadeIn(500);
    });

    $("body").on("click","#close_11",function(){
        $(".modal_box22").fadeOut(500);
    });

});
</script>

<!--modal -js-->





<?php echo $footer; ?>