
SHELL = /bin/bash -o pipefail -o nounset -o errexit

this_makefile = ${lastword ${MAKEFILE_LIST}}

targets = $(shell find . -type f ! -path './tmp/*' -a '(' -name '*.results.txt' -o -name 'test.*.bash' ')' -print)

tested_tokens_dir = tmp/tokens/tested
reports_dir = tmp/reports
test_tokens = ${targets:./%=${tested_tokens_dir}/%}

#HELP:Recommended use:
#HELP:
#HELP:    $ make clean && make -j 8 report
#HELP:
#HELP:Targets include:
.PHONY: default
default: help

.PHONY: test #    Run all tests
test: ${test_tokens}

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

.PHONY: help #    Print this help
help:
	@ sed -e '/^\.PHONY:/s/^\.PHONY: *\([^ #]*\) *\#\( *\)\([^ ].*\)/\2\1: \3/p;/^[^#]*#HELP:/s/[^#]*#HELP:\(.*\)/\1/p;d' ${this_makefile}


${tested_tokens_dir}/%:
	mkdir -p ${dir ${reports_dir}/$*}
	if run-tests $* > ${reports_dir}/$* 2>&1; \
	then mkdir -p mkdir -p ${dir $@} && touch $@; \
	fi

