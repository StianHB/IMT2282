#!/bin/bash

# Skript skrevet som svar på oppgave 7.6.1 i kompendiet for IMT 2282 - Operativsystemer

function youare {
whiptail --title "Hvem er jeg og hva er navnet på dette scriptet?" --msgbox "Du er $(whoami) og du kjører $0" 8 60
 }

function whiptailUptime {
minutes=$(cat /proc/uptime | awk '{print $1}' | cut -d . -f 1 | awk '{printf( "%s/60\n" , $0)}' | bc)
whiptail --title "Hvor lenge er det siden siste boot?" --msgbox "Det har gått $minutes minutter siden sist boot" 8 60
}

function processes {
# ps -eo nlwp lister ut antall tråder per prossess, tail -n +2 fjerner den øverste linjen av output fra ps, awk leser linje for linje og legger til tallet i num_threads før den printer ut antall tråder
threads=$(ps -eo nlwp | tail -n +2 | awk '{ num_threads += $1 } END { print num_threads }')  # Hentet fra http://askubuntu.com/questions/88972/how-to-get-from-terminal-total-number-of-threads-per-process-and-total-for-al
noOfProcesses=$(ps -A --no-headers | wc -l)
whiptail --title "Hvor mange prosesser og tråder finnes?" --msgbox "Det finnes $noOfProcesses prosseser og $threads tråder" 8 60
}

function context {
	ctext1=$(cat /proc/stat | grep ctxt | cut -f 2 -d " ");
	sleep 1;
	ctext2=$(cat /proc/stat | grep ctxt | cut -f 2 -d " ");
	switches=$(($ctext2 - $ctext1))
whiptail --title "Hvor mange context switcher fant sted siste sekund?" --msgbox "Det var $switches context switches sist sekund" 8 60
}

function cpuTime {
stat1=$(cat /proc/stat | head -n 1 | sed 's/cpu  //g')
sleep 1;
stat2=$(cat /proc/stat | head -n 1 | sed 's/cpu  //g')

totalCPU=$(($(echo $stat2 | sed 's/ /+/g' | bc)-$(echo $stat1 | sed 's/ /+/g' | bc)))
kernel=$(($(echo $stat2 | awk '{print $3}')-$(echo $stat1 | awk '{print $3}')))
user=$(($(echo $stat2 | awk '{print $1}')-$(echo $stat1 | awk '{print $1}')))
kernelmode=$(echo "scale=2;($kernel*100/$totalCPU)" | bc)
usermode=$(echo "scale=2;($user*100/$totalCPU)" | bc)
whiptail --title "Hvor stor andel av CPU-tiden ble benyttet i kernel- og usermode siste sekund?" --msgbox "Av den totale CPU tiden ble $kernelmode % av tiden brukt i kernelmode og $usermode % av tiden brukt i usermode" 12 85
}

function interrupts {
interrupt1=$(cat /proc/stat | grep intr | sed -e 's/intr //g' -e 's/ /+/g' | bc)
sleep 1;
interrupt2=$(cat /proc/stat | grep intr | sed -e 's/intr //g' -e 's/ /+/g' | bc)
interrupts=$(($interrupt2-$interrupt1))
whiptail --title "Hvor mange interrupts fant sted siste sekund?" --msgbox "Det var $interrupts interrupts sist sekund" 8 60
}

function menu {
OPTION=$(whiptail --title "myprocinfo.bash, whiptail edt" --menu "Choose your option" 13 85 7 \
"1" "Hvem er jeg og hva er navnet på dette scriptet?" \
"2" "Hvor lenge er det siden siste boot?" \
"3" "Hvor mange prosesser og tråder finnes?" \
"4" "Hvor mange context switcher fant sted siste sekund?" \
"5" "Hvor stor andel av CPU-tiden ble benyttet i kernel- og usermode siste sekund?" \
"6" "Hvor mange interrupts fant sted siste sekund?" \
"9" "Avslutt dette scriptet" 3>&1 1>&2 2>&3)

}

menu
if [ $? != 0 ];then
echo "Bye bye..."; exit 0;
fi
case $OPTION in
	1) youare;; 
	2) whiptailUptime;;
	3) processes;;
	4) context;;
	5) cpuTime;;
	6) interrupts;;
	9) echo "Bye bye..."; exit 0;;
	*) menu;;
esac

 
