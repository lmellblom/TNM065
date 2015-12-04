<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
	<xsl:output indent="yes" method="xml"/>

<xsl:template match="blogposts">
<html>

<head>
	<meta charset="UTF-8" />

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />

	<link rel="stylesheet" href="style.css" />
	
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
	        xmlhttp.open("GET", "createForm.php?postID=" + postID);
	        xmlhttp.send();
		};
	</script>
	<title>TNM065 | moments</title>
</head>

<body>
	
	<div class="jumbotron">
		<div class="container">
			<a href="/"><h1>En rubrik</h1></a>
		</div>
	</div>

	<div class="container row allPosts"> <!-- wrapper -->

	<div class="container col-sm-8 posts">

		<!-- search, flytta denna senare.. -->
		<form class="form-inline" role="form" action="searchHashtags.php" method="POST">
		<div class="input-group">
		      <input type="search" class="form-control" name="search" placeholder="Search for hashtags.." />
		      <span class="input-group-btn">
		        <button type="submit" class="btn btn-default">Go!</button>
		      </span>
	    </div><!-- /input-group -->
	    </form>


		<h3>Feed</h3>
		<div id="showPosts">
			<!--<xsl:apply-templates select="post[author[@id=1]]" />-->
			<!--<xsl:apply-templates select="post[hashtags[hashtag[contains(text(), 'ta')]]]" />, väljer ut hashtags. -->
			<!--<xsl:apply-templates select="post[hashtags[hashtag[contains(text(), '')]]]" />-->
			<!-- check if post is empty, then write a text message instead -->
			<xsl:if test="search">
				<h4>Du sokte pa <xsl:value-of select="search"/></h4>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="count(post)=0">
					<p>Har var det tomt..</p>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="post" />
				</xsl:otherwise>
			</xsl:choose>			
		</div>

	</div>

	<div class="container col-sm-4">
		<!-- When the user is logged in, should be able to adding a post -->
		<xsl:choose>
		<xsl:when test="currentUser">
			<div class="userInfo">
			<p>Inloggad som <xsl:apply-templates select="currentUser" /> </p>
			
			<form class="form-horizontal" role="form" action="logOut.php" method="POST">
				<button type="submit" class="btn btn-default"><span class="fa fa-sign-out"></span> Logga ut</button>
			</form>
			</div>

		<div class="inputForm">
			<h3>Add post</h3>
			<!--<span id="validateMessage"></span>-->
			<form class="form-horizontal" name="postForm" role="form" action="addPost.php" method="POST">
			  <div class="form-group">
			    <input type="text" class="form-control" name="postTitle" placeholder="Title" required="true" />
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" name="postText" placeholder="What are you thinking about?" required="true" />
			  </div>
			  <div class="form-group">
			    <input type="text" class="form-control" name="postHashtags" placeholder="Hashtags, separate by spacing" />
			  </div>
			  <button type="submit" class="btn btn-default">Post</button>
			</form>
		</div>
		</xsl:when>
		<xsl:otherwise>
		<!-- When user not logged in, show to different forms. One for log in and one for add user -->
		<p>Logga in eller registrera dig och skriv magiska meningar!</p>
		<div class="inputForm">
			<h3>Logga in</h3>
			<form class="form-horizontal" name="signIn" action="logInUser.php" role="form" method="POST">
				<div class="form-group">
					<input type="text" class="form-control" name= "usr" placeholder="Username" required="true"/>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name= "pwd" placeholder="Password" required="true"/>
				</div>
				<button type="submit" class="btn btn-default"><span class="fa fa-sign-in"></span> Logga in</button>
			</form>
		</div>

		<div class="inputForm">
			<h3>Sign up!</h3>
			<form class="form-horizontal" name="signUp" action="addUser.php" role="form" method="POST">
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
		</xsl:otherwise>
		</xsl:choose>

	<!-- show all hashtags that are here. blir lite fel om man söker på user, får bara dess hahstags osv... -->
		<div>
			<h4>Alla hashtags</h4>
			<p><xsl:apply-templates select="post/hashtags/hashtag" /></p>
		</div>

		<!--<div>
			<h4>Alla dina uppdateringar</h4>
			<xsl:apply-templates select="post[author[@id= ../../currentUser/@id]]" />
		</div>-->

	</div><!-- end right column -->

	</div><!-- end wrapper -->

</body>
</html>
</xsl:template> 

<xsl:template match="currentUser">
	<!--ID: <xsl:value-of select="@id"/>, 
	Namn: <xsl:value-of select="@name"/>, 
	Admin? : <xsl:value-of select="@authority"/>-->
	<xsl:value-of select="@name"/>
	<xsl:if test="@authority = 0">
		<i> (admin)</i>
	</xsl:if>
</xsl:template>

 <xsl:template match="post">
 	<div class="row well well-sm" id="{generate-id(.)}">

		<div class="col-xs-2 alignCenter">
			<p class="text-center userInfo text-uppercase">
				<xsl:variable name="profileID" select="author/@id"/>
				<a href="?profile={$profileID}"><span class="fa fa-user"></span> <xsl:value-of select="author"/></a>
			</p>
			<img class="img-responsive userImage img-circle" src="img/user.png" alt="user" />
		</div>

		<div class="col-xs-10">
		 	<h4><xsl:value-of select="title"/></h4>
		 	<p><xsl:value-of select="text"/></p>
		 	<xsl:variable name="post_id" select="@id"/>
		 	<p>
		 		<!-- check if you have liked the post? .likedPost -->
		 		<a href="likePost.php?postID={$post_id}">
		 			<span type="submit" class="like fa fa-heart"> 
		 			<!-- if the loggen in user has liked a post, make the heart red instead -->
		 			<xsl:if test="likes/like[@userid = ../../../currentUser/@id]">
		 				<xsl:attribute name="class">
		 				redHeart like fa fa-heart
		 				</xsl:attribute>
		 			</xsl:if>
		 		
		 			</span>
		 		</a>
		 		<xsl:value-of select="count(likes/like)" />
		 	</p>
		 	<p>Vilka har gillat: <xsl:apply-templates select="likes/like" /></p>
		 	<p><span class="hashtags"><xsl:apply-templates select="hashtags/hashtag" /></span></p>

		 	<!-- edit and remove buttons! -->
		 	<xsl:if test="author/@id = ../currentUser/@id or ../currentUser/@authority = 0">
		 		<p class="pull-right">
		 			<a onclick="showForm('{generate-id(.)}', '{$post_id}')"><span class="fa fa-pencil"></span> edit </a>
		 			<a href="updateOrDeletePost.php?delete={$post_id}"><span class="fa fa-times"></span> delete </a>
		 		</p>
		 	</xsl:if>

		 	<!-- vilket datum -->
		 	<p>
		 		<span class="fa fa-clock-o"></span> <i><xsl:value-of select="publish_date" /></i>
		 	</p>
	 	</div>
 	</div>
 </xsl:template>

 <xsl:template match="likes/like">
 	<xsl:variable name="userID" select="@userid"/>
 	<a href="?profile={$userID}"><xsl:value-of select="@username"/></a>
 	<xsl:if test="not(position() = last())">, </xsl:if>
 </xsl:template>

 <xsl:template match="hashtags/hashtag">
 	<small><span class="fa fa-hashtag"></span> <xsl:value-of select="."/></small>
 </xsl:template>

</xsl:stylesheet>
