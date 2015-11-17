<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	
	
<!--Make a template which matches all books older than 2006 having the genre Computer.
Then write the titles of the corresponding books within P-tags  -->
	<xsl:template match="catalog/books/book[type[@genre='Computer']][publish_date[@year&lt;2006]]">
		<p>
			<xsl:value-of select="@title"/>
		</p>
	</xsl:template> 
	
	

  		
</xsl:stylesheet>