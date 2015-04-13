[long]$ns = "$input" #reads from stdin to $ns

# 1000 ns = 1 us
# 1000 us = 1 ms = 1000*1000 ns
# 1000 ms = 1 s = 1000*1000*1000 ns


if ( $ns -lt 1000 ){  # ns < 1000 comes out in ns
	Write-Output "$nsns"
	}
elseif ( $ns -lt 1000000 ){   # ns < (1000*1000) comes out in us
	Write-Output "$(($ns/1000))us"
	}
elseif ( $ns -lt 1000000000 ){  # ns < (1000*1000*1000) comes out in ms
	Write-Output "$(($ns/(1000*1000)))ms"
	}
elseif ( $ns -lt  1000000000000 ){ # ns < (1000*1000*1000*1000) comes out in s
	Write-Output "$(($ns/(1000*1000*1000)))s"
	}