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

<!-- task 6 -->
<xsl:template match="euclides">
  <!-- make sure that tal1 > tal2-->
  <xsl:variable name="tal1">
    <xsl:choose>
    <xsl:when test="term[1] &gt; term[2]">
      <xsl:value-of select="term[1]" />
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="term[2]" />
    </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="tal2">
    <xsl:choose>
    <xsl:when test="term[1] &gt; term[2]">
      <xsl:value-of select="term[2]" />
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="term[1]" />
    </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!-- call the template -->
  <xsl:call-template name="euclidean">
    <xsl:with-param name="x" select="$tal1"/>
    <xsl:with-param name="y" select="$tal2"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="euclidean">
  <xsl:param name="x"/>
  <xsl:param name="y"/>

  <!-- if the div = 0, take the rest x. else take the rest of x mod y again.. -->
  <xsl:choose>
    <xsl:when test="$y = 0"><xsl:value-of select="$x" /></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="euclidean">
        <xsl:with-param name="x" select="$y"/>
        <xsl:with-param name="y" select="$x mod $y"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- task 5 -->
<!-- the algorithm will split the the string in half and then recursive call and divide in half again etc. -->
<xsl:template match="reverse">
  <xsl:call-template name="reverseString">
  <xsl:with-param name="string" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="reverseString">
  <xsl:param name="string"/>
  <xsl:variable name="len" select="string-length($string)" /> <!-- the length of the string -->
  <xsl:choose>
    <xsl:when test="$len &lt; 2"><xsl:value-of select="$string" /></xsl:when> <!--lesss 2 characters, just select the string-->
    <xsl:when test="$len = 2"> <!-- 2 characters, just reverse  -->
      <xsl:value-of select="substring($string,2,1)" />
      <xsl:value-of select="substring($string,1,1)" />
    </xsl:when>
    <!-- otherwise just call the template again -->
    <xsl:otherwise>
      <xsl:variable name="swapPoint" select="floor($len div 2)" />
      <xsl:call-template name="reverseString">
         <xsl:with-param name="string" select="substring($string, $swapPoint+1)"/>
      </xsl:call-template>
       <xsl:call-template name="reverseString">
         <xsl:with-param name="string" select="substring($string, 1,$swapPoint)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- task 4 -->
<xsl:template match="fib">
  <xsl:call-template name="fibonacci">
    <xsl:with-param name="n" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="fibonacci">
  <xsl:param name="n"/>
  <xsl:choose>
    <xsl:when test="$n = 0">0</xsl:when>
    <xsl:when test="$n = 1">1</xsl:when>
    <xsl:otherwise>
      <xsl:variable name="fib1">
        <xsl:call-template name="fibonacci">
          <xsl:with-param name="n" select="$n -1"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="fib2">
        <xsl:call-template name="fibonacci">
          <xsl:with-param name="n" select="$n -2"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$fib1 + $fib2" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- task 3 -->
<xsl:template match="fact">
  <xsl:call-template name="factorial">
    <xsl:with-param name="n" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="factorial">
  <xsl:param name="n"/>
  <xsl:variable name="sum">
    <xsl:choose> <!-- choose if return 0, or recursive call the template again -->
      <xsl:when test="$n = 1">1</xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="factorial">
          <xsl:with-param name="n" select="$n -1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:value-of select="$sum * $n"/> <!-- the sum and then multiply with n. -->
</xsl:template>

<!-- task 2 -->
<xsl:template match="times">
  <xsl:call-template name="multiplying">
    <xsl:with-param name="times1" select="*[1]"/> <!-- first element node independent of what the name is -->
    <xsl:with-param name="times2" select="*[2]"/>
  </xsl:call-template>
</xsl:template>

<!-- multiplying -->
<xsl:template name="multiplying">
  <xsl:param name="times1"/>
  <xsl:param name="times2"/>
  
  <xsl:value-of select="$times1 * $times2"/>
</xsl:template>

</xsl:stylesheet>
