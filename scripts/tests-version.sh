#!/bin/bash
composer show  |grep 'mf2/tests' |sed 's/\ \+/ /g' |cut -d ' ' -f 2
