<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	
<!--Make a template which matches "/" and, within a P-tag,
writes the number of books with genre Computer with a price less than 40 dollars
  -->
  <xsl:template match="/"> 
  	<p>
  		<xsl:value-of select="count(catalog/books/book[type[@genre='Computer']][price[@value&lt;40]])" />
  	</p>
  </xsl:template> 
	

  		
</xsl:stylesheet>