<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tt="http://www.w3.org/ns/ttml" xmlns:tts="http://www.w3.org/ns/ttml#styling" version="2.0" xpath-default-namespace="http://www.w3.org/ns/ttml">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//div"/>
    </xsl:template>
    <xsl:template match="div">
        <cues>
            <xsl:apply-templates/>
        </cues>
    </xsl:template>
    <xsl:template match="p">
        <xsl:variable name="c_start_hours" select="round(number(tokenize(@begin, ':')[1])) * 3600"/>
        <xsl:variable name="c_start_minutes" select="round(number(tokenize(@begin, ':')[2])) * 60"/>
        <xsl:variable name="c_start_seconds" select="number(tokenize(@begin, ':')[3])"/>
        <xsl:variable name="c_end_hours" select="round(number(tokenize(@end, ':')[1])) * 3600"/>
        <xsl:variable name="c_end_minutes" select="round(number(tokenize(@end, ':')[2])) * 60"/>
        <xsl:variable name="c_end_seconds" select="number(tokenize(@end, ':')[3])"/>
        <cue>
            <speaker/>
            <start>
                <xsl:value-of select="$c_start_hours + $c_start_minutes + $c_start_seconds"/>
            </start>
            <end>
                <xsl:value-of select="$c_end_hours + $c_end_minutes + $c_end_seconds"/>
            </end>
            <transcript>
                <xsl:apply-templates/>
            </transcript>
        </cue>
    </xsl:template>
</xsl:stylesheet>