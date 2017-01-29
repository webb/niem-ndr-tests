<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">

  <output method="xml" version="1.0" indent="yes"/>

  <!-- just copy everything else -->
  <template match="@*|node()">
    <copy>
      <apply-templates select="@*|node()"/>
    </copy>
  </template>

</stylesheet>
