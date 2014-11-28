<?xml version="1.0" encoding="UTF-8"?>
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<body style="font-family:Arial; font-size:12pt; background-color:#EEEEEE">

<xsl:for-each select="Company/Employee">
  <div style="font-size: 24px; background-color: yellow; font-weight: bold; color: red">
    <p>
    Employee <span style="font-weight:bold"><xsl:value-of select="empName"/></span> 
    works from <span style="font-weight:bold"><xsl:value-of select="empOffice"/></span> office. 
    <span style="font-weight:bold"><xsl:value-of select="empName"/></span> works for <no. of divs>
division(s), which are <divisionName1, divisionName2, ... , and divisionNameN>. 

    <span style="font-weight:bold"><xsl:value-of select="empName"/></span> manages <no. of divs managed> division(s), which are <managedDivisionName1, managedDivisionName2, ... , and managedDivisionNameN>. 

    <span style="font-weight:bold"><xsl:value-of select="empName"/></span> works for the most time with the <divisionName> division.
    </p>
  </div>
</xsl:for-each>


</body>
</html>