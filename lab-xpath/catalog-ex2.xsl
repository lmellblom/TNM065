<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	
<!--Make a template which, within P-tags, writes the titles of all books
with the side condition that it is cheaper than 30 dollars  -->
	<xsl:template match="catalog/books/book[price[@value&lt;30]]"> 
		<p>
			<xsl:value-of select="@title"/>
		</p>
	</xsl:template> 
	

  		
</xsl:stylesheet>