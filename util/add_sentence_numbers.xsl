<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:variable name="mapping" as="document-node()" select="doc('mapping.html')"/>
    <xsl:variable name="filename_parts" select="tokenize(document-uri(), '/')"/>
    <xsl:variable name="plant" select="substring-before($filename_parts[last()], '.tt')"/>
    <xsl:variable name="language" select="$filename_parts[position() eq last() - 1]"/>
    <xsl:variable name="table" select="$mapping//table[@data-plant eq $plant]"/>
    <xsl:variable name="language_column" as="xs:integer"
        select="count($table/tr[1]/th[. eq $language]/preceding-sibling::th) + 1"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="li">
        <xsl:variable name="sentence_no" select="count(preceding-sibling::li) + 1" as="xs:integer"/>
        <xsl:message select="'Language: ' || $language"/>
        <xsl:message select="'Language column: ' || $language_column"/>
        <xsl:message select="'Plant: ' || $plant"/>
        <xsl:message select="'Sentence no: ' || $sentence_no"/>
        <xsl:copy>
            <xsl:attribute name="class"
                select="$table/tr[td[position() eq $language_column]/number() eq $sentence_no]/td[1] ! concat('p',.)"/>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
