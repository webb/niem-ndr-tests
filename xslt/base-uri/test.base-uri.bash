test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=output.txt -- \
  saxon -x get-uris.xsl -i instance.xml
