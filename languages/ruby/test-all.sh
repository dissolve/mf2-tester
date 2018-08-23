#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do ruby ./languages/ruby/test-one.rb $f | jq -S -f normalize.jq |sed 's/\[\]/{}/g' > `echo $f |sed 's/vendor.mf2.tests.tests/results\/ruby/' | sed s/html/json/`;
done;
