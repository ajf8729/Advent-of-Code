$d = Get-Content d.txt
$xmas = 0
for ($i = 1; $i -lt $d.Length - 1; $i++) {
    for ($j = 1; $j -lt $d[$i].Length - 1; $j++) {
        if ($d[$i][$j] -eq 'A') {
            if ($d[$i - 1][$j - 1] -eq 'M' -and $d[$i - 1][$j + 1] -eq 'M' -and $d[$i + 1][$j - 1] -eq 'S' -and $d[$i + 1][$j + 1] -eq 'S') {
                $xmas++
            }
            if ($d[$i - 1][$j - 1] -eq 'S' -and $d[$i - 1][$j + 1] -eq 'M' -and $d[$i + 1][$j - 1] -eq 'S' -and $d[$i + 1][$j + 1] -eq 'M') {
                $xmas++
            }
            if ($d[$i - 1][$j - 1] -eq 'S' -and $d[$i - 1][$j + 1] -eq 'S' -and $d[$i + 1][$j - 1] -eq 'M' -and $d[$i + 1][$j + 1] -eq 'M') {
                $xmas++
            }
            if ($d[$i - 1][$j - 1] -eq 'M' -and $d[$i - 1][$j + 1] -eq 'S' -and $d[$i + 1][$j - 1] -eq 'M' -and $d[$i + 1][$j + 1] -eq 'S') {
                $xmas++
            }
        }
    }
}
$xmas
