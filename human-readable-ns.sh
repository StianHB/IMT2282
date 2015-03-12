#!/bin/bash

read ns #reads from stdin too $ns

# 1000 ns = 1 us
# 1000 us = 1 ms = 1000*1000 ns
# 1000 ms = 1 s = 1000*1000*1000 ns


if [ $ns -lt 1000 ]; then   # ns < 1000 comes out in ns
	echo $ns\ns
	exit 0
elif [ $ns -lt 1000000 ]; then    # ns < (1000*1000) comes out in us
	echo $(($ns/1000))\us
	exit 0
elif [ $ns -lt 1000000000 ]; then  # ns < (1000*1000*1000) comes out in ms
	echo $(($ns/(1000*1000)))\ms
	exit 0
elif [ $ns -lt  1000000000000 ]; then # ns < (1000*1000*1000*1000) comes out in s
	echo $(($ns/(1000*1000*1000)))\s
	exit 0
fi


