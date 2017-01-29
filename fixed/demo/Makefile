
text_file = default-and-fixed-modify-infoset.txt
zip_file = default-and-fixed-modify-infoset.zip

valid_tokens = \
	tmp/xsd-valid/schema-default/instance \
	tmp/xsd-valid/schema-fixed/instance \
	tmp/xsd-valid/schema-default/instance-other \
	tmp/xsd-valid/schema-fixed/instance-other \
	tmp/xsd-valid/schema-fixed/instance-fixed \

all: zip

text: ${text_file}

%: %.roff
	roffinate --out=$@ $<

results.txt: demo.bash instance.xml print.xsl schema-default.xsd schema-fixed.xsd
	./demo.bash > results.txt 2>&1

.PHONY: zip
zip: default-and-fixed-modify-infoset.zip

${zip_file}: ${text_file} results.txt demo.bash instance.xml print.xsl schema-default.xsd schema-fixed.xsd
	zip -9 $@ $^

.PHONY: clean
clean:
	$(RM) ${wildcard *~} ${text_file} ${zip_file} results.txt
	rm -rf tmp

.PHONY: valid
valid: ${valid_tokens}

tmp/xsd-valid/schema-default/instance: instance.xml xml-catalog-default.xml
	xsdvalid -catalog xml-catalog-default.xml $<
	@ mkdir -p ${dir $@}
	@ touch $@

tmp/xsd-valid/schema-fixed/instance: instance.xml xml-catalog-fixed.xml
	xsdvalid -catalog xml-catalog-fixed.xml $<
	@ mkdir -p ${dir $@}
	@ touch $@

tmp/xsd-valid/schema-default/instance-other: instance-other.xml xml-catalog-default.xml
	xsdvalid -catalog xml-catalog-default.xml $<
	@ mkdir -p ${dir $@}
	@ touch $@

tmp/xsd-valid/schema-fixed/instance-other: instance-other.xml xml-catalog-fixed.xml
	@echo Expect this to fail...
	! xsdvalid -catalog xml-catalog-fixed.xml $<
	@ echo ...as we expected
	@ mkdir -p ${dir $@}
	@ touch $@

tmp/xsd-valid/schema-fixed/instance-fixed: instance-fixed.xml xml-catalog-fixed.xml
	xsdvalid -catalog xml-catalog-fixed.xml $<
	@ mkdir -p ${dir $@}
	@ touch $@

xml-catalog-default.xml: schema-default.xsd
	touch $@

xml-catalog-fixed.xml: schema-fixed.xsd
	touch $@
