$TLB=2   # 2ns to access the TLB
$RAM=10  # 10ns to access RAM
$DISK=10000000 # 10ms to access disk

$hits=$args[0]
$hardMiss=$args[1]
$softMiss=$(1-$hardMiss-$hits)

# A hit takes: TLB lookup -> Get page in RAM
$hitTime=$(($TLB+$RAM))
# A softmiss takes: TLB lookup -> PT lookup in RAM -> Get page in RAM
$softMissTime=$(($TLB+$RAM+$RAM))
# A hardmiss takes: TLB lookup -> PT lookup | Interupt -> Disk access | TLB Lookup -> PT lookup -> Get page in RAM
$hardMissTime=$(($TLB+$RAM+$DISK+$softMissTime))

# To get average time for a random access we need to add the times w/ weight, then divide by 1(size of our dataset)

$average=(($hitTime*$hits)+($softMissTime*$softMiss)+($hardMissTime*$hardMiss))

Write-Output "$average nanosekuder som er $(Write-Output $average | .\human-readable-ns.ps1)"
