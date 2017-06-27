
. ${HOME}/share/wrtools-core/temp.bash

test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/null -- \
  ~/bin/xs-validate -c niem/xml-catalog.xml instance.xml 


