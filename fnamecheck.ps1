$folder = $args[0]

Get-ChildItem $folder -Recurse | Where-Object {$_.Name -match "[æøå\s]"}