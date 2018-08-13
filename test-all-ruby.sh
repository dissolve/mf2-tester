#!/bin/bash
for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do ruby ./scripts/test-one-ruby.rb $f | jq -S . |sed 's/\[\]/{}/g' > `echo $f |sed s/vendor.mf2.tests.tests/ruby/| sed s/html/json/`;
done;
