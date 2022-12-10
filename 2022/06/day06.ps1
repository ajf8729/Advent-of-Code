#part 01
$data = Get-Content .\Day06Input.txt
$breakdown = for ($i = 0; $i -lt $data.Length - 3; $i++) {
    $data.Substring($i, 4)
}
$marker = 4
$breakdown | ForEach-Object {
    $unique = $_.ToCharArray() | Select-Object -Unique
    if ($unique.length -eq 4 -and $p1found -ne $true) {
        Write-Host "Part 01 answer is: $marker"
        $p1found = $true
    }
    $marker ++
}
#part 02
$data = Get-Content .\Day06Input.txt
$breakdown = for ($i = 0; $i -lt $data.Length - 13; $i++) {
    $data.Substring($i, 14)
}
$marker = 14
$breakdown | ForEach-Object {
    $unique = $_.ToCharArray() | Select-Object -Unique
    if ($unique.length -eq 14 -and $p2found -ne $true) {
        Write-Host "Part 02 answer is: $marker"
        $p2found = $true
    }
    $marker ++
}
