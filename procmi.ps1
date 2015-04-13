#Eksempel output av Get-Date -UFormat "%Y%m%d-%H%M%S" : 20100314-221523
$now=$(Get-Date -UFormat "%Y%m%d-%H%M%S")


foreach($i in $args){
  
  $process=$(Get-Process | Where-Object{$_.Id -eq $i})
  $vm=$($process.vm | .\human-readable-bytes.ps1)
  $ws=$($process.ws | .\human-readable-bytes.ps1)
  New-Item ".\$i--$now.meminfo" -ItemType file -Force -Value "******** Minne info om prosess med PID $i ******** `n Total bruk av virtuelt minne: $vm `n St`ørrelse p`å Working Set: $ws"

}

