<div class="clearfix"></div>
	<style>
		.navbar-inverse {
			border-radius: 0px;
			height:35px!important;
			border:0px;
			min-height:35px;
		}
		.nav.navbar-nav.pull-right li a{
			color: #ddd;
			font-weight:bold;
		}
		
		.navbar-brand span{
			color:#ddd;
		}		
		.mrtop32{
			margin-top: 32px;
		}
		.brdr{
		    border-bottom: 2px solid;
			margin-bottom: 19px;
		}
		.textarea{
		width: 100%;
		height: 152px;
		border-color: #ddd;
		border-radius: 13px;
		}
		
		.midbox{
		margin: 30px auto;
		float: none;
		display: block;
		}
		.linehclass{
		line-height: 48px;
		}
		.dashboard-button{
			font-size: 12px;
			font-weight:normal!important;
			font-color:#ddd;
			height: 35px;
			padding-top:9px !important;
		}
		.dashboard-button:hover {
			color: white!important;
			background-color: #303856!important;

		}

	</style>	
    <!-- Navigation -->
    <nav class="navbar navbar-inverse header-main-color" role="navigation" >
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header" style="">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="summary.html"><i class="glyphicon glyphicon-dashboard" style="color:#ddd;">&nbsp</i><span>Mi cuenta</span></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav pull-right">
                    <li>
                        <a href="<?php echo $base;?>index.php?route=dashboard/summary" class="dashboard-button">Resumen</a>
                    </li>
                    <li>
                       <a href="<?php echo $base;?>index.php?route=dashboard/question" class="dashboard-button">Preguntas</a>
                    </li>
                    <li>
                        <a href="<?php echo $base;?>index.php?route=dashboard/purchase" class="dashboard-button">Compras</a>
                    </li>
					<li>
						<a href="<?php echo $base;?>index.php?route=dashboard/product" class="dashboard-button">Mis Productos</a>
                    </li>
					<li>
                        <a href="<?php echo $base;?>index.php?route=dashboard/answer" class="dashboard-button">Respuestas</a>
                    </li>
					<li>
                        <a href="<?php echo $base;?>index.php?route=dashboard/sale" class="dashboard-button">Ventas</a>
                    </li>
					<li>
                        <a href="<?php echo $base;?>index.php?route=product/wishlist" class="dashboard-button">Favoritos</a>
                    </li>
				</ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
    <!-- Page Content -->

