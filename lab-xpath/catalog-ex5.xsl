<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	
<!--Make a template which matches "/" and, within a P-tag, writes the sum of the prices of 
the books with genre Computer
  -->
    <xsl:template match="/"> 
  	<p>
  		<xsl:value-of select="sum(catalog/books/book[type[@genre='Computer']]/price/@value)" />
  	</p>
  </xsl:template> 
	

  		
</xsl:stylesheet>