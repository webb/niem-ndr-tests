
. ${HOME}/share/wrtools-core/temp.bash

temp_make_file EXPECTED_RESULTS

cat <<EOF > "$EXPECTED_RESULTS"
19:failed-assert:no-at-fixed
38:failed-assert:no-el-fixed
41:failed-assert:no-at-fixed
58:failed-assert:no-facet-fixed
62:failed-assert:no-el-fixed
EOF

test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout="$EXPECTED_RESULTS" -- \
  get-test-report --xsl=${HOME}/r/niem/ndr/doc/repo/ndr-rules-conformance-target-ref.sch.xsl --brief \
  reference-invalid.xsd


