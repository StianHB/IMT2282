#!/bin/bash

# This script takes a single parameter, a directory

if [[ -d $1 ]]; then
	find $1 -depth -type f -printf "%f\n" | grep -E "\s|å|æ|ø"
else
	echo "$1 is not a directory..."
fi	
