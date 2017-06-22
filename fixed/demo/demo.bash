#!/bin/bash

set -o nounset -o errexit -o pipefail

run () {
    printf '# executing:'
    printf ' %q' "$@"
    printf '\n'
    "$@"
}




echo '#'
echo '# validating against schema'
echo '#'

if ! run xs-validate -c xml-catalog.xml instance.xml
then echo FAIL
fi

saxon=${HOME}/working/tools/bin/saxon

echo '#'
echo '# processing without schema validation'
echo '#'

${saxon} -debug -ee -in instance.xml -xsl print.xsl

printf '\n'

echo '#'
echo '# processing with schema validation with @fixed'
echo '#'

${saxon} -debug -ee -val:strict -xsd:schema-fixed.xsd -in instance.xml -xsl print.xsl

printf '\n'

