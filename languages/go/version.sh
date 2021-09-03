#!/bin/bash

go list -mod=mod -m willnorris.com/go/microformats | awk '{print $2}' | sed 's/^v//'
