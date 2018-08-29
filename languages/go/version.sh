#!/bin/bash

# use commit sha of the library as the version
git -C "$(go env GOPATH)/src/willnorris.com/go/microformats" rev-parse --short HEAD 2>/dev/null
