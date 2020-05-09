<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:djb="http://www.obdurodon.org"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:use-package name="http://www.obdurodon.org/bezier"/>
    <xsl:variable name="points" as="xs:string"
        select="'50,182 100,166 150,87 200,191 250,106 300,73 350,60 400,186 450,118'"/>
    <xsl:variable name="debug" as="xs:boolean" select="true()"/>
    <xsl:template name="xsl:initial-template">
        <svg xmlns="http://www.w3.org/2000/svg" width="1000" viewBox="0 0 1000 1800"
            preserveAspectRatio="xMinYMin meet">
            <xsl:for-each select="0 to 9">
                <xsl:variable name="scaling" as="xs:double" select="current() div 10"/>
                <!-- small multiples with 5 rows and 2 columns -->
                <g transform="translate({(current() mod 2) * 500}, {(current() idiv 2) * 300})">
                    <!-- $debug is true in this driver, so choose only the <g> return -->
                    <xsl:sequence select="djb:bezier($points, $scaling, $debug)[1]"/>
                    <text x="250" y="250" text-anchor="middle">
                        <xsl:value-of
                            select="'djb:bezier#3, $scaling = ' || $scaling || ' with debug'"/>
                    </text>
                </g>
            </xsl:for-each>
            <g transform="translate(0, 1500)">
                <xsl:sequence select="djb:bezier($points, 0.3)"/>
                <text x="250" y="250" text-anchor="middle">djb:bezier#2, $scaling = 0.3</text>
            </g>
            <g transform="translate(500, 1500)">
                <xsl:sequence select="djb:bezier($points)"/>
                <text x="250" y="250" text-anchor="middle">djb:bezier#1, default $scaling
                    (0.4)</text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>