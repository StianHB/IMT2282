#!/bin/bash

for pid in $@; do	#Take any number of inputs via CLI parameters and do what needs to be done
	if [[ -e /proc/$pid/status && -r /proc/$pid/status ]]; then	# -r if read permissioni
		status=$(cat /proc/$pid/status)
		VmSize=$(echo "$status" | grep VmSize | awk '{print $2}') # Total VmSize reserved, including space for VmData and VmStk to grow
		#VmPriv=$
		VmPriv=$(echo "$status" | egrep 'Vm[DSE][atx]' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/+/g' | bc ) #  http://unix.stackexchange.com/questions/114943/can-sed-replace-new-line-characters
	        echo "$VmPriv"	
	else
		echo "Proccess with pid $pid does not exist or you have no read rights"
	fi
done

