<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />

	<link rel="stylesheet" href="css/style.css" />

	<!-- for closing the error dialog -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<title>TNM065 | moments</title>
</head>

<body>
	<div class="jumbotron">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-xs-12">
			<a href="/"><img class="logo img-responsive" src="img/logo.png" alt="logo" /><!--<h1>Moments</h1>--></a>
			</div>
		</div>
	</div>
	</div>

	<div class="container row allPosts"> <!-- wrapper -->


	<h2 class="text-center">Logga in eller registrera dig och skriv magiska meningar!</h2>
	<!-- felmeddelande om inlogget blivit knasigt -->
		<?php 
		    if(isset($_GET['loginError'])) {
		        $errorMessage = $_GET['loginError'];
		        $errorString = "fail";
		        if ($errorMessage == 'noMatch'){
		            $errorString =  "Inlogg misslyckades.";
		        } else if ($errorMessage == 'username'){
		            $errorString = "Användarnamnet finns redan registrerat.";
		        } else if ($errorMessage == 'password'){
		            $errorString = "Lösenordena matchade inte varandra.";
		        }
		       	echo '
				<div class="alert alert-danger">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					 ' . $errorString . '
				</div>'; 
	    	}
		?>

	<div class="col-sm-offset-1 col-sm-4 col-xs-12">
			<div> 
			<h4>Logga in</h4>
			<form class="form-horizontal" name="signIn" action="query/logInUser.php" role="form" method="POST">
				<div class="form-group">
					<input type="text" class="form-control" name= "usr" placeholder="Username" required="true"/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name= "pwd" placeholder="Password" required="true"/>
				</div>
				<button type="submit" class="btn btn-default"><span class="fa fa-sign-in"></span> Logga in</button>
			</form>
		</div>
		</div>

		<div class="col-sm-offset-1 col-sm-4 col-xs-12">
			<div> 
			<h4>Registrera dig!</h4>
			<form class="form-horizontal" name="signUp" action="query/addUser.php" role="form" method="POST">
				<div class="form-group">
					<input type="text" class="form-control" name= "usr" placeholder="Username" required="true"/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name= "pwd" placeholder="Password" required="true"/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name= "pwd2" placeholder="Same password again.." required="true"/>
				</div>
				<button type="submit" class="btn btn-default"><span class="fa fa-user-plus"></span> Skapa inlogg</button>
			</form>
		</div>
		</div>

	</div><!-- end right column -->

	<!-- footer -->
	<div class="jumbotron" id="footer">
	</div>

</body>
</html>