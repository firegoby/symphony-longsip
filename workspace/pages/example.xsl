<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="jQueryVersion" select="'2.1.1'"/>

  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="no" media-type="text/html" />

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes"><![CDATA[<!doctype html>]]></xsl:text>
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta http-equiv="cleartype" content="on" />
        <title></title>
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="/workspace/build/main.css" />
        <script src="/workspace/vendor/platform.js"></script>
        <link rel="import" href="/workspace/build/components.min.html" />
      </head>
      <body>
        <!-- content -->
        <h1><xsl:value-of select="/data/params/page-title"/></h1>
        <p class="checklist">Polymer loaded <core-icon icon="done"></core-icon></p>
        <!-- EO content -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/{$jQueryVersion}/jquery.min.js"></script>
        <script><![CDATA[window.jQuery || document.write('<script src="/workspace/vendor/jquery-]]><xsl:value-of select="$jQueryVersion"/><![CDATA[.min.js">\x3C/script>')]]></script>
        <script src="/workspace/build/bundle.js"></script>
      </body>
    </html>
  </xsl:template>

  <!-- strip whitespace from HTML output -->
  <xsl:strip-space elements="*"/>

</xsl:stylesheet>
