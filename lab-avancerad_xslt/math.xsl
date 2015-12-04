<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template match="/">
    <html>
      <head>
        <title>Extralaboration 4</title>
      </head>
      <body>
        <xsl:apply-templates/>

      </body>
    </html>
  </xsl:template>
  
<xsl:template match="h1">
    <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="times">
  <xsl:call-template name="multiplying">
    <xsl:with-param name="times1" select="p1"/>
    <xsl:with-param name="times2" select="p2"/>
  </xsl:call-template>
</xsl:template>


<!-- multiplying -->
<xsl:template name="multiplying">
  <xsl:param name="times1"/>
  <xsl:param name="times2"/>
  
  <xsl:value-of select="$times1 * $times2"/>
</xsl:template>

</xsl:stylesheet>
