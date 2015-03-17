#!/bin/bash

function fileWrite {
	currentDate=$(date +%Y%m%d-%H:%M:%S)
	fileName="$pid-$currentDate.meminfo"
	touch $fileName
	echo "******** Minne info om prosess med PID $pid ********" > $fileName
	echo "Total bruk av virtuelt minne (VmSize):	$VmSize KB" >> $fileName
	echo "Mengde private virtuelt minne(VmData+VmStk+VmExe):	$VmPriv KB" >> $fileName
	echo "Mengde shared virtuelt minne (VmLiB):	$VmLib KB" >> $fileName
	echo "Total bruk av fysisk minne (VmRSS):	$VmRSS KB" >> $fileName
	echo "Mengde fysisk minne som benyttes til page table (VmPTE):	$VmPTE KB" >> $fileName
}

for pid in $@; do	#Take any number of inputs via CLI parameters and do what needs to be done
	if [[ -e /proc/$pid/status && -r /proc/$pid/status ]]; then	# -r if read permissioni
		status=$(cat /proc/$pid/status)
		VmSize=$(echo "$status" | grep VmSize | awk '{print $2}') # Total VmSize reserved, including space for VmData and VmStk to grow
		VmPriv=$(echo "$status" | egrep 'Vm[DSE][atx]' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/+/g' | bc ) #  http://unix.stackexchange.com/questions/114943/can-sed-replace-new-line-characters
		VmLib=$(echo "$status" | grep VmLib | awk '{print $2}')
		VmRSS=$(echo "$status" | grep VmRSS | awk '{print $2}')
		VmPTE=$(echo "$status" | grep VmPTE | awk '{print $2}')
		fileWrite	
	else
		echo "Proccess with pid $pid does not exist or you have no read rights"
	fi
done

