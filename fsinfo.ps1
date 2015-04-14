$folder=Get-item $args[0]
 
[string]$root=$($folder.Root)

$root = $root.Replace("\","")

$diskObject=$(gwmi win32_logicaldisk | Where-Object {$_.DeviceID -eq "$root"})

[long]$freeSpace=$($diskObject | Format-Table FreeSpace -HideTableHeaders | Out-String)
[long]$totalSpace=$($diskObject | Format-Table Size -HideTableHeaders | Out-String)

$used= 100-(($freeSpace/$totalSpace)*100)

$files=$(Get-ChildItem $folder -Recurse | Where-Object { ! $_.PSIsContainer } | sort -Descending length)
$nr=$($files.count)
$largest=$($files | Select-Object -First 1 | %{$_.FullName} | Out-String)
$largestSize=$($files | Select-Object -first 1 | %{$_.Length} | Out-String | .\human-readable-bytes.ps1 )
$average=$($files | Measure-Object -Average Length | Format-Table Average -HideTableHeaders | Out-String | %{$_.Replace(',',".")} | .\human-readable-bytes.ps1)

Write-Output "Partisjonen $folder befinner seg på er $($used)% full."
Write-Output  "Det finnes $nr filer."
Write-Output "Den største er $largest som er $largestSize stor."
Write-Output "Gjennomsnittlig filstørrelse er $average"