#/bin/bash

TLB=2   # 2ns to access the TLB
RAM=10  # 10ns to access RAM
DISK=10000000 # 10ms to access disk

hits=$1
hardMiss=$2
softMiss=$(echo "1-$hardMiss-$hits" | bc)

# A hit takes: TLB lookup -> Get page in RAM
hitTime=$(($TLB+$RAM))
# A softmiss takes: TLB lookup -> PT lookup in RAM -> Get page in RAM
softMissTime=$(($TLB+$RAM+$RAM))
# A hardmiss takes: TLB lookup -> PT lookup | Interupt -> Disk access | TLB -> Lookup -> PT lookup -> Get page in RAM
hardMissTime=$(($TLB+$RAM+$DISK+$softMissTime))

# To get average time for a random access we need to add the times w/ weight, then divide by 1(size of our dataset)

average=$(echo "scale=1;(($hitTime*$hits)+($softMissTime*$softMiss)+($hardMissTime*$hardMiss))/1" | bc)

echo "$average nanosekuder som er $(echo $average | cut -f 1 -d . | bash human-readable-ns.sh)"

