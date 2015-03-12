#!/bin/bash

read bytes #reads from stdin too $bytes

# 1024  B = 1 KB
# 1024 KB = 1 MB = 1024*1024 bytes
# 1024 MB = 1 GB = 1024*1024*1024 bytes
# 1024 GB = 1 TB = 1024*1024*1024*1024 bytes


if [ $bytes -lt 1024 ]; then   # bytes < 1024 comes out in bytes
	echo $bytes\B
	exit 1
elif [ $bytes -lt 1048576 ]; then    # bytes < (1024*1024) comes out in kbytes
	echo $(($bytes/1024))\KB
	exit 1
elif [ $bytes -lt 1073741824 ]; then  # bytes < (1024*1024*1024) comes out in mbytes
	echo $(($bytes/(1024*1024)))\MB
	exit 1
elif [ $bytes -lt 1099511627776 ]; then # bytes < (1024*1024*1024*1024) comes out in gbytes
	echo $(($bytes/(1024*1024*1024)))\GB
	exit 1
elif [ $bytes -lt  1125899906842624 ]; then # bytes < (1024*1024*1024*1024) comes out in gbytes
	echo $(($bytes/(1024*1024*1024*1024)))\TB
	exit 1
fi



