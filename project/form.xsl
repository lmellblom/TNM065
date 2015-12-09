<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:php="http://php.net/xsl">

   <xsl:template match="form">
		<form class="postForm" action="updateOrDeletePost.php?postID={postID}" method="POST">
			<div class="form-group">
			    <input type="text" class="form-control" name="postTitle" value="{title}" required="true" />
			</div>
			<div class="form-group">
			    <input type="text" class="form-control" name="postText" value="{text}" required="true" />
			</div>
			<div class="form-group">
			    <input type="text" class="form-control" name="postHashtags" value="{hashtags}" />
			</div>
			<button type="submit" class="btn btn-default">Update</button>
			<a href="index.php" class="btn btn-default">Cancel</a> <!-- kanske göra något annat här, inte så bra lösning.  -->
		</form>
   </xsl:template>

</xsl:stylesheet>