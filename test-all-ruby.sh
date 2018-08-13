#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do microformats $f | jq -S . |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/ruby/| sed s/html/json/`;
done;
