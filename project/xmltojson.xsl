<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" omit-xml-declaration="yes" method="text" encoding="UTF-8" media-type="text/x-json"/>

<xsl:template match="blogposts">
{	"blogposts": {	
		<xsl:if test="search">
			"search" : "<xsl:value-of select="search" />",
		</xsl:if>
		<xsl:if test="currentUser">
		"currentUser" : {
			<xsl:for-each select="currentUser">
				<xsl:for-each select="@*">
				"<xsl:value-of select="name(.)"/>" : "<xsl:value-of select="."/>"
				<xsl:if test="not(position() = last())" >,</xsl:if>
				</xsl:for-each>
    		</xsl:for-each>
		},
		</xsl:if>
		"post": [
		<!-- go trough every post (child) and select the name of is and the value -->
		<xsl:for-each select="post" >
			{
				"id" : <xsl:value-of select="@id"/>, 
				<xsl:apply-templates select="title"/>,
				<xsl:apply-templates select="text"/>,
				<xsl:apply-templates select="publish_date"/>,
				<xsl:apply-templates select="author"/>
				<xsl:apply-templates select="hashtags"/>
				<xsl:apply-templates select="likes"/>
			}
			<xsl:if test="not(position() = last())" >,</xsl:if>
		</xsl:for-each>
		]
	}
}
</xsl:template>

<xsl:template match="title">
	 "<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>"
</xsl:template>
<xsl:template match="text">
	 "<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>"
</xsl:template>
<xsl:template match="publish_date">
	 "<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>"
</xsl:template>
<xsl:template match="author">
	"<xsl:value-of select="name(.)"/>" : {
		<xsl:apply-templates select="*"/>
		<xsl:apply-templates select="@*"/>
	}
	<xsl:if test="../hashtags">,</xsl:if>
</xsl:template>

<xsl:template match="hashtags">
	"hashtags" : [
  	<xsl:for-each select="hashtag">
  		{
  		"<xsl:value-of select="name(.)"/>" :
			"<xsl:value-of select="."/>"
		}<xsl:if test="not(position() = last())" >,</xsl:if>
	</xsl:for-each>
  	]<xsl:if test="../likes">,</xsl:if>
</xsl:template>

<xsl:template match="likes">
	"likes" : [
  	<xsl:for-each select="like">
  		{
  		"<xsl:value-of select="name(.)"/>" : {
			<xsl:apply-templates select="@*"/>
		}
  		<!--"<xsl:value-of select="name(.)"/>": "<xsl:value-of select="."/>"-->
		}<xsl:if test="not(position() = last())" >,</xsl:if>
  	</xsl:for-each>
  	]
</xsl:template>

<!-- for attirbutes -->
<xsl:template match="@*">
	"<xsl:value-of select="name(.)"/>": "<xsl:value-of select="."/>"
	<xsl:if test="not(position() = last())" >,</xsl:if>
</xsl:template>

<!-- for regular values inside tag -->
 <xsl:template match="*">
    "<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>"
		<xsl:if test="not(position() = last())" >,</xsl:if>
</xsl:template>
</xsl:stylesheet>