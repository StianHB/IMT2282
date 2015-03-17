#!/bin/bash

# This script takes a single parameter, a directory

if [[ -d $1 ]]; then
	full=$(df -h $1| tail -n 1 | awk '{print $5}')
	files=$(find $1 -depth -type f | wc -l)
	largest=$(find $1 -depth -type f | tr '\n' '\0' | du -ah --files0-from=- | sort -h | tail -n 1)       # largest file, <fileSize> <fileName>
	totalSize=$(find $1 -depth -type f | tr '\n' '\0' | du -a --files0-from=- | awk '{print $1}' | sed ':a;N;$!ba;s/\n/+/g' | bc)
	average=$(($totalSize/$files))
	hardLinks=$(find /home/hoel -depth -type f -print0 | xargs --null ls -la | awk '{print $2 , $9 }' | sort | tail -n 1)

	echo "Partisjonen $1 befinner seg på er $full full"
	echo "Det finnes $files filer"
	echo "Den største er $(echo $largest | awk '{print $2'}) som er $(echo $largest | awk '{print $1}') stor."
	echo "Gjennomsnittlig filstørrelse er ca $average bytes."
	echo "Filen $(echo $hardLinks | awk '{print $2}') har flest hardlinks, den har $(echo $hardLinks | awk '{print $1}')."
else
	echo "$1 is not a directory..."
fi

