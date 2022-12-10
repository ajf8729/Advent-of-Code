$data = Get-Content .\Day06Input.txt

$p1breakdown = for ($i = 0; $i -lt $data.Length - 3; $i++) {
    $data.Substring($i, 4)
}
$p2breakdown = for ($i = 0; $i -lt $data.Length - 13; $i++) {
    $data.Substring($i, 14)
}
$p1marker = 4
$p2marker = 14

foreach ($item in $p1breakdown) {
    $unique = $item.ToCharArray() | Select-Object -Unique
    if ($unique.length -eq 4) {
        break
    }
    $p1marker ++
}

foreach ($item in $p2breakdown) {
    $unique = $item.ToCharArray() | Select-Object -Unique
    if ($unique.length -eq 14) {
        break
    }
    $p2marker ++
}

Write-Host "Part 01 answer is: $p1marker"
Write-Host "Part 02 answer is: $p2marker"
