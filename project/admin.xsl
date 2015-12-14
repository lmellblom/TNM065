<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE blogposts SYSTEM "blogposts.dtd">

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
	<xsl:output indent="yes" method="xml"/>

<xsl:template match="adminsite">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />

	<link rel="stylesheet" href="css/style.css" />
	
	<title>TNM065 | moments</title>
</head>

<body>
	
	<div class="jumbotron">
		<div class="container">
			<a href="/"><h1>Moments</h1></a>

			<xsl:if test="currentUser">
				<div class="pull-right">
				<form class="form-inline" role="form" action="/query/logOut.php" method="POST">
					<xsl:apply-templates select="currentUser" />
					<button type="submit" class="btn btn-default"><span class="fa fa-sign-out"></span> Logga ut</button>
				</form>
				</div>
			</xsl:if>
			<xsl:if test="not(currentUser)">
				<div class="pull-right">
				<a class="btn btn-default" href="/login.php"><span class="fa fa-sign-in"></span> Logga in eller registrera</a>
			</div>
			</xsl:if>
		</div>
	</div>

	<div class="container"> <!-- wrapper -->
		<!-- show all the users here -->
		<h3>Administrera användare</h3>
		<p><small>Här kan du ändra lösenord och behörighet på användare som är registrerade.</small></p>

		<!-- a error message can be shown. -->
		<xsl:if test="errorMessage">
			<div class="alert alert-danger">
				<xsl:value-of select="errorMessage"/>
			</div>
		</xsl:if>

		<div class="row">
			<p class="col-xs-offset-2 col-xs-4"><b>Användarnamn</b></p>
			<p class="col-xs-4"><b>Behörighet</b></p>
		</div>
		<xsl:apply-templates select="user" />

	</div><!-- end wrapper -->

	<!-- footer -->
	<div class="jumbotron" id="footer">
	</div>

</body>
</html>
</xsl:template> 

<xsl:template match="currentUser">
	<p> Inloggad som <xsl:value-of select="@name"/></p>
	<xsl:if test="@authority = 0">
		<small><i><a href="../admin.php">adminsida</a></i></small>
	</xsl:if>
</xsl:template>

<xsl:template match="user">
	<div class="well well-sm adminuser row">
		<xsl:variable name="picID" select="picID"/>
		<img class="col-xs-4 img-responsive userImage img-circle" src="img/user/{$picID}.jpg" alt="user" />

		<p class="col-xs-4 text-capitalize"><xsl:value-of select="name"/></p>
		<!--<p>ID: <xsl:value-of select="userid"/></p>-->
		<p class="col-xs-4">
			<xsl:if test="authority = 0">
				Admin
			</xsl:if>
			<xsl:if test="authority = 1">
				Standard
			</xsl:if>
		</p>
	</div>
</xsl:template> 

</xsl:stylesheet>