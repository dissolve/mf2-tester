#!/bin/bash

cargo install --list | grep "^microformats" | awk '{print $2}' | sed 's/:$//'
