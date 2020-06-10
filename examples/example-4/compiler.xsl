<xsl:transform version="2.0"
               xmlns:runtime="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:report="tag:dmaus@dmaus.name,2020:Example:Report"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../../schxslt/2.0/compile/compile-2.0.xsl"/>
  
  <xsl:namespace-alias stylesheet-prefix="runtime" result-prefix="xsl"/>

  <xsl:template name="schxslt-api:failed-assert">
    <xsl:param name="assert" as="element(sch:assert)" required="yes"/>
    <report:failed-assert id="{$assert/@id}" timestamp="{{current-dateTime()}}" test="{$assert/@test}">
      <runtime:attribute name="elementId" select="generate-id(ancestor-or-self::*[1])"/>
    </report:failed-assert>
  </xsl:template>
  
  <xsl:template name="schxslt-api:report">
    <xsl:param name="schema" as="element(sch:schema)" required="yes"/>
    <xsl:param name="phase" as="xs:string" required="yes"/>
    
    <runtime:apply-templates select="/" mode="annotate">
      <runtime:with-param name="report" as="node()*" select="$schxslt:report" tunnel="yes"/>
    </runtime:apply-templates>
    
  </xsl:template>

  <xsl:template name="schxslt-api:validation-stylesheet-body-top-hook">
    <xsl:param name="schema" as="element(sch:schema)" required="yes"/>

    <runtime:template match="*" mode="annotate">
      <runtime:param name="report" as="node()*" tunnel="yes"/>
      <runtime:variable name="elementId" select="generate-id(.)"/>
      <runtime:copy>
        <runtime:if test="$report[self::report:failed-assert[@elementId = $elementId]]">
          <runtime:attribute name="report:failed-assert" select="$report[self::report:failed-assert[@elementId = $elementId]]/@id"/>
        </runtime:if>
        <runtime:apply-templates select="@* | node()" mode="#current"/>
      </runtime:copy>
    </runtime:template>

    <runtime:template match="@* | comment() | processing-instruction() | text()" mode="annotate">
      <runtime:copy/>
    </runtime:template>

  </xsl:template>

</xsl:transform>
