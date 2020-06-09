<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  <pattern>
    <rule context="tei:titleStmt/tei:title[@type = 'short']">
      <assert test="empty(tei:*)" id="a01">
        A short title must only contain text.
      </assert>
    </rule>
    <rule context="tei:titleStmt[ancestor::tei:TEI/@type = 'transcript']/tei:author">
      <assert test="@ref" id="a02">
        The author of a transcription must be linked to the authority file.
      </assert>
    </rule>
  </pattern>
</schema>
