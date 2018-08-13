#!/bin/bash
#set up lang dirs
for lang in ruby php python; do 
    rm -rf $lang
done

rm -rf tests test-results dist
