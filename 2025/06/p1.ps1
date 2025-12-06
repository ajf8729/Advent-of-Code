$data = Get-Content .\input.txt
$rowcount = $data.Length
[Collections.ArrayList]$lines = @()
$total = 0
$temptotal = 0
foreach ($line in $data) {
    $line = ($line -replace '\s+', ' ').Trim() -split ' '
    $lines.Add($line) | Out-Null
}
$colcount = $lines.Length | Select-Object -First 1
for ($i = 0; $i -lt $colcount; $i++) {
    $operation = $lines[-1][$i]
    for ($j = 0; $j -lt $rowcount - 1; $j++) {
        switch ($operation) {
            '+' {
                $temptotal += $lines[$j][$i]
            }
            '*' {
                if ($temptotal -eq 0) {
                    $temptotal = 1
                }
                $temptotal *= $lines[$j][$i]
            }
        }
    }
    $total += $temptotal
    $temptotal = 0
}
$total
