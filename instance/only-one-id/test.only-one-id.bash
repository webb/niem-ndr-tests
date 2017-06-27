
. ${HOME}/share/wrtools-core/temp.bash

temp_make_file EXPECTED_RESULTS

cat <<EOF > "$EXPECTED_RESULTS"
13:failed-assert:rule-only-one-id
EOF

test-run --exit-success --exit-status=1 --stderr=/dev/null --stdout="$EXPECTED_RESULTS" -- \
  get-test-report --xsl=${HOME}/r/niem/ndr/doc/repo/ndr-rules-conformance-target-ins.sch.xsl --brief \
  instance.xml


