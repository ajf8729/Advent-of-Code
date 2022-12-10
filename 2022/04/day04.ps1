$data = Get-Content .\Day04Input.txt
$fullycontained = 0
$overlap = 0

foreach ($line in $data) {
    $workingset = $line.Split(',').Split('-')
    $a = [int]$workingset[0]
    $b = [int]$workingset[1]
    $c = [int]$workingset[2]
    $d = [int]$workingset[3]
    if ( ($c -ge $a -and $d -le $b) -or ($d -ge $b -and $c -le $a) ) {
        $fullycontained++
    }
    if ( ($c -le $a -and $d -ge $a) -or ($c -le $b -and $d -le $b -and $d -ge $a) -or ($c -le $b -and $d -ge $b) ) {
        $overlap++
    }
}

Write-Host "Part 01 Answer: $fullycontained"
Write-Host "Part 02 Answer: $overlap"
