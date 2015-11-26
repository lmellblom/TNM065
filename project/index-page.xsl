<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
	<xsl:output indent="yes" method="xml"/>

<xsl:template match="blogposts">
<html>

<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" />
	<link rel="stylesheet" href="style.css" />
	<script>
		function addLike(test){
			console.log("like");
			console.log(test);
			// like ska ju ändra i databasen.. 
		}
	</script>
	<title>TNM065 | moments</title>
</head>

<body>
	
	<div class="jumbotron">
		<div class="container">
			<h1>Moments</h1>
		</div>
	</div>

	<div class="container row allPosts">

	<div class="container col-sm-8 posts">
		<h3>Feed</h3>
		<xsl:apply-templates select="post" />
	</div>

	<div class="container col-sm-4 inputForm">
		<h3>Add post</h3>
		<span id="validateMessage"></span>
		<form class="form-horizontal" name="addOnePost" role="form" action="addPost.php" method="POST">
		  <div class="form-group">
		    <input type="text" class="form-control" name="postTitle" placeholder="Title" />
		  </div>
		  <div class="form-group">
		    <input type="text" class="form-control" name="postText" placeholder="What are you thinking about?" />
		  </div>
		  <div class="form-group">
		    <input type="text" class="form-control" name="postHashtags" placeholder="Hashtags, separate by spacing" />
		  </div>
		  <button type="submit" class="btn btn-default">Post</button>
		</form>
	</div>

	</div>

</body>
</html>
</xsl:template> 

 <xsl:template match="post">
 	<div class="row well well-sm">
	<div class="col-xs-2 alignCenter">
		<p class="text-uppercase"><xsl:value-of select="author"/></p>
		<img class="img-responsive userImage img-circle" src="img/user.png" alt="user" />
	</div>
	<div class="col-xs-10">
	 	<h4><xsl:value-of select="title"/></h4>
	 	<p><xsl:value-of select="text"/></p>
	 	<xsl:variable name="post_id" select="@id"/>
	 	<p><span class="like fa fa-heart" onclick="addLike('{$post_id}')"></span><xsl:value-of select="numberOfLikes"/></p>
	 	<span class="hashtags"><xsl:apply-templates select="hashtags/hashtag" /></span>
 	</div>
 	</div>
 </xsl:template>

 <xsl:template match="hashtags/hashtag">
 	<small>#<xsl:value-of select="."/></small>
 </xsl:template>

</xsl:stylesheet>
