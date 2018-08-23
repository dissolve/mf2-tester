#!/bin/bash
echo "removing any previous data"
./scripts/destroy.sh
echo "initializing language directories"
./scripts/initialize.sh

for lang in `ls languages`; do 
    echo "Testing $lang"
    bash "./languages/$lang/test-all.sh";
done

echo "Building Report"
./scripts/package.sh
