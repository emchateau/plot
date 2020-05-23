<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://www.obdurodon.org/function-variables"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns:djb="http://www.obdurodon.org" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!--
       https://math.stackexchange.com/questions/335226/convert-segment-of-parabola-to-quadratic-bezier-curve 
    -->
    <xsl:function name="djb:compute-Y" as="xs:double">
        <!-- ============================================================ -->
        <!-- djb:compute-Y#2                                              -->
        <!-- ============================================================ -->
        <xsl:param name="f:x" as="xs:double"/>
        <xsl:param name="f:a" as="xs:integer"/>
        <xsl:param name="f:c" as="xs:double"/>
        <xsl:sequence select="$f:a * math:pow($f:x, 2) + $f:c"/>
    </xsl:function>
    <xsl:function name="djb:compute-half-parabola" as="xs:string">
        <xsl:param name="f:maxX" as="xs:integer"/>
        <xsl:variable name="P1" as="xs:string" select="concat('M0,', -1 * $f:maxX)"/>
        <xsl:variable name="C" as="xs:string" select="concat('Q', $f:maxX div 2, ',', -1 * $f:maxX)"/>
        <xsl:variable name="P2" as="xs:string" select="concat($f:maxX, ',0')"/>
        <xsl:sequence select="string-join(($P1, $C, $P2), ' ')"/>
    </xsl:function>
    <xsl:template name="xsl:initial-template">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-110 -110 220 220">
            <!-- axes -->
            <line x1="-100" y1="0" x2="100" y2="0" stroke="lightgray" stroke-width="0.5"/>
            <line x1="0" y1="-100" x2="0" y2="100" stroke="lightgray" stroke-width="0.5"/>
            <!--
                Sample: X ranges from -100 to 100
                Y peaks at -100                    
            -->
            <xsl:variable name="maxX" as="xs:integer" select="50"/>
            <xsl:for-each select="-1 * $maxX to $maxX">
                <!-- divide X by √$maxX for spread to X = Y-->
                <circle cx="{current()}"
                    cy="{djb:compute-Y(current() div math:sqrt($maxX), 1, -1 * $maxX)}" r="1.5"
                    stroke="red" stroke-width="0.25" stroke-opacity="0.5" fill="none"/>
            </xsl:for-each>
            <path
                d="
                M0,{-1 * $maxX}
                Q{$maxX div 2},{-1 * $maxX}
                {$maxX},0
                "
                stroke="brown" stroke-width="0.75" fill="none"/>
            <path d="{djb:compute-half-parabola($maxX)}" stroke="cyan" stroke-width="2"
                stroke-opacity="0.75" fill="none"/>
        </svg>
    </xsl:template>
</xsl:stylesheet>
