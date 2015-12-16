<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
	<xsl:output indent="yes" method="xml"/>

<xsl:template match="blogposts">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />

	<link rel="stylesheet" href="../css/style.css" />
	
	<title>TNM065 | moments</title>
	<script>
		function showForm(elementID, postID){
			// uses ajax to genereate the edit form for a post inline.

			var xmlhttp = new XMLHttpRequest();
	        xmlhttp.onreadystatechange = function() {
	            if (xmlhttp.readyState == 4) {
	            	if(xmlhttp.status == 200){
	                document.getElementById(elementID).innerHTML = xmlhttp.responseText;
	                }
	            }
	        };
	        xmlhttp.open("GET", "/views/createForm.php?postID=" + postID);
	        xmlhttp.send();
		};
	</script>
</head>

<body>
	<div class="jumbotron">
		<div class="container centerAligned">
			<div>
				<p>
					<a href="../index.php">
						<img class="logo img-responsive" src="../img/logo.png" alt="logo" />
					</a>
				</p>
			</div>
			
			<div>
			<xsl:if test="currentUser">
				<form class="form-inline" role="form" action="/query/logOut.php" method="POST">
					<xsl:variable name="userID" select="currentUser/@id"/>
					<a href="../views/profile.php?id={$userID}"><xsl:apply-templates select="currentUser" /></a>
					<button type="submit" class="btn btn-default"><span class="fa fa-sign-out"></span> Logga ut</button>
				</form>
			</xsl:if>
			<xsl:if test="not(currentUser)">
				<a class="btn btn-default" href="../login.php"><span class="fa fa-sign-in"></span> Logga in eller registrera</a>
			</xsl:if>
			</div>
		</div>
	</div>

	<div class="container"> <!-- wrapper -->
		<div class="center-block">
			<xsl:choose>
				<xsl:when test="count(post)=0">
					<p>Här var det tomt..</p>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="post" />
				</xsl:otherwise>
			</xsl:choose>			
		</div>
	</div><!-- end wrapper -->

	<!-- footer -->
	<div class="jumbotron" id="footer">
	</div>

</body>
</html>
</xsl:template> 

<xsl:template match="post">
 	<div class="well well-sm" id="{generate-id(.)}">

	<div class="row posts">
		<div class="col-xs-2 alignCenter">
			<p class="text-center userInfo text-capitalize">
				<xsl:variable name="profileID" select="author/@id"/>
				<a href="profile.php?id={$profileID}"> <xsl:value-of select="author"/></a>
			</p>
			<xsl:variable name="picID" select="author/@picid"/>
			<img class="img-responsive userImage img-circle" src="../img/user/{$picID}.jpg" alt="user" />
		</div>

		<div class="col-xs-10">
		 	<h4 class="text-uppercase"><xsl:value-of select="title"/> 
		 		<!-- vilket datum -->
			 	<small class="text-lowercase">
			 		- <xsl:value-of select="publish_date" />
			 	</small>
		 	</h4>

		 	<p>
		 		<xsl:value-of select="text"/>
		 	</p>

		 	<xsl:variable name="post_id" select="@id"/>
		 	<!-- edit and remove buttons! -->
		 	<xsl:if test="author/@id = ../currentUser/@id or ../currentUser/@authority = 0">
		 		<p class="pull-right">
		 			<a onclick="showForm('{generate-id(.)}', '{$post_id}')"><span class="fa fa-pencil"></span> edit </a>
		 			<a href="../query/updateOrDeletePost.php?delete={$post_id}"><span class="fa fa-times"></span> delete </a>
		 		</p>
		 	</xsl:if>
	 	</div>
	 </div>
	 <div class="row">
	 	<div class="col-xs-offset-2 col-xs-10">
		 	<!-- show the hashtags -->
		 	<p>
		 		<span class="hashtags"><xsl:apply-templates select="hashtags/hashtag" /></span>
		 	</p>
		</div>
	 </div> <!-- end the hashtags. -->

 	<!-- gillamarkeringar och gillaknappen -->
 	<div class="row">
	 	<div class="col-xs-2 alignCenter">
	 		<xsl:variable name="post_id" select="@id"/>

		 	<p>
				<xsl:choose>
					<xsl:when test="../currentUser">
						<!-- check if you have liked the post? .likedPost -->
				 		<a href="../query/likePost.php?postID={$post_id}">
				 			<span type="submit" class="unliked like fa-2x fa fa-heart">
				 			<!-- if the logged in user has liked a post, make the heart red instead -->
				 			<xsl:if test="likes/like[@userid = ../../../currentUser/@id]">
				 				<xsl:attribute name="class">
				 				redHeart like fa fa-heart fa-2x
				 				</xsl:attribute>
				 			</xsl:if>
				 			</span>
				 		</a>
					</xsl:when>
					<xsl:otherwise>
						<span class="likeNotLoggedIn fa-2x fa fa-heart"></span>
					</xsl:otherwise>
				</xsl:choose>
		 	</p>
	 	</div>
	 	<div class="col-xs-10">
	 		<!-- om för många gilla-markeringar, visa bara hur många -->
			<p>
			<xsl:choose>
				<xsl:when test="count(likes/like) &gt; 5">	
					<xsl:value-of select="count(likes/like)" /> gilla-markeringar	
				</xsl:when>
				<xsl:when test="not(count(likes/like) = 0)">
					<xsl:apply-templates select="likes/like" /> gillar detta.
				</xsl:when>
			</xsl:choose>
			</p>
	 	</div>
 	</div>
 	</div>

 </xsl:template>
 <xsl:template match="likes/like">
 	<xsl:variable name="userID" select="@userid"/>
 	<a href="profile.php?id={$userID}">
 		<!-- if the current user that is logged in has liked a post, replace the username with "du" -->
 		<xsl:choose>
 			<xsl:when test="@userid = ../../../currentUser/@id">
 				du
 			</xsl:when>
 			<xsl:otherwise>
 				<xsl:value-of select="@username"/>
 			</xsl:otherwise>
 		</xsl:choose>
 	</a>
 	<!-- använder separator , men om nästa sista objektet ska och användas istället -->
 	<xsl:if test="not(position() = last() or position()=last()-1)">, </xsl:if>
 	<xsl:if test="position() = last()-1"> och </xsl:if>
 </xsl:template>

 <xsl:template match="hashtags/hashtag">
 	<xsl:variable name="search" select="."/> 
 	<small>
 		<span class="fa fa-hashtag"></span>
	 	<a href="../index.php?search={$search}">
	 		<xsl:value-of select="."/>
	 	</a>
 	</small>
 </xsl:template>

 <xsl:template match="currentUser">
	<p> Inloggad som <xsl:value-of select="@name"/></p>
	<xsl:if test="@authority = 0">
		<small><i><a href="../admin.php">adminsida</a></i></small>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
