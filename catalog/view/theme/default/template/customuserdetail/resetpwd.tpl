
<?php echo $header; ?>


<div class="container" style="padding-top: 10px;">
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-8'; ?>
        <?php } ?>


        <div id="content" class="col-sm-8 col-sm-offset-2">
            <div class="common-content edit_account row">


                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"
                      class="form-horizontal">
                    <fieldset>
                        <div class="details col-md-12" style="text-align: center;">
                            <legend style="text-align:left; padding-top:15px; padding-left:6px;"
                                    class="col-sm-offset-3"><?php echo $text_password; ?></legend>
                            <div class="form-group required">
                                <div class="col-sm-6 col-sm-offset-3">
                                    <input type="password" name="old_password" value="" placeholder="Contraseña actual"
                                           id="input-password" class="form-control">
                                </div>
                                    </div>
                            <div class="form-group required">
                                <div class="col-sm-6 col-sm-offset-3">
                                    <input type="password" name="password" value="<?php echo $password; ?>"
                                           placeholder="<?php echo $entry_password; ?>" id="input-password"
                                           class="form-control"/>
                                    <?php if ($error_password) { ?>
                                        <div class="text-danger"><?php echo $error_password; ?></div>
                                    <?php } ?>
                                </div>
                                    </div>
                            <div class="form-group required">
                                <div class="col-sm-6 col-sm-offset-3">
                                    <input type="password" name="confirm" value="<?php echo $confirm; ?>"
                                           placeholder="<?php echo $entry_confirm; ?>" id="input-confirm"
                                           class="form-control"/>
                                    <?php if ($error_confirm) { ?>
                                        <div class="text-danger"><?php echo $error_confirm; ?></div>
                                    <?php } ?>
                                </div>
                                    </div>
                            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary"/>
                                </div>
                    </fieldset>
                        </form>
                        <?php echo $content_bottom; ?></div>
                </div>

    </div>
</div>
<?php echo $footer; ?>