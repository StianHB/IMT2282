#!/bin/bash

# Skript skrevet som svar på oppgave 7.6.1 i kompendiet for IMT 2282 - Operativsystemer

function context {
	ctext1=$(cat /proc/stat | grep ctxt | cut -f 2 -d " ");
	sleep 1;
	ctext2=$(cat /proc/stat | grep ctxt | cut -f 2 -d " ");
	echo  $(($ctext2 - $ctext1))
}

function cpuTime {
stat1=$(cat /proc/stat | head -n 1 | sed 's/cpu  //g')
sleep 1;
stat2=$(cat /proc/stat | head -n 1 | sed 's/cpu  //g')

totalCPU=$(($(echo $stat2 | sed 's/ /+/g' | bc)-$(echo $stat1 | sed 's/ /+/g' | bc)))
kernel=$(($(echo $stat2 | awk '{print $3}')-$(echo $stat1 | awk '{print $3}')))
user=$(($(echo $stat2 | awk '{print $1}')-$(echo $stat1 | awk '{print $1}')))
echo $(echo "scale=2;($kernel*100/$totalCPU)" | bc) \% av cputiden brukes i kernelmode
echo $(echo "scale=2;($user*100/$totalCPU)" | bc) \% av cputiden brukes i usermode
}

function interrupts {
interrupt1=$(cat /proc/stat | grep intr | sed -e 's/intr //g' -e 's/ /+/g' | bc)
sleep 1;
interrupt2=$(cat /proc/stat | grep intr | sed -e 's/intr //g' -e 's/ /+/g' | bc)
echo Antall interrupts siste sekund: $(($interrupt2-$interrupt1))
}

function menu {
echo "
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switch'er fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode
     og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
"

echo -n "Velg en funksjon: "
read cmd
}

menu
case $cmd in
	1) echo "Du er $(whoami) og du kjører $0";;
	2) echo "Uptime $(uptime | awk '{print $3, $4, $5, $6}' | sed 's/,//g')";;
	3) echo "Antall prosseser og tråder: $(ps aux | wc -l)";;
	4) context;;
	5) cpuTime;;
	6) interrupts;;
	9) echo "Bye bye..."; exit 0;;
	*) menu;;
esac

 
