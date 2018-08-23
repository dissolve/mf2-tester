#!/bin/bash
#set up dirs
for f in vendor/mf2/tests/tests/microformats-*/* ; do
    mkdir -p results/`echo $f |sed s/vendor.mf2.tests.tests/test-results/`;
    mkdir -p results/`echo $f |sed s/vendor.mf2.tests.tests/tests/`;

    for lang in `ls languages`; do
        mkdir -p "results/`echo $f |sed s/vendor.mf2.tests.tests/$lang/`";
    done;
done;

for f in vendor/mf2/tests/tests/microformats-*/*/*.html ; do
    cp $f results/`echo $f |sed 's/vendor.mf2.tests.tests/tests/'|sed s/html/txt/`;
done;

#copy tests
#format test results
for f in vendor/mf2/tests/tests/microformats-*/*/*.json ; do
    cp `echo $f |sed s/json/html/` results/`echo $f |sed s/vendor.mf2.tests.tests/tests/|sed s/json/txt/`;
    cat $f |jq -S -f normalize.jq |sed 's/\[\]/{}/g' >  "results/`echo $f |sed s/vendor.mf2.tests.tests/test-results/`";
done;
