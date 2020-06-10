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
    <report:failed-assert id="{@id}" timestamp="{{current-dateTime()}}"/>
  </xsl:template>

  <xsl:template name="schxslt-api:report">
    <xsl:param name="schema" as="element(sch:schema)" required="yes"/>
    <xsl:param name="phase" as="xs:string" required="yes"/>

    <report:report>
      <runtime:sequence select="$schxslt:report"/>
    </report:report>

  </xsl:template>

</xsl:transform>
