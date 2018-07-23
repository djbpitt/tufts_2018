<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:function name="djb:title_case" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="upper-case(substring($input, 1, 1)) || substring($input, 2)"/>
    </xsl:function>
    <xsl:variable name="letters" as="xs:string+"
        select="
            for $i in string-to-codepoints('abcdef')
            return
                codepoints-to-string($i)"/>
    <xsl:variable name="files_by_language" as="document-node()+">
        <xsl:sequence select="doc('../reading_views/latin/botrys.html')"/>
        <xsl:sequence select="doc('../reading_views/italian/botrys.html')"/>
        <xsl:sequence select="doc('../reading_views/german/botrys.html')"/>
        <xsl:sequence select="doc('../reading_views/english/botrys.html')"/>
        <xsl:sequence select="doc('../reading_views/french/botrys.html')"/>
    </xsl:variable>
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Botrys</title>
                <script src="scripts.js">/**/</script>
                <link rel="stylesheet" href="../site.css" type="text/css"/>
                <link href="https://fonts.googleapis.com/css?family=Libre+Baskerville"
                    rel="stylesheet"/>
                <style type="text/css">
                    h1 {
                        margin: 1em;
                    }
                    .nav {
                        text-align: center;
                    }
                    .nav a {
                        display: inline !important;
                    }</style>
            </head>
            <body class="flower">
                <h1>Botrys</h1>
                <hr/>
                <div class="nav">
                    <a href="../index.html">Main</a> | <a href="ambrosia.html">Ambrosia</a> | <a
                        href="artemisia_vulgaris.html">Artemisia Vulgaris</a> | <a
                        href="artemisia_tenuifolia.html">Artemisia Tenuifolia</a> | <a>Botrys</a>
                </div>
                <hr/>
                <div class="container">
                    <xsl:for-each select="1 to 5">
                        <xsl:variable name="current_file" as="document-node()"
                            select="$files_by_language[current()]"/>
                        <div class="cell item-{$letters[current()]}">
                            <h2>
                                <xsl:value-of
                                    select="djb:title_case(tokenize(document-uri($current_file), '/')[position() eq last() - 1])"
                                />
                            </h2>
                            <xsl:copy-of select="$current_file//ol"/>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
