<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:function name="djb:tokenize-filename" as="xs:string">
        <xsl:param name="input"/>
        <xsl:sequence
            select="substring-after($input, '/tt/') => tokenize('/') => string-join(': ') => substring-before('.tt')"
        />
    </xsl:function>
    <xsl:variable name="header" as="xs:string" select="djb:tokenize-filename(document-uri(.))"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="$header"/>
                </title>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="$header"/>
                </h1>
                <ol>
                    <xsl:apply-templates select="//sentence"/>
                </ol>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="sentence">
        <li>
            <xsl:value-of select="normalize-space(.)"/>
        </li>
    </xsl:template>
</xsl:stylesheet>
