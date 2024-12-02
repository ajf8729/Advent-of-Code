function test-stuff {
    param (
        $data
    )
    $data | ForEach-Object {
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
                    $safe = $true
                }
                else {
                    $safe = $false
                }
            }
        }
    }
    return $safe
}

$d = Get-Content d.txt
$totalsafe = 0
$d | ForEach-Object {
    if (test-stuff -data $_) {
        $totalsafe++
    }
    else {
        $nums = $_.Split()
        $length = $nums.length
        for ($i = 0; $i -lt $length; $i++) {
            $list = [System.Collections.Generic.List[System.Object]]($nums)
            $list.RemoveAt($i)
            if (test-stuff -data ($list.ToArray() -join ' ')) {
                $totalsafe++
                break
            }
        }
    }
}
$totalsafe
