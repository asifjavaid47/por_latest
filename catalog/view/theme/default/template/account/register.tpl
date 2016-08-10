<?php echo $header; ?>

<div class="container">
 <div class="row col-sm-4 product-main-container midbox" style="background-color:white">
 <div style="box-shadow:none;border:none"class="register-hover">

   <div class="main-heading col-sm-12">Registrate</div>
               

	


   <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="" id="register_form_submit" style="margin-bottom: 0;">
      <div class="section-heading"><?php //echo $quick_registration; ?></div>
       
          
          <div class="form-group required" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
            <label class="col-sm-2 control-label"><?php echo $entry_customer_group; ?></label>
            <div class="col-sm-10">
              <?php foreach ($customer_groups as $customer_group) { ?>
              <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
              <div class="radio">
                <label>
                  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                  <?php echo $customer_group['name']; ?></label>
              </div>
              <?php } else { ?>
              <div class="radio">
                <label>
                  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
                  <?php echo $customer_group['name']; ?></label>
              </div>
              <?php } ?>
              <?php } ?>
            </div>
          </div>
          

          <div class="form-group col-sm-6 pdg-0 ">
              <input type="text" name="firstname" value="<?php  if(isset($firstname)){echo $firstname;} ?>" placeholder="<?php echo $name;?>" id="input-firstname" class="form-control btn-inp-rad" />
             <div class="clear5"></div>
              <span><?php echo $ex_name;?></span>
              <?php if (isset($error_firstname)) { ?>
              <div class="text-danger"><?php echo $error_firstname; ?></div>
              <?php } ?>
          </div>
          <div class="form-group  col-sm-6 pl0">

          <input type="text"  class="form-control btn-inp-rad" placeholder="<?php echo $surname; ?>" id="input-lastname"  value="<?php echo $lastname; ?>" name="lastname">
              <div class="clear5"></div>
              <span><?php echo $ex_surename;?></span>
              <?php if ($error_lastname) { ?>
              <div class="text-danger"><?php echo $error_lastname; ?></div>
              <?php } ?>
          </div>

          <div class="form-group required col-sm-12 pdg-0">
            <input type="email" class="form-control btn-inp-rad" placeholder="<?php echo $entry_email; ?>" name="email" value="<?php echo $email; ?>" id="input-email">
              <div class="clear5"></div>
              <span><?php echo $ex_email;?></span>
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
              <?php if ($error_warning) { ?>
              <div class="text-danger"><?php echo $error_warning; ?></div>
              <?php } ?>
          </div>

            <div class="form-group col-sm-12 pdg-0">

                <input type="text" class="form-control btn-inp-rad" name="repeatemail" placeholder="<?php echo $repeat_email;?>" value="<?php echo $repeatemail; ?>">             
                <div class="clear5"></div>
                <span><?php echo $ex_r_email;?></span>
                 <?php if ($error_email_confirm) { ?>
                <div class="text-danger"><?php echo $error_email_confirm; ?></div>
                <?php } ?>
            </div>


          <div class="form-group col-sm-12 pdg-0 btn-inp-rad">
            <input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $phone_number; ?>" id="input-fax" class="form-control numbersOnlyphone btn-inp-rad" autocomplete="off" />
                <div class="clear5"></div>
                <span><?php echo $ex_phone;?></span>
                <?php if ($error_fax_phones) { ?>
                <div class="text-danger"><?php echo $error_fax_phones; ?></div>
                <?php } ?>
          </div>
			<?php foreach ($custom_fields as $custom_field) { ?>

          <?php if ($custom_field['location'] == 'account') { ?>

          <?php if ($custom_field['type'] == 'select') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">

                <option value=""><?php echo $text_select; ?></option>

                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>

                <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>

                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>

                <?php } else { ?>

                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>

                <?php } ?>

                <?php } ?>

              </select>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'radio') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div>

                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>

                <div class="radio">

                  <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>

                  <label>

                    <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } else { ?>

                  <label>

                    <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } ?>

                </div>

                <?php } ?>

              </div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'checkbox') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div>

                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>

                <div class="checkbox">

                  <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>

                  <label>

                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } else { ?>

                  <label>

                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } ?>

                </div>

                <?php } ?>

              </div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'text') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'textarea') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'file') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>

              <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'date') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div class="input-group date">

                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

                <span class="input-group-btn">

                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>

                </span></div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'time') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div class="input-group time">

                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

                <span class="input-group-btn">

                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>

                </span></div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'datetime') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div class="input-group datetime">

                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

                <span class="input-group-btn">

                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>

                </span></div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php } ?>

          <?php } ?>

          
          <?php foreach ($custom_fields as $custom_field) { ?>
          <?php if ($custom_field['location'] == 'address') { ?>
          <?php if ($custom_field['type'] == 'select') { ?>
          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
            <div class="col-sm-10">
              <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>

                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>

                <?php } else { ?>

                <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>

                <?php } ?>

                <?php } ?>

              </select>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'radio') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div>

                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>

                <div class="radio">

                  <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>

                  <label>

                    <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } else { ?>

                  <label>

                    <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } ?>

                </div>

                <?php } ?>

              </div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'checkbox') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div>

                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>

                <div class="checkbox">

                  <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>

                  <label>

                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } else { ?>

                  <label>

                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />

                    <?php echo $custom_field_value['name']; ?></label>

                  <?php } ?>

                </div>

                <?php } ?>

              </div>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'text') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'textarea') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'file') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>

              <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />

              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>

              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>

              <?php } ?>

            </div>

          </div>

          <?php } ?>

          <?php if ($custom_field['type'] == 'date') { ?>

          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

            <div class="col-sm-10">

              <div class="input-group date">

                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />

                <span class="input-group-btn">

                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>

                </span></div>
              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php } ?>
          <?php if ($custom_field['type'] == 'time') { ?>
          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
            <div class="col-sm-10">
              <div class="input-group time">
                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php } ?>
          <?php if ($custom_field['type'] == 'datetime') { ?>
          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
            <div class="col-sm-10">
              <div class="input-group datetime">
                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php } ?>
          <?php } ?>
          <?php } ?>
       

        
        
       
             <div class="form-group col-sm-12 pdg-0 btn-inp-rad">
             
              <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control btn-inp-rad" />
                <div class="clear5"></div>
                <span><?php echo $ex_pass;?></span>
                  <?php if ($error_password) { ?>
                  <div class="text-danger"><?php echo $error_password; ?></div>
                  <?php } ?>

            </div>

   <?php echo $captcha; ?>

    

  <p style="text-align:center; margin-bottom: 5px;" class="important-text">
      Al registrarme, declaro que soy mayor de edad y acepto los
      <a href="index.php?route=account/termofuse" style="color:#312782;">Términos, Condiciones</a> y <a style="color:#312783;" href="index.php?route=account/privacy">Políticas de privacidad</a>
      de Porcantidad.com
  </p>
         <div style="margin: 0 15px;"  >
            <input type="submit" value="<?php echo $button_continue; ?>" class="continu col-sm-12 btn-reg-rad" style="width: 100%;margin-bottom: 0px;"/>
         </div>
     </form>

      <?php echo $content_bottom; ?>

