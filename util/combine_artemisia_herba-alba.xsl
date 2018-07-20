<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="files_by_language" as="document-node()*">
        <xsl:sequence select="doc('../reading_views/latin/artemisia_herba-alba.html')"/>
        <xsl:sequence select="doc('../reading_views/italian/artemisia_herba-alba.html')"/>
        <xsl:sequence select="doc('../reading_views/german/artemisia_herba-alba.html')"/>
    </xsl:variable>
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Artemisia herba alba</title>
            </head>
            <body>
                <h1>Artemisia herba alba</h1>
                <xsl:for-each select="$files_by_language">
                    <div>
                        <h2>
                            <xsl:value-of
                                select="tokenize(document-uri(), '/')[position() eq last() - 1]"/>
                        </h2>
                        <xsl:copy-of select=".//ol"/>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
