<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="report">
  <html>
    <h1>TNM065 Dokumentstrukturer</h1>

    <p>Authors: <xsl:apply-templates select="head/authors/author" /></p>
    <p>Keywords: <xsl:apply-templates select="head/keywords/keyword" /></p>
  	
	<!-- innehållsförteckninge -->
	<p>
	<xsl:for-each select="body/h1">
		<xsl:number level="multiple" count="h1" format="1.1. "/>
		<a href="#{generate-id(@title)}">
			<xsl:value-of select="@title" />
		</a>
		<br />
		<xsl:for-each select="h2">
			<xsl:number level="multiple" count="h1 | h2" format="1.1. "/>
			<a href="#{generate-id(@title)}">
				<xsl:value-of select="@title" />
			</a>
			<br />
			<xsl:for-each select="h3">
				<xsl:number level="multiple" count="h1 | h2 | h3" format="1.1. "/>
				<a href="#{generate-id(@title)}">
					<xsl:value-of select="@title" />
				</a>
				<br />
			</xsl:for-each>
		</xsl:for-each>
	</xsl:for-each>
	</p>

	<!-- går att köra mer templates också men blev ganska mkt kod också -->
	<xsl:for-each select="body/h1">
		<a name="{generate-id(@title)}"></a>
		<h2>
			<xsl:number level="multiple" count="h1" format="1.1. "/> <!-- skriver ut rätt format på siffrorna -->
			<xsl:value-of select="@title" />
		</h2>
		<xsl:apply-templates select="p" />
		
		<xsl:for-each select="h2">
			<a name="{generate-id(@title)}"></a>
			<h3>
				<xsl:number level="multiple" count="h1 | h2" format="1.1. "/>
				<xsl:value-of select="@title" />
			</h3>
			<xsl:apply-templates select="p" />

			<xsl:for-each select="h3">
				<a name="{generate-id(@title)}"></a>
				<h4>
					<xsl:number level="multiple" count="h1 | h2 | h3" format="1.1. "/>
					<xsl:value-of select="@title" />
				</h4>
				<xsl:apply-templates select="p" />
			</xsl:for-each>
		</xsl:for-each>
	</xsl:for-each>

  </html>
</xsl:template>


<xsl:template match="head/authors/author">
	<xsl:value-of select="." />
	<xsl:if test="not(position() = last())">, </xsl:if>
</xsl:template>

<xsl:template match="head/keywords/keyword">
	<xsl:value-of select="." />
	<xsl:if test="not(position() = last())">, </xsl:if>
</xsl:template>

<xsl:template match="p">
	<p><xsl:value-of select="." /></p>
</xsl:template>

</xsl:stylesheet>


