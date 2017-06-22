
java = /usr/bin/java

# invoke as:
#   ${saxon} -xsd:schema-fixed.xsd -s:instance.xml -xsl:print.xsl -o:out.txt

saxon = ${java} -cp ${HOME}/working/tools/share/saxon-ee-j/bin/saxon9ee.jar:${HOME}/working/tools/share/saxon-ee-j/bin/saxon9-sql.jar:${HOME}/working/tools/share/saxon-ee-j/licenses/2010-06-09 com.saxonica.Transform -val:strict

.PHONY: default
default: aufr

.PHONY: adf #  attribute decl fixed
adf:
	${saxon} -xsd:"envelope.xsd;attribute-decl-fixed.xsd" -s:instance-attribute-missing.xml -xsl:print.xsl

.PHONY: auf #  attribute use fixed
auf:
	${saxon} -xsd:"envelope.xsd;attribute-use-fixed.xsd" -s:instance-attribute-missing.xml -xsl:print.xsl

.PHONY: aufr #  attribute use fixed required
aufr:
	${saxon} -xsd:"envelope.xsd;attribute-use-fixed-required.xsd" -s:instance-attribute-missing.xml -xsl:print.xsl

.PHONY: aufre #  attribute use fixed required empty
aufre:
	${saxon} -xsd:"envelope.xsd;attribute-use-fixed-required.xsd" -s:instance-attribute-empty.xml -xsl:print.xsl

.PHONY: edc #  element decl complex
edc:
	${saxon} -xsd:"envelope.xsd;element-decl-complex.xsd" -s:instance-element-empty.xml -xsl:print.xsl

.PHONY: euoe #  element use optional - empty
euoe:
	${saxon} -xsd:"envelope.xsd;element-use-optional.xsd" -s:instance-empty.xml -xsl:print.xsl

.PHONY: ff #  facet fixed
ff:
	${saxon} -xsd:"envelope.xsd;facet-fixed.xsd" -s:instance-attribute.xml -xsl:print.xsl

