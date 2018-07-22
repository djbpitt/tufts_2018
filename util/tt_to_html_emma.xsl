<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:djb="http://www.obdurodon.org" 
	xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
	xmlns:functx="http://www.xsltfunctions.com" exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<!--  -->
	<!-- functions -->
	<!-- get info from path -->
	<xsl:function name="djb:tokenize-filename" as="xs:string">
		<xsl:param name="input"/>
		<xsl:sequence select="substring-after($input, '/tt/') => tokenize('/') => string-join(': ') => substring-before('.tt')"/>
	</xsl:function>
	<xsl:function name="functx:trim" as="xs:string">
		<xsl:param name="arg" as="xs:string?"/>
		<xsl:sequence select="replace(replace($arg, '\s+$', ''), '^\s+', '')"/>
	</xsl:function>
	<!--  -->
	<!-- variables -->
	
	<xsl:variable name="header" as="xs:string" select="djb:tokenize-filename(document-uri(.))"/>
	<xsl:variable name="plantName" as="xs:string" select="//@scientific-name"/>
	<xsl:variable name="planName-norm" as="xs:string">
		<xsl:value-of select="concat(upper-case(substring($plantName, 1, 1)), substring($plantName, 2))"/>
	</xsl:variable>
	<xsl:variable name="language" select="substring-before($header, ':')"/>
	<!--  -->
	<!-- templates -->
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="$header"/>
				</title>
				<style>
					html {
						line-height: 1.4;
					}
					dl,
					ol {
						border: 3px double #ededed;
						margin: 1.4rem;
						padding: 1.4rem;
					}
					dl {
						line-height: 0.7
					}
					dt {
						float: left;
						clear: left;
						width: 100px;
						text-align: right;
						font-weight: bold;
						color: green;
					}
					dt::after {
						content: ":";
					}
					dd {
						margin: 0 0 0 110px;
						padding: 0 0 0.5em 0;
					}
					
					li {
						margin: 0 2.8rem;
					}
					h1,
					h2 {
						margin: 0 1.4rem;
					}
					h1 {
						margin-top: 2.8rem;
					}
					h2 {
						margin-top: 1.4rem;
					}
				</style>
			</head>
			<body>
				<h1>
					<xsl:value-of select="$planName-norm"/>
				</h1>
				<h2>Metadata</h2>
				<dl>
					<dt>Language: </dt>
					<dd>
						<xsl:value-of select="$language"/>
					</dd>
					<xsl:apply-templates select="/meta/@*"/>
				</dl>
				<h2>Transcription</h2>
				<ol>
					<xsl:apply-templates select="//sentence|//sentences"/>
				</ol>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="sentence|sentences">
		<li>
			<xsl:value-of select="replace(functx:trim(normalize-space(.)), '(.*)(\s)(\.)', '$1$3')"/>
		</li>
	</xsl:template>
	<xsl:template match="meta/@*">
		<dt>
			<xsl:value-of select="local-name(.)"/>
		</dt>
		<dd>
			<xsl:value-of select="."/>
		</dd>
	</xsl:template>
	<xsl:template match="meta/@scientific-name"/>
	<xsl:template match="meta/@abbreviation"/>
	<xsl:template match="meta/@sex"/>
</xsl:stylesheet>
