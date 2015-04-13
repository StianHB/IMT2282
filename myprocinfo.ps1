# Skrevet av StianHB
# Powershell script som svar på oppgave 11.7.2 i Operativsystemer kompendiumet
#1 - Hvem er jeg og hva er navnet på dette scriptet?
#2 - Hvor lenge er det siden siste boot?
#3 - Hvor mange prosesser og tråder finnes?
#4 - Hvor mange context switcer fant sted siste sekund?
#5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
#6 - Hvor mange interrupts fant sted siste sekund?
#9 - Avslutt dette scriptet
#Velg en funksjon:


# 1 - Hvem er jeg og hva er navnet på dette scriptet?

function menu(){

write-host "
1 - Hvem er jeg og hva er navnet på dette scriptet? `n
2 - Hvor lenge er det siden siste boot? `n
3 - Hvor mange prosesser og tråder finnes? `n
4 - Hvor mange context switcer fant sted siste sekund? `n
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund? `n
6 - Hvor mange interrupts fant sted siste sekund? `n
9 - Avslutt dette scriptet `n
Velg en funksjon: 
"

}
# 1 - Hvem er jeg og hva er navnet på dette scriptet?
function whoami(){
    Write-Host "Navnet på dette scriptet er: "$MyInvocation.ScriptName "Navnet på brukeren er: $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name) "
}

# 2 - Hvor lenge er det siden siste boot?
function uptime(){                         # Funksjonen er lånt fra https://4sysops.com/archives/calculating-system-uptime-with-powershell/
   $os = Get-WmiObject win32_operatingsystem
   $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
   $Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
   Write-Output $Display
}

#3 - Hvor mange prosesser og tråder finnes?
function processes(){
$processes=0
$threads=0
foreach($i in $(get-process)) {
   $processes = $processes + 1
}
foreach($n in $(Get-WmiObject win32_thread)){
    $threads = $threads + 1
}
write-host "Det finnes $processes prosseser og $threads antall tråder"

}

# 4 - Hvor mange context switcer fant sted siste sekund?
function context() {

$switches=$($(Get-Counter -Counter "\System\Context Switches/sec").CounterSamples | Format-Table CookedValue -HideTableHeaders -autosize | Out-String)
$switches = $switches -replace "`n|",""
Write-Host "Det foregikk $switches context switches siste sekund"

}
# 5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
function cpuTime() {

$user=$($(Get-Counter -Counter "\Processor(_total)\% User Time" -SampleInterval 1 -MaxSamples 1).CounterSamples | format-table CookedValue -AutoSize -HideTableHeaders | Out-String)
$user = $user -replace "`n|",""
$kernel=$($(Get-Counter -Counter "\Processor(_total)\% Privileged Time" -SampleInterval 1 -MaxSamples 1).CounterSamples | format-table CookedValue -AutoSize -HideTableHeaders | Out-String)
$kernel = $kernel -replace "`n|",""
Write-Host "Av den totale CPU tiden ble $kernel % av tiden brukt i kernelmode og $user % av tiden brukt i usermode"

}
# \Processor(*)\Interrupts/sec#
# 6 - Hvor mange interrupts fant sted siste sekund?
function interrupts() {

$interrupts=$($(Get-Counter -Counter "\Processor(_total)\Interrupts/sec").CounterSamples | Format-Table CookedValue  -AutoSize -hidetableheaders | Out-String)
$interrupts= $interrupts -replace "`n|",""
Write-Host "Det var $interrupts interrupts sist sekund"

}


# Meny
do {
menu
$cmd = Read-Host
switch($cmd) {
    1 { whoami;break }
    2 { uptime; break }
    3 { processes; break }
    4 { context; break}
    5 { cpuTime; break}
    6 { interrupts; break}
    9 { break }
}
} while ($cmd -ne 9)