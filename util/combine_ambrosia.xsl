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
        <xsl:sequence select="doc('../reading_views/latin/ambrosia.html')"/>
        <xsl:sequence select="doc('../reading_views/italian/ambrosia.html')"/>
        <xsl:sequence select="doc('../reading_views/german/ambrosia.html')"/>
        <xsl:sequence select="doc('../reading_views/english/ambrosia.html')"/>
        <xsl:sequence select="doc('../reading_views/french/ambrosia.html')"/>
    </xsl:variable>
  <!--  <xsl:variable name="mapping" as="document-node()" select="doc('mapping.html')"/>-->
   
   <!-- <xsl:variable name="table" select="$mapping//table[@data-plant eq $plant]"/>-->
	<!--  -->
	
    
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Ambrosia</title>
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
                <h1>Ambrosia</h1>
                <hr/>
                <div class="nav">
                    <a href="../index.html">Main</a> | <a>Ambrosia</a> | <a
                        href="artemisia_vulgaris.html">Artemisia Vulgaris</a> | <a
                        href="artemisia_tenuifolia.html">Artemisia Tenuifolia</a> | <a
                        href="botrys.html">Botrys</a>
                </div>
                <hr/>
                <div class="container">
                    <xsl:for-each select="1 to 5">
                        <xsl:variable name="current_file" as="document-node()" select="$files_by_language[current()]"/>
                    	<xsl:variable name="filename_parts" select="tokenize(document-uri($current_file), '/')"/>
                    	<xsl:variable name="plant" select="substring-before($filename_parts[last()], '.html')"/>
                    	<xsl:variable name="language" select="$filename_parts[position() eq last() - 1]"/>
                    	<xsl:variable name="pdfs" as="document-node()" select="doc('pic_urls.html')"/>
                    	<xsl:variable name="pdf_table" select="$pdfs//table[@data-plant eq $plant]"/>    
                    	<xsl:variable name="pdf_language_column" as="xs:integer"
                    		select="count($pdf_table/tr[1]/th[. eq $language]/preceding-sibling::th) + 1"/>
                    	<xsl:variable name="pdf_url" as="xs:string" select="$pdfs//table[@data-plant eq 'ambrosia']//td[position() = $pdf_language_column]"/>
                    	
                    	
                        <div class="cell item-{$letters[current()]}">
                            <h2>
                            	<a href="{$pdf_url}" target="popup" onclick="window.open('{$pdf_url}','popup','width=600,height=600'); return false;">
                                <xsl:value-of
                                    select="djb:title_case(tokenize(document-uri($current_file), '/')[position() eq last() - 1])"
                                />
                            	</a>
                            </h2>
                        	
                        	<!--<p><a href="{$pdf_url}" target="_blank">page scan</a></p>-->
                        	
                            <xsl:copy-of select="$current_file//ol"/>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
