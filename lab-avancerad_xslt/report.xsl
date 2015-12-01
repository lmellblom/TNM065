<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="report">
  <html>
    <p>Modifiera filen 'report.xsl' så att transformationen av 'report.xml' ger samma resultat som 'report.html'.  </p>
  </html>
</xsl:template>
</xsl:stylesheet>


