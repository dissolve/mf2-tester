#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do php ./scripts/test-one-php.php  $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/php/| sed s/html/json/`;
done;
