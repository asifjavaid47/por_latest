<?php
	echo $header;
	echo $column_left;
?>
<style>
	.padding14
	{
		padding: 6px;
	}
	
	.btn-primary
	{
		color: #fff;
		background-color: #312783;
		border-color: #312783;
	}
	
	.pull-left
	{
		float: left!important;
	}
	
	.paddingl
	{
		padding-left:0px
	}
	
	.paddingr
	{
		padding-right:0px
	}
</style>
	
<script>
	var new_or_modify_banners = 0;
	var banner_global_id = 0;
	var current_token;
	$(document).ready(function()
	{
		var query = window.location.search.substring(1);
		parameters = query.split("&");
		
		current_token = parameters[1];
		
		$(".dashboard").hide();
		$(".show_details").click(function()
		{
			new_or_modify_banners = 0;
			this_banner_id = $(this).attr('id');
			banner_global_id = $(this).attr('id');
			$("#hidediv").hide();
			$(".dashboard").show();
			$.ajax(
			{
				url: 'index.php?route=banners/banner/get_one_banner_by_id&'+current_token,
				type: 'post',
				data: {this_banner_id:this_banner_id},
				success: function(data)
				{
					parsed_data = JSON.parse(data);
					$('#banner_html').val(parsed_data['banner_html']);
					$('#banner_title').val(parsed_data['all_data'].banner_title);
					$('#banner_page_place').val(parsed_data['all_data'].banner_zone_page);
					$('#assign_banner_id').val(parsed_data['all_data'].banner_assigned_id);
					
					$('#banner_description').val(parsed_data['all_data'].banner_description);
				}
			});
		});
		$("#show").click(function()
		{
			$(".dashboard").hide();
			$("#hidediv").show();
		});
		$("#hide_2").click(function()
		{
			$("#hidediv").hide();
			$(".dashboard").show();
		});
		
		$('#add_new_banned').click(function()
		{
			new_or_modify_banners = 1;
			$('#banner_html').val('');
			$('#banner_title').val('');
			$('#banner_description').val('');
			$('#banner_page_place').val('');
			$('#assign_banner_id').val('');
			$("#hidediv").hide();
			$('#add_edit_banner_dashboard').show();
		});
		
		$('#save_banner').click(function()
		{
			error_input = 0;
			banner_html = $('#banner_html').val();
			banner_title = $('#banner_title').val();
			banner_description = $('#banner_description').val();
			// the_banner_page = $('#the_banner_page').val();
			// the_banner_place = $('#the_banner_place').val();
			banner_page_place = $('#banner_page_place').val();
			assign_banner_id = $('#assign_banner_id').val();
			
			if(banner_html==="")
			{
				error_input = 1;
			}
			
			if(banner_title==="")
			{
				error_input = 1;
			}
			
			if(banner_description==="")
			{
				error_input = 1;
			}
			
			// if(the_banner_page ==="")
			// {
				// error_input = 1;
			// }
			
			// if(the_banner_place ==="")
			// {
				// error_input = 1;
			// }
			
			if(banner_page_place ==="")
			{
				error_input = 1;
			}
			
			if(assign_banner_id ==="")
			{
				error_input = 1;
			}
			
			if(error_input === 0)
			{
				$('#empty_fields_alert').hide();
				$.ajax(
				{
					url: 'index.php?route=banners/banner/add_or_edit_new_banner&'+current_token,
					type: 'post',
					data: {assign_banner_id:assign_banner_id, banner_global_id:banner_global_id, banner_page_place:banner_page_place, new_or_modify_banners:new_or_modify_banners, banner_html:banner_html, banner_title:banner_title, banner_description:banner_description},
					success: function(data)
					{
						window.location.reload();
					}
				});
			}
			else
			{
				$('#empty_fields_alert').show();
			}
		});
		
		$('body').on('click', '.clear_clicks', function()
		{
			banner_id = $(this).attr('id');
			$.ajax(
			{
				url: 'index.php?route=banners/banner/clear_banner_clicks&'+current_token,
				type: 'post',
				data:{banner_id:banner_id},
				success: function(data)
				{
					window.location.reload();
				}
			});
		});
		
		$('body').on('click', '.clear_prints', function()
		{
			banner_id = $(this).attr('id');
			$.ajax(
			{
				url: 'index.php?route=banners/banner/clear_banner_prints&'+current_token,
				type: 'post',
				data:{banner_id:banner_id},
				success: function(data)
				{
					window.location.reload();
				}
			});
		});
	});
</script>

<div id='excluding_left_column' style='margin-left:235px;'>
	<!-- Page Content -->
	<div class="col-sm-1"></div>
	<div class="col-sm-11"><h1>Banner List</h1></div>

	<div class="clearfix"></div>
	<div class="container">
		<div class="col-sm-10 midbox">
		<button class='btn btn-primary' id='add_new_banned'> Add New Banner </button>
			<div id="hidediv">
				<?php 
					for($i = 0; $i < sizeof($all_banners); $i++)
					{
						?>
						<div class="col-sm-12">
							<h3><?php echo $all_banners[$i]['banner_title']; ?></h3><br/>
							<span><?php echo  htmlspecialchars_decode(stripslashes(base64_decode($all_banners[$i]['banner_html']))); ?></span><br /><br />
							<p><?php echo $all_banners[$i]['banner_description']; ?></p><br />
							<label><?php echo $all_banners[$i]['banner_zone_page'].' '.$all_banners[$i]['banner_zone_page_place']; ?></label><br />
							<label>Prints : <?php echo $all_banners[$i]['banner_prints']; ?></label><button id='<?php echo $all_banners[$i]['banner_id']; ?>' class='clear_prints'>Clear</button><br />
							<label>Clicks : <?php echo $all_banners[$i]['banner_clicks']; ?></label><button id='<?php echo $all_banners[$i]['banner_id']; ?>' class='clear_clicks'>Clear</button><br />
							<a href="javascript:void(0)" id='<?php echo $all_banners[$i]['banner_id']; ?>' class="show_details">View Details</a>			
						</div>
						<br />
						<?php
					}
				?>
			</div>
			<div id='add_edit_banner_dashboard' class="col-sm-12 text-center dashboard">
				<h2>Banner Dashboard</h2>
				<div class='col-sm-3'>
				</div>
				<div class='col-sm-6'>
					<div style='display:none;' id='empty_fields_alert' class='alert alert-warning'>Fill in all fields!</div>			
				</div>
				<div class='col-sm-3'>
				</div>
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Html</label></div>
					<div class="col-sm-6"><textarea class="form-control" name="html" id='banner_html' placeholder="Place Banner Code Here"></textarea></div>
					<div class="col-sm-2"></div><br />
				</div>
				
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Banner Title</label></div>
					<div class="col-sm-6"><input type="" class="form-control" name="html" id='banner_title' placeholder="Place Banner Code Here"></div>
					<div class="col-sm-2"></div><br />
				</div>
				
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Banner Description</label></div>
					<div class="col-sm-6"><textarea class="form-control" name="html" id='banner_description' placeholder="Banner Description"></textarea></div>
					<div class="col-sm-2"></div><br />
				</div>
				
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Part Of the Page</label></div>
					<div class="col-sm-6"><input type="" class="form-control" name="html" id='banner_page_place' placeholder="Part Of the Page"/></div>
					<div class="col-sm-2"></div><br />
				</div>
				
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Assign banner an ID</label></div>
					<div class="col-sm-6">
						<select class="form-control" name="html" id='assign_banner_id'>
							<option value="banner1">Banner 1</option>
							<option value="banner2">Banner 2</option>
							<option value="carosal_banner">Carousal Banner</option>
							<option value="no id">No ID</option>
						</select>
					</div>
					<div class="col-sm-2"></div><br />
				</div>
				<!--
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"><label>Part Of the Page</label></div>
					<div class="col-sm-6">
						<div class="col-sm-6 paddingl">
							<select class="form-control pull-left" name="html" id='the_banner_page'>
								<option value='Not on Any Page'>Not on Any Page</option>
								<option value='search'>Search Page</option>
								<option value='category'>Category Page</option>
								<option value='homepage'>HomePage</option>
							</select> 
						</div>
						<div class="col-sm-6 paddingr">
							<select class="form-control pull-right" name="html" id='the_banner_place'>
								<option value='left_bottom'> Left Bottom </option>
								<option value='left_top'> Left Top </option>
								<option value='right_bottom'> Right Bottom</option>
								<option value='right_top'> Right Top </option>
								<option value='mid_bottom'> Mid Bottom </option>
								<option value='mid_top'> Mid Top </option>
							</select>
							
						</div>
					</div>
					<div class="col-sm-2"></div>
				</div>
				-->
				<div class="col-sm-12 padding14">
					<div class="col-sm-4"></div>
					<div class="col-sm-6"><button type="button" id='save_banner' class="btn btn-primary">Save</button>&nbsp;<a href="javascript:void(0)"" id="show"><button type="button" class="btn btn-default">Back</button></a></div>
					<div class="col-sm-2"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /.container -->
<?php echo $footer; ?>