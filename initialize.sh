#!/bin/bash
#set up lang dirs
for lang in ruby php python go node; do 
    for f in vendor/mf2/tests/tests/microformats-*/* ; 
        do mkdir -p `echo $f |sed s/vendor.mf2.tests.tests/$lang/`;
    done;
done

#set up test dirs
for f in vendor/mf2/tests/tests/microformats-*/* ; 
    do mkdir -p `echo $f |sed s/vendor.mf2.tests.tests/test-results/`;
    mkdir -p `echo $f |sed s/vendor.mf2.tests.tests/tests/`;
done;

for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; 
    do cp $f `echo $f |sed s/vendor.mf2.tests.tests/tests/|sed s/html/txt/`;
done;

#copy tests
#format test results
for f in vendor/mf2/tests/tests/microformats-*/*/*.json ; 
    do cp `echo $f |sed s/json/html/` `echo $f |sed s/vendor.mf2.tests.tests/tests/|sed s/json/txt/`;
    cat $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' >  `echo $f |sed s/vendor.mf2.tests.tests/test-results/`;
done;
