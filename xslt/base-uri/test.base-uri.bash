
. ${HOME}/share/wrtools-core/fail.bash

for instance in instance*.xml
do
    case "$instance" in
        instance-uri-fragment-base.xml )
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "#two"
   base-uri(.) is "https://example.org/file.xml"
   resolve-uri(., base-uri(.)) is "https://example.org/file.xml#two"
EOF
            ;;
        instance-uri-fragment.xml )
            instance_path=$(realpath "$instance")
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "#two"
   base-uri(.) is "file:${instance_path}"
   resolve-uri(., base-uri(.)) is "file:${instance_path}#two"
EOF
            ;;

        instance-uri-rel-base.xml ) 
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "path/to/resource"
   base-uri(.) is "https://example.org/file.xml"
   resolve-uri(., base-uri(.)) is "https://example.org/path/to/resource"
EOF
            ;;
        
        instance-uri-rel.xml ) 
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "path/to/resource"
   base-uri(.) is "file:${PWD}/${instance}"
   resolve-uri(., base-uri(.)) is "file:${PWD}/path/to/resource"
EOF
            ;;
        
        instance-uri-abs-base.xml ) 
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "https://example.com/path/to/resource"
   base-uri(.) is "https://example.org/file.xml"
   resolve-uri(., base-uri(.)) is "https://example.com/path/to/resource"
EOF
            ;;
        
        instance-uri-abs-base.xml ) 
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "https://example.com/path/to/resource"
   base-uri(.) is "https://example.org/file.xml"
   resolve-uri(., base-uri(.)) is "https://example.com/path/to/resource"
EOF
            ;;
        
        instance-uri-abs.xml ) 
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found uri "https://example.com/path/to/resource"
   base-uri(.) is "file:${PWD}/${instance}"
   resolve-uri(., base-uri(.)) is "https://example.com/path/to/resource"
EOF
            ;;

        instance-id-base.xml )
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found id "two"
   base-uri(.) is "https://example.org/file.xml"
   resolve-uri(concat('#', .), base-uri(.)) is "https://example.org/file.xml#two"
EOF
            ;;

        instance-id.xml )
            test-run --exit-success --exit-status=0 --stderr=/dev/null --stdout=/dev/stdin -- \
                     saxon -x get-uris.xsl -i "$instance" <<EOF
found id "two"
   base-uri(.) is "file:${PWD}/${instance}"
   resolve-uri(concat('#', .), base-uri(.)) is "file:${PWD}/${instance}#two"
EOF
            ;;

        * ) fail "unexpected instance \"$instance\"";;
    esac
done

