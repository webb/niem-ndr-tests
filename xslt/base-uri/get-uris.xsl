<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:structures="http://release.niem.gov/niem/structures/3.0/"
  version="2.0">

  <output method="text"/>

  <template match="@structures:uri">
    <value-of>found uri &quot;<value-of select="string(.)"/>&quot;
   base-uri(.) is &quot;<value-of select="base-uri(.)"/>&quot;
   resolve-uri(.) is &quot;<value-of select="resolve-uri(.)"/>&quot;
   resolve-uri(., base-uri(.)) is &quot;<value-of select="resolve-uri(., base-uri(.))"/>&quot;
</value-of>
  </template>
  
  <template match="@*|node()" priority="-1">
    <apply-templates select="@*|node()"/>
  </template>

</stylesheet>
<!--
Local Variables:
mode: sgml
indent-tabs-mode: nil
fill-column: 9999
End:
-->
