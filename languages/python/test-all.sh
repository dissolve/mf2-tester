#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do python ./languages/python/test-one.py $f | jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed 's/vendor.mf2.tests.tests/results\/python/' | sed s/html/json/`;
done;
