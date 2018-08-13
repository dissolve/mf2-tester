#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do python ./scripts/test-one-python.py $f | jq -S . |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/python/| sed s/html/json/`;
done;
