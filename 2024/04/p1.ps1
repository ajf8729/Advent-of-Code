$d = Get-Content d.txt
$xmas = 0
for ($i = 0; $i -lt $d.Length; $i++) {
    for ($j = 0; $j -lt $d[$i].Length; $j++) {
        if ($d[$i][$j] -eq 'X') {
            #up
            if (($i - 1) -ge 0 -and $d[$i - 1][$j] -eq 'M') {
                if (($i - 2) -ge 0 -and $d[$i - 2][$j] -eq 'A') {
                    if (($i - 3) -ge 0 -and $d[$i - 3][$j] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #left
            if (($j - 1) -ge 0 -and $d[$i][$j - 1] -eq 'M') {
                if (($j - 2) -ge 0 -and $d[$i][$j - 2] -eq 'A') {
                    if (($j - 3) -ge 0 -and $d[$i][$j - 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #down
            if (($i + 1) -lt $d.Length -and $d[$i + 1][$j] -eq 'M') {
                if (($i + 2) -lt $d.Length -and $d[$i + 2][$j] -eq 'A') {
                    if (($i + 3) -lt $d.Length -and $d[$i + 3][$j] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #right
            if (($j + 1) -lt $d[$i].Length -and $d[$i][$j + 1] -eq 'M') {
                if (($j + 2) -lt $d[$i].Length -and $d[$i][$j + 2] -eq 'A') {
                    if (($j + 3) -lt $d[$i].Length -and $d[$i][$j + 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #up-left
            if (($i - 1) -ge 0 -and ($j - 1) -ge 0 -and $d[$i - 1][$j - 1] -eq 'M') {
                if (($i - 2) -ge 0 -and ($j - 2) -ge 0 -and $d[$i - 2][$j - 2] -eq 'A') {
                    if (($i - 3) -ge 0 -and ($j - 3) -ge 0 -and $d[$i - 3][$j - 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #down-left
            if (($i + 1) -lt $d.Length -and ($j - 1) -ge 0 -and $d[$i + 1][$j - 1] -eq 'M') {
                if (($i + 2) -lt $d.Length -and ($j - 2) -ge 0 -and $d[$i + 2][$j - 2] -eq 'A') {
                    if (($i + 3) -lt $d.Length -and ($j - 3) -ge 0 -and $d[$i + 3][$j - 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #up-right
            if (($i - 1) -ge 0 -and ($j + 1) -lt $d[$i].Length -and $d[$i - 1][$j + 1] -eq 'M') {
                if (($i - 2) -ge 0 -and ($j + 2) -lt $d[$i].Length -and $d[$i - 2][$j + 2] -eq 'A') {
                    if (($i - 3) -ge 0 -and ($j + 3) -lt $d[$i].Length -and $d[$i - 3][$j + 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
            #down-right
            if (($i + 1) -lt $d.Length -and ($j + 1) -lt $d[$i].Length -and $d[$i + 1][$j + 1] -eq 'M') {
                if (($i + 2) -lt $d.Length -and ($j + 2) -lt $d[$i].Length -and $d[$i + 2][$j + 2] -eq 'A') {
                    if (($i + 3) -lt $d.Length -and ($j + 3) -lt $d[$i].Length -and $d[$i + 3][$j + 3] -eq 'S') {
                        $xmas++
                    }
                }
            }
        }
    }
}
$xmas
