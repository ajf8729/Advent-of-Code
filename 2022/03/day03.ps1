$data = Get-Content .\Day03Input.txt
$total = 0
$total2 = 0
foreach ($line in $data) {
    $firsthalf = ($line.Substring(0, $line.Length / 2)).ToCharArray() | Select-Object -Unique
    $secondhalf = ($line.Substring($line.Length / 2, $line.Length / 2)).ToCharArray() | Select-Object -Unique
    $dupe = ($firsthalf + $secondhalf) | Group-Object | Where-Object {$_.count -gt 1} | Select-Object -expand name
    switch -CaseSensitive ($dupe) {
        'a' {$total += 1}
        'b' {$total += 2}
        'c' {$total += 3}
        'd' {$total += 4}
        'e' {$total += 5}
        'f' {$total += 6}
        'g' {$total += 7}
        'h' {$total += 8}
        'i' {$total += 9}
        'j' {$total += 10}
        'k' {$total += 11}
        'l' {$total += 12}
        'm' {$total += 13}
        'n' {$total += 14}
        'o' {$total += 15}
        'p' {$total += 16}
        'q' {$total += 17}
        'r' {$total += 18}
        's' {$total += 19}
        't' {$total += 20}
        'u' {$total += 21}
        'v' {$total += 22}
        'w' {$total += 23}
        'x' {$total += 24}
        'y' {$total += 25}
        'z' {$total += 26}
        'A' {$total += 27}
        'B' {$total += 28}
        'C' {$total += 29}
        'D' {$total += 30}
        'E' {$total += 31}
        'F' {$total += 32}
        'G' {$total += 33}
        'H' {$total += 34}
        'I' {$total += 35}
        'J' {$total += 36}
        'K' {$total += 37}
        'L' {$total += 38}
        'M' {$total += 39}
        'N' {$total += 40}
        'O' {$total += 41}
        'P' {$total += 42}
        'Q' {$total += 43}
        'R' {$total += 44}
        'S' {$total += 45}
        'T' {$total += 46}
        'U' {$total += 47}
        'V' {$total += 48}
        'W' {$total += 49}
        'X' {$total += 50}
        'Y' {$total += 51}
        'Z' {$total += 52}
    }
}

$i = 1
foreach ($line in $data) {
    $check = $i % 3
    if ($check -eq 1) {
        $line1 = $line
        $i++
    }
    if ($check -eq 2) {
        $line2 = $line
        $i++
    }
    if ($check -eq 0) {
        $line3 = $line        
        $line1ca = $line1.ToCharArray()
        $line2ca = $line2.ToCharArray()
        $line3ca = $line3.ToCharArray()
        $line12match = ($line1ca | Where-Object {$line2ca -contains $_} | Select-Object -Unique) -join ''
        $line23match = ($line2ca | Where-Object {$line3ca -contains $_} | Select-Object -Unique) -join ''
        $line31match = ($line3ca | Where-Object {$line1ca -contains $_} | Select-Object -Unique) -join ''
        $allthree = $line12match + $line23match + $line31match
        $badge = $allthree.ToCharArray() | Group-Object | Where-Object {$_.count -eq 3} | Select-Object -expand name
        switch -CaseSensitive ($badge) {
            'a' {$total2 += 1}
            'b' {$total2 += 2}
            'c' {$total2 += 3}
            'd' {$total2 += 4}
            'e' {$total2 += 5}
            'f' {$total2 += 6}
            'g' {$total2 += 7}
            'h' {$total2 += 8}
            'i' {$total2 += 9}
            'j' {$total2 += 10}
            'k' {$total2 += 11}
            'l' {$total2 += 12}
            'm' {$total2 += 13}
            'n' {$total2 += 14}
            'o' {$total2 += 15}
            'p' {$total2 += 16}
            'q' {$total2 += 17}
            'r' {$total2 += 18}
            's' {$total2 += 19}
            't' {$total2 += 20}
            'u' {$total2 += 21}
            'v' {$total2 += 22}
            'w' {$total2 += 23}
            'x' {$total2 += 24}
            'y' {$total2 += 25}
            'z' {$total2 += 26}
            'A' {$total2 += 27}
            'B' {$total2 += 28}
            'C' {$total2 += 29}
            'D' {$total2 += 30}
            'E' {$total2 += 31}
            'F' {$total2 += 32}
            'G' {$total2 += 33}
            'H' {$total2 += 34}
            'I' {$total2 += 35}
            'J' {$total2 += 36}
            'K' {$total2 += 37}
            'L' {$total2 += 38}
            'M' {$total2 += 39}
            'N' {$total2 += 40}
            'O' {$total2 += 41}
            'P' {$total2 += 42}
            'Q' {$total2 += 43}
            'R' {$total2 += 44}
            'S' {$total2 += 45}
            'T' {$total2 += 46}
            'U' {$total2 += 47}
            'V' {$total2 += 48}
            'W' {$total2 += 49}
            'X' {$total2 += 50}
            'Y' {$total2 += 51}
            'Z' {$total2 += 52}
        }
        $i = 1
    }
}

Write-Host "Part 1 Answer: $total"
Write-Host "Part 2 Answer: $total2"
