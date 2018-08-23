#!/bin/bash
composer show  |grep 'mf2/mf2' |sed 's/\ \+/ /g' |cut -d ' ' -f 2
