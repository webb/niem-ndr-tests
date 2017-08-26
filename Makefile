
SHELL = /bin/bash -o pipefail -o nounset -o errexit

#HELP:Recommended use:
#HELP:
#HELP:    $ make clean && make -j 8 report
#HELP:

#HELP:Set variables:
#HELP:    get: set to true to fetch schemas from NDR doc & rebuild XML catalog
get = false
#HELP:    tests_dir: Set to a dir to narrow executed tests to that directory
tests_dir = .

# commands
tee = tee

rules_dir = ../doc/tmp
rules_sch = ${wildcard ${rules_dir}/*.sch}
rules_xsl = ${rules_sch:%.sch=%.sch.xsl}

this_makefile = ${lastword ${MAKEFILE_LIST}}

targets_default := $(shell find ${tests_dir} \( -name tmp -prune \) -o -type f '(' -name '*.results.txt' -o -name 'test.*.bash' ')' -print)
targets = ${targets_default}

tested_tokens_dir = tmp/tokens/tested
reports_dir = tmp/reports
test_tokens = ${targets:${tests_dir}/%=${tested_tokens_dir}/%}

ifneq (${get},false)

.PHONY: get
get: niem/appinfo.xsd niem/structures.xsd niem/xml-catalog.xml 

niem/appinfo.xsd: ../doc/dest/appinfo.xsd
	rm -f $@
	install -T -m 444 $< $@

niem/structures.xsd: ../doc/dest/structures.xsd
	rm -f $@
	install -T -m 444 $< $@

niem/xml-catalog.xml: ${shell find niem -type f -name '*.xsd'}
	rm -f $@
	cd niem && find . -type f -name '*.xsd' | cut -c 3- | xargs get-xml-catalog | tee xml-catalog.xml

endif

#HELP:Targets include:
.PHONY: default
default: help

.PHONY: run
run: update-xsl
	${MAKE} clean
	${MAKE} -j 8 report

.PHONY: test #    Run all tests
test: update-xsl ${test_tokens}

.PHONY: clean #    Clear the way to re-run all the tests
clean:
	rm -rf tmp
	rm -f report.txt
	find . -type f -name '*~' -delete

.PHONY: report #    Generate a single report document
report: report.txt

report.txt: ${test_tokens}
	find ${reports_dir} -type f | xargs cat > report.txt

.PHONY: subset #    Extract subset .zip file
subset:
	rm -rf niem
	unzip ${shell get-newest ${wildcard ${HOME}/Downloads/Subset_*.zip}}

.PHONY: update-xsl #    Update XSLT files in the rules directory
update-xsl: ${rules_xsl}

.PHONY: help #    Print this help
help:
	@ sed -e '/^\.PHONY:/s/^\.PHONY: *\([^ #]*\) *\#\( *\)\([^ ].*\)/\2\1: \3/p;/^[^#]*#HELP:/s/[^#]*#HELP:\(.*\)/\1/p;d' ${this_makefile}

${tested_tokens_dir}/%.ext.results.txt: ${tests_dir}/%.ext.results.txt ${tests_dir}/%
	@ mkdir -p ${dir ${reports_dir}/$*}
	(run-tests --rules-dir=${rules_dir} ${tests_dir}/$*.ext.results.txt || true) 2>&1 \
	  | ${tee} ${reports_dir}/$*.ext.results.txt;
	@ mkdir -p ${dir $@} && touch $@

${tested_tokens_dir}/%.set.results.txt: ${tests_dir}/%.set.results.txt ${tests_dir}/%
	@ mkdir -p ${dir ${reports_dir}/$*}
	run-tests --rules-dir=${rules_dir} ${tests_dir}/$*.set.results.txt 2>&1 \
	  | ${tee} ${reports_dir}/$*.set.results.txt
	@ mkdir -p ${dir $@} && touch $@

${tested_tokens_dir}/%.valid.results.txt: ${tests_dir}/%.valid.results.txt ${tests_dir}/%
	@ mkdir -p ${dir ${reports_dir}/$*}
	(run-tests --rules-dir=${rules_dir} ${tests_dir}/$*.valid.results.txt || true) 2>&1 \
	  | ${tee} ${reports_dir}/$*.valid.results.txt
	@ mkdir -p ${dir $@} && touch $@

${tested_tokens_dir}/%.ref.results.txt: ${tests_dir}/%.ref.results.txt ${tests_dir}/%
	@ mkdir -p ${dir ${reports_dir}/$*}
	(run-tests --rules-dir=${rules_dir} ${tests_dir}/$*.ref.results.txt || true) 2>&1 \
	  | ${tee} ${reports_dir}/$*.ref.results.txt
	@ mkdir -p ${dir $@} && touch $@

${tested_tokens_dir}/%: ${tests_dir}/%
	@ mkdir -p ${dir ${reports_dir}/$*}
	(run-tests --rules-dir=${rules_dir} ${tests_dir}/$* || true) 2>&1 \
	  | ${tee} ${reports_dir}/$*
	@ mkdir -p ${dir $@} && touch $@

%.sch.xsl: %.sch
	schematron-compile --output-file=$@ $<

