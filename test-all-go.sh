#!/bin/bash
go build -o ./go/test-one-go ./scripts/test-one-go.go

for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do ./go/test-one-go $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/go/| sed s/html/json/`;
done;
