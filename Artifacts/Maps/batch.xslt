<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="xml" indent="yes"/>

  <xsl:param name="batchSize" select="50"/>
  
  <xsl:template match="/*">
    <root>
    <xsl:apply-templates select="orders[position() mod $batchSize = 1]"/>
    </root>
  </xsl:template>

  <xsl:template match="orders">
      <batch>
        <xsl:apply-templates mode="inbatch" select=
        ". | following-sibling::orders[not(position() > $batchSize -1)]"/>
      </batch>
  </xsl:template>

  <xsl:template match="orders" mode="inbatch">
    <orders>
      <order>
        <xsl:value-of select="order"></xsl:value-of>
      </order>
      <sku>
        <xsl:value-of select="sku"></xsl:value-of>
      </sku>
      <warehouse>
        <xsl:value-of select="warehouse"></xsl:value-of>
      </warehouse>
    </orders>
  </xsl:template>
</xsl:stylesheet>
