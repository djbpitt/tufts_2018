<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    xmlns:functx="http://www.xsltfunctions.com" 
    exclude-result-prefixes="#all"
    version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<!--  -->
	<!-- functions -->
	<!-- get info from path -->
    <xsl:function name="djb:tokenize-filename" as="xs:string">
        <xsl:param name="input"/>
        <xsl:sequence
            select="substring-after($input, '/tt/') => tokenize('/') => string-join(': ') => substring-before('.tt')"
        />
    </xsl:function>
	<xsl:function name="functx:trim" as="xs:string">
		<xsl:param name="arg" as="xs:string?"/>
		<xsl:sequence select="
			replace(replace($arg,'\s+$',''),'^\s+','')
			"/>
	</xsl:function>
	
	
	
	
	<!--  -->
	
	<!-- variables -->
    <xsl:variable name="header" as="xs:string" select="djb:tokenize-filename(document-uri(.))"/>
	<xsl:variable name="plantName" as="xs:string" select="//@scientific-name"/>
	<xsl:variable name="planName-norm" as="xs:string">
		<xsl:value-of select="concat(upper-case(substring($plantName,1,1)),substring($plantName,2))"/>
	</xsl:variable>
	<xsl:variable name="language" select="substring-before($header,':')"/>
	<!--  -->
	<!-- templates -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="$header"/>
                </title>
            </head>
            <body>
                <h1>
                	<xsl:value-of select="$planName-norm"/>
                </h1>
            	<dl>
            		<dt>Language: </dt>
            		<dd><xsl:value-of select="$language"/></dd>
            		<xsl:apply-templates select="/meta/@*"/>
            	</dl>
                <ol>
                    <xsl:apply-templates select="//sentence"/>
                </ol>
            </body>
        </html>
    </xsl:template>
	
    <xsl:template match="sentence">
        <li>
        	<xsl:value-of select="replace(functx:trim(normalize-space(.)),'(.*)(\s)(\.)','$1$3')"/>
        </li>
    </xsl:template>
	
	<xsl:template match="meta/@*">
		<dt><xsl:value-of select="local-name(.)"/></dt>
		<dd><xsl:value-of select="."/></dd>
	</xsl:template>
	<xsl:template match="meta/@scientific-name"/>
		
</xsl:stylesheet>
