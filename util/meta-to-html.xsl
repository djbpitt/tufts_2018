<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:function name="djb:title_case" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="upper-case(substring($input, 1, 1)) || substring($input, 2)"/>
    </xsl:function>
    <xsl:variable name="filename" as="xs:string" select="tokenize(document-uri(), '/')[last()]"/>
    <xsl:variable name="language" as="xs:string"
        select="djb:title_case(substring-before($filename, '_'))"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="$language"/>
                </title>
                <link rel="stylesheet" type="text/css" href="../site.css"/>
                <link rel="stylesheet" type="text/css" href="meta.css"/>
            </head>
            <body>
                <div class="nav">
                    <a href="../index.html">Main</a> | <a href="../ambrosia.html">Ambrosia</a> | <a
                        href="../artemisia_vulgaris.html">Artemisia Vulgaris</a> | <a
                        href="../artemisia_tenuifolia.html">Artemisia Tenuifolia</a> | <a
                        href="../botrys.html">Botrys</a>
                </div>
                <h1>
                    <xsl:value-of select="$language || ' metadata'"/>
                </h1>
                <table>
                    <xsl:apply-templates select="meta/*"/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="meta/*">
        <tr>
            <th>
                <xsl:value-of select="djb:title_case(name())"/>
            </th>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
