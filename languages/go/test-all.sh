#!/bin/bash
rm languages/go/test-one 2>/dev/null
go build -mod=mod -o ./languages/go/test-one ./languages/go/test-one.go

for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do ./languages/go/test-one $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed 's/vendor.mf2.tests.tests/results\/go/' | sed s/html/json/`;
done;
