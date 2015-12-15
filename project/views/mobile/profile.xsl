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
		function changePic(userID){
			// get the value from the form? 
			var picID = document.querySelector('input[name=profile-pic]:checked').value;
			// use ajax to update the database!!

			var xmlhttp = new XMLHttpRequest();
	        xmlhttp.onreadystatechange = function() {
	            if (xmlhttp.readyState == 4) {
	            	if(xmlhttp.status == 200){
	                	// change the picture
						document.getElementById('userimage').src = "../img/user/" + picID + ".jpg";
	                }
	            }
	        }
	        xmlhttp.open("GET", "/query/changePic.php?picture=" + picID);
	        xmlhttp.send();
		};
	</script>
	<title>TNM065 | moments</title>
</head>

<body>
	
<div class="jumbotron">
		<div class="container centerAligned">
			<div>
				<p>
					<a href="/">
						<img class="logo img-responsive" src="/img/logo.png" alt="logo" /><!--<h1>Moments</h1>-->
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
				<a class="btn btn-default" href="/login.php"><span class="fa fa-sign-in"></span> Logga in eller registrera</a>
			</xsl:if>
			</div>
		</div>
	</div>

	<div class="container row allPosts"> <!-- wrapper -->

	<div class="profileInfo">
		<!-- visa här mer information om profilen som du tittar på -->
		<h3 class="text-capitalize"><xsl:value-of select="profile/@name"/>s feed</h3>
		<xsl:variable name="picID" select="profile/@picid"/>
		<img id="userimage" src="../img/user/{$picID}.jpg" alt="user" />

		<p>Antal poster: <xsl:value-of select="count(post)" /></p>

		<!-- om du är den som är inloggad ska du kunna välja profilbild typ? -->
		<xsl:if test="currentUser/@id = profile/@id">
			<h4>Välj vilken profilbild</h4>
			<form id="imageChoose">
			<div class="cc-selector">
		        <input checked="checked" id="profile1" type="radio" name="profile-pic" value="1" />
		        <label class="drinkcard-cc profile1" for="profile1" />
		    </div>
		    <div class="cc-selector">
		        <input id="profile4" type="radio" name="profile-pic" value="4" />
		        <label class="drinkcard-cc profile4" for="profile4" />
		    </div>
		    <div class="cc-selector">
		        <input id="profile3" type="radio" name="profile-pic" value="3" />
		        <label class="drinkcard-cc profile3" for="profile3" />
		    </div>
		     <div class="cc-selector">
		        <input id="profile5" type="radio" name="profile-pic" value="5" />
		        <label class="drinkcard-cc profile5" for="profile5" />
		    </div>
		    </form>
			<xsl:variable name="userID" select="currentUser/@id"/>
			
			<a class="btn btn-default btn-sm" onclick="changePic({$userID})">Spara val</a>
		</xsl:if>
	</div>

	<div class="posts">
		<div id="showPosts">
			<!--<xsl:apply-templates select="post[author[@id=1]]" />-->
			<!--<xsl:apply-templates select="post[hashtags[hashtag[contains(text(), 'ta')]]]" />, väljer ut hashtags. -->
			<!--<xsl:apply-templates select="post[hashtags[hashtag[contains(text(), '')]]]" />-->
			<!-- check if post is empty, then write a text message instead -->
			<xsl:if test="search">
				<h4>Du sökte pa <xsl:value-of select="search"/></h4>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="count(post)=0">
					<p>Här var det tomt..</p>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="post" />
				</xsl:otherwise>
			</xsl:choose>			
		</div>

	</div>

	<!-- show all hashtags that are here. blir lite fel om man söker på user, får bara dess hahstags osv... -->
		<div>
			<h4>Alla hashtags som <span class="text-capitalize"><xsl:value-of select="profile/@name"/></span> använt</h4>
			<!-- show all the hashtags that the user have used and also how often they have occured -->
     		<xsl:for-each select="post/hashtags/hashtag">
     			<xsl:sort select="count(//hashtag[text()=current()/text()])" order='descending'/>
		        <xsl:if test="not(preceding::hashtag[text() = current()/text()])">
		        	<xsl:variable name="search" select="."/>
		            <small><span class="fa fa-hashtag"></span> <a href="../index.php?search={$search}"><xsl:value-of select="."/></a> (<xsl:value-of select="count(//hashtag[text()=current()/text()])"/>)</small>
		        </xsl:if>
		    </xsl:for-each>
		</div>

	</div><!-- end wrapper -->


	<!-- footer -->
	<div class="jumbotron" id="footer">
	</div>

</body>
</html>
</xsl:template> 

<xsl:template match="currentUser">
	<!--ID: <xsl:value-of select="@id"/>, 
	Namn: <xsl:value-of select="@name"/>, 
	Admin? : <xsl:value-of select="@authority"/>-->
	<p> Inloggad som <xsl:value-of select="@name"/></p>
	<xsl:if test="@authority = 0">
		<small><i><a href="../admin.php">adminsida</a></i></small>
	</xsl:if>
</xsl:template>

<xsl:template match="post">
 	<div class="well well-sm" id="{generate-id(.)}">

	<div class="row posts">
		<!--<div class="col-xs-2 alignCenter">
			<xsl:variable name="picID" select="author/@picid"/>
			<img class="img-responsive img-circle" src="../img/user/{$picID}.jpg" alt="user" />
		</div>-->

		<div class="col-xs-12">
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
	 	<div class="col-xs-12">
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

</xsl:stylesheet>
