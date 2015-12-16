<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE adminsite SYSTEM "adminsite.dtd">

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
		<div class="container centerAligned">
			<div>
				<p>
					<a href="index.php">
						<img class="logo img-responsive" src="/img/logo.png" alt="logo" />
					</a>
				</p>
			</div>
			
			<div>
			<xsl:if test="currentUser">
				<form class="form-inline" role="form" action="/query/logOut.php" method="POST">
					<xsl:variable name="userID" select="currentUser/@id"/>
					<a href="views/profile.php?id={$userID}"><xsl:apply-templates select="currentUser" /></a>
					<button type="submit" class="btn btn-default"><span class="fa fa-sign-out"></span> Logga ut</button>
				</form>
			</xsl:if>
			<xsl:if test="not(currentUser)">
				<a class="btn btn-default" href="login.php"><span class="fa fa-sign-in"></span> Logga in eller registrera</a>
			</xsl:if>
			</div>
		</div>
	</div>

	<div class="container"> <!-- wrapper -->
		<!-- show all the users here -->
		<h3>Administrera användare</h3>
		<p><small>Här kan du ändra användarnamn, lösenord och behörighet på användare som är registrerade.</small></p>

		<!-- a error message can be shown. -->
		<xsl:if test="errorMessage">
			<div class="alert alert-danger">
				<xsl:value-of select="errorMessage"/>
			</div>
		</xsl:if>

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
		<small><i><a href="admin.php">adminsida</a></i></small>
	</xsl:if>
</xsl:template>

<xsl:template match="user">
	<div class="well well-sm adminuser row">
		<xsl:variable name="picID" select="picID"/>
		<img class="userImage col-xs-4 img-responsive img-circle" src="img/user/{$picID}.jpg" alt="user" />

		<!-- kan inte ändra admin till vanlig standard om du är inne :P -->
		<form action="query/adminEdit.php?userid={userid}" method="POST">
		<!-- show the name -->
		<div class="col-xs-8">
		<p class="text-capitalize">
			Namn: <input type="text" class="form-control" name="userName" value="{name}" required="true" />
		</p>
		<!-- show which authority you have -->
		<p>
			Behörighet: 
			<xsl:choose>
			<xsl:when test="userid != ../currentUser/@id">
			<select name="auth" class="form-control">
				<xsl:choose>
					<xsl:when test="authority=0">
						<option value="0" selected="selected">Admin</option>
        				<option value="1">Standard</option>
					</xsl:when>
					<xsl:otherwise>
						<option value="0">Admin</option>
        				<option value="1" selected="selected">Standard</option>
					</xsl:otherwise>
				</xsl:choose>
    		</select>
    		</xsl:when>
    		<xsl:otherwise>
    			<!-- make a disabled if you are the current user -->
    			<select name="auth" class="form-control" disabled="true">
				<xsl:choose>
					<xsl:when test="authority=0">
						<option value="0" selected="selected">Admin</option>
        				<option value="1">Standard</option>
					</xsl:when>
					<xsl:otherwise>
						<option value="0">Admin</option>
        				<option value="1" selected="selected">Standard</option>
					</xsl:otherwise>
				</xsl:choose>
    		</select>
			</xsl:otherwise>
			</xsl:choose>
		</p>
		<!-- change password -->
		<p>Lösen: <input type="password" class="form-control" name= "pwd" placeholder="Password" /></p>

		<!-- button that saves, updates -->
		<p><button type="submit" class="btn btn-default">Update</button></p>
	</div>
		</form>
	</div>
</xsl:template> 

</xsl:stylesheet>