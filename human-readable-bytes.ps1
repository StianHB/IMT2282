[long]$bytes = "$input" #reads from stdin too $bytes
# 1024 B = 1 KB
# 1024 KB = 1 MB = 1024*1024 bytes
# 1024 MB = 1 GB = 1024*1024*1024 bytes
# 1024 GB = 1 TB = 1024*1024*1024*1024 bytes
if ( $bytes -lt 1024 ) {# bytes < 1024 comes out in bytes
Write-Output "$($bytes)B"
}
elseif ( $bytes -lt 1048576 ){ # bytes < (1024*1024) comes out in kbytes
Write-Output "$(($bytes/1024))KB"
}
elseif ( $bytes -lt 1073741824 ){ # bytes < (1024*1024*1024) comes out in mbytes
Write-Output "$(($bytes/(1024*1024)))MB"
}
elseif ( $bytes -lt 1099511627776 ){ # bytes < (1024*1024*1024*1024) comes out in gbytes
Write-Output "$(($bytes/(1024*1024*1024)))GB"
}
elseif ( $bytes -lt 1125899906842624 ){ # bytes < (1024*1024*1024*1024) comes out in gbytes
Write-Output "$(($bytes/(1024*1024*1024*1024)))TB"
}