<span class="important-text" style="float:left;text-align:center; width:100%; padding-top:10px; padding-bottom: 10px;">Tenés una cuenta? <a href="index.php?route=account/register/login" style="color:#312782">Ingresá aquí</a></span>
</div>



<div class="error-login">
<div class="clearfix"></div>
</div>


</div> <!--- product-main-container close-->
</div>
    </div>
</div>

<script type="text/javascript">

<!--

// Sort the custom fields

$('#account .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#account .form-group').length) {
		$('#account .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#account .form-group').length) {
		$('#account .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#account .form-group').length) {
		$('#account .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#account .form-group').length) {
		$('#account .form-group:first').before(this);
	}
});



$('#address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#address .form-group').length) {
		$('#address .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#address .form-group').length) {
		$('#address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#address .form-group').length) {
		$('#address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#address .form-group').length) {
		$('#address .form-group:first').before(this);
	}
});



$('input[name=\'customer_group_id\']').on('change', function() {

	$.ajax({
		url: 'index.php?route=account/register/customfield&customer_group_id=' + this.value,
		dataType: 'json',
		success: function(json) {
			$('.custom-field').hide();
			$('.custom-field').removeClass('required');

			for (i = 0; i < json.length; i++) {
				custom_field = json[i];
				$('#custom-field' + custom_field['custom_field_id']).show();
				if (custom_field['required']) {
					$('#custom-field' + custom_field['custom_field_id']).addClass('required');
				}
			}
		},

		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

});

$('input[name=\'customer_group_id\']:checked').trigger('change');

//--></script>

<script type="text/javascript"><!--

$('button[id^=\'button-custom-field\']').on('click', function() {

	var node = this;
	$('#form-upload').remove();
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {

					$(node).parent().find('.text-danger').remove();
					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}
					if (json['success']) {
						alert(json['success']);
						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});

		}

	}, 500);

});

//--></script>

<script type="text/javascript"><!--

$('.date').datetimepicker({

	pickTime: false

});

$('.time').datetimepicker({

	pickDate: false

});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

//--></script>

<script type="text/javascript"><!--
$('select[name=\'country_id\']').trigger('change');

//--></script>

<script type="text/javascript">
   $(document).ready(function()
   {
  		$("#input-fax").keydown(function(e) {
		
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190, 32, 173, 189, 107, 109]) !== -1 ||
      // Allow: Ctrl+A,Ctrl+C,Ctrl+V, Command+A
      ((e.keyCode == 65 || e.keyCode == 86 || e.keyCode == 67) && (e.ctrlKey === true || e.metaKey === true)) ||
      // Allow: home, end, left, right, down, up
      (e.keyCode >= 35 && e.keyCode <= 40) ||
	  //Allow: +
	  ((e.keyCode == 61 || e.keyCode == 187)&&(e.shiftKey == true))
	  ) {
		
      // let it happen, don't do anything
      return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });
  
  
  
  
  $(function(){

   $( ".numbersOnlyphone" ).bind( 'paste',function()
   {
       setTimeout(function()
       { 
          	//get the value of the input text
          	var dataFull= $( '.numbersOnlyphone' ).val() ;
          	//replace the special characters to '' 
         	// var dataFull = data.replace(/[^a-z+A-Z]/, '');
			xyz = Number(dataFull);
		 
		 
		 if(isNaN(xyz))
		 {
			 $('.numbersOnlyphone' ).val(' ')
		 }
		 else
		 {
			$( '.numbersOnlyphone' ).val(dataFull); 
		 }
       });

    });
});
  

	user_register_mouse_flag = 0;
	$(".register-hover").mouseenter(function(){
	 user_register_mouse_flag = 1;
		 $(document).keypress(function(e) {
			 if(user_register_mouse_flag == 1){
				if(e.which == 13) {
					  $("#register_form_submit").submit();
				}
			 }
		});
	});
	
	
	$(".register-hover").mouseleave(function(){
		user_register_mouse_flag = 0;
	});
}); 




</script>

<script type="text/javascript"><!--
function loacation() {
	window.location.href="index.php?route=register/login";
}
//--></script>
<?php echo $footer; ?>