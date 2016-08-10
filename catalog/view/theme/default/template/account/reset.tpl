<?php echo $header; ?>

<style type="text/css">
/*  .footer-main{
    position: absolute;
    bottom: 36px;
    width: 100%;
  }
  .copyright{
    position: absolute;
    bottom: 0;
    width: 100%;
  }
  */
  
  
</style>

<div class="search-product-head-container">
           <div class="container">
               <div class="search-produ-head">
                  
                   <div class="breadcum-block">
                        <ul>
                            <li>Home</li>
                            <li>&gt;</li>
                            <li>Reset password</li>
                          
                       </ul>
                   </div>
               </div>
           </div>
       </div>

<div class="container">
  <!--<ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul> -->
  
  
  <div class="row">
    
    <div id="content" class="<?php echo $class; ?>">
      <h1><?php echo $heading_title; ?></h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_password; ?></legend>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>
            <div class="col-sm-10">
              <input type="password" name="password" value="<?php echo $password; ?>" id="input-password" class="form-control" />
              <?php if ($error_password) { ?>
              <div class="text-danger"><?php echo $error_password; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-confirm"><?php echo $entry_confirm; ?></label>
            <div class="col-sm-10">
              <input type="password" name="confirm" value="<?php echo $confirm; ?>" id="input-confirm" class="form-control" />
              <?php if ($error_confirm) { ?>
              <div class="text-danger"><?php echo $error_confirm; ?></div>
              <?php } ?>
            </div>
          </div>
        </fieldset>
        <div class="buttons clearfix">
          <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
          <div class="pull-right"><button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_continue; ?></button></div>
        </div>
      </form>
      </div>
    </div>
</div>
<?php echo $footer; ?>