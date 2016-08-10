<?php
	echo $header;
	echo $header1;
?>
<style>		
	.heading-text
	{
		font-size: 35px;
		text-align: center;
		margin-bottom: 20px;
		font-weight: bold;
	}
	
	.heading-bottom
	{
		font-size: 24px;
		font-weight: bold;
		margin-bottom: 12px;
		display: inherit;
		width: 100%;
		text-align: center;
	}
	
	.label-default
	{
		background-color: #886310 !important;
	}
</style>
    <!-- Page Content -->

    <!-- Page Content -->
    <div class="container">
		<div class="col-sm-12 midbox" >
			<div class="col-sm-12">
				<div class="main-title"> Resumen
					<div class="clear10"></div>
				</div>
			</div>
			<div class="col-sm-4 col-sm-offset-2">
				<ul class="list-group">
					<span class="heading-bottom">Preguntas</span>
					<li class="list-group-item">
						Preguntas sin contestar (To Be implemented Yet)
						<span class="label label-default label-pill pull-xs-right pull-right">
							0
						</span>
					</li>
				</ul>
					
				<ul class="list-group">
					<span class="heading-bottom">Productos</span>
					<li class="list-group-item">
						Active
						<a href='<?php echo $site_url."index.php?route=dashboard/product#active"?>'>
							<span class="label label-default label-pill pull-xs-right pull-right"><?php echo $total_active_products?></span>
						</a>
					</li>
					<li class="list-group-item">
						Paused
						<a href='<?php echo $site_url."index.php?route=dashboard/product#pause" ?>'>
							<span class="label label-default label-pill pull-xs-right pull-right"><?php echo $total_paused_products?></span>
						</a>
					</li>
					<li class="list-group-item">
						Finilized
						<a href='<?php echo $site_url."index.php?route=dashboard/product#finalize" ?>'>
							<span class="label label-default label-pill pull-xs-right pull-right"><?php echo $total_finalized_products?></span>
						</a>
					</li>
				</ul> 
				<ul class="list-group">
					<span class="heading-bottom">Balance</span>
					<li class="list-group-item">
						SaleOff Charges
						<span class="label label-default label-pill pull-xs-right pull-right">
							$<?php echo $saleoff_charges;?>
						</span>
					</li>
				</ul>
			</div>
			<div class="col-sm-4">
				<ul class="list-group">
					<span class="heading-bottom">Estadisticas de Venta</span>
					<li class="list-group-item">
						Today 
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_today_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						yesterday
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_yesterday_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						This Week
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $week_total_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						Last Week
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_last_week_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						Two Weeks Ago
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_2nd_last_week_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						This Month (Since Day 1)
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_this_month_sales; ?>
						</span>
					</li>
					<li class="list-group-item">
						Last Month
						<span class="label label-default label-pill pull-xs-right pull-right">
							<?php echo $total_last_month_sales; ?>
						</span>
					</li>
				</ul>
			</div>				
		</div>
	</div>
	<div class="clearfix"></div>
    <?php echo $footer;?>