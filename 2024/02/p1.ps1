$d = Get-Content d.txt
$totalsafe = 0
$d | ForEach-Object {
    $line = [int[]]$_.Split() -join ''
    $lineasc = ([int[]]$_.split() | Sort-Object) -join ''
    $linedesc = ([int[]]$_.split() | Sort-Object -desc) -join ''
    if (($_.split().count) -eq (($_.split() | Select-Object -Unique).count)) {
        if (($line -eq $lineasc) -xor ($line -eq $linedesc)) {
            $bad = $false
            $nums = $_.Split()
            $length = $nums.length
            for ($i = 0; $i -lt ($length - 1); $i++) {
                $x = $nums[$i]
                $y = $nums[$i + 1]
                if (([math]::abs($x - $y)) -gt 3) {
                    $bad = $true
                }
                if ($bad) {
                    break
                }
            }
            if (!$bad) {
                $totalsafe++
            }
        }
    }
}
$totalsafe
