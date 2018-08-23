#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do php ./languages/php/test-one.php  $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed 's/vendor.mf2.tests.tests/results\/php/'| sed s/html/json/`;
done;
