<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	
<!--Make a template which writes the titles of all books,
enclosed within P-tags -->
	<xsl:template match="catalog/books/book"> 
		<p>
			<xsl:value-of select="@title"/>
		</p>
	</xsl:template> 
	

  		
</xsl:stylesheet>