$data = Get-Content .\Day02Input.txt
$points1 = 0
$points2 = 0

foreach ($line in $data) {
    switch ($line) {
        'A X' {$points1 += 4; $points2 += 3}
        'A Y' {$points1 += 8; $points2 += 4}
        'A Z' {$points1 += 3; $points2 += 8}
        'B X' {$points1 += 1; $points2 += 1}
        'B Y' {$points1 += 5; $points2 += 5}
        'B Z' {$points1 += 9; $points2 += 9}
        'C X' {$points1 += 7; $points2 += 2}
        'C Y' {$points1 += 2; $points2 += 6}
        'C Z' {$points1 += 6; $points2 += 7}
    }
}

Write-Host "Part 1 Answer: $points1"
Write-Host "Part 2 Answer: $points2"
