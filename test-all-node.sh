#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do node ./scripts/test-one-node.js  $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/node/| sed s/html/json/`;
done;
