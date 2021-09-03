#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do node ./languages/typescript/test-one.js  $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed 's/vendor.mf2.tests.tests/results\/typescript/'| sed s/html/json/`;
done;
