Param(
    [string]$filename
)

$data = Get-Content $filename
$register = 1
$cycle = 0
$pixels = ''

foreach ($item in $data) {
    $action = $item.Split()[0]
    if ($action -eq 'addx') {
        $value = $item.Split()[1]
    }
    switch ($action) {
        'addx' {
            if ($register -eq ($cycle % 40) -or ($register - 1) -eq ($cycle % 40) -or ($register + 1) -eq ($cycle % 40)) {
                $pixels += '#'
            }
            else {
                $pixels += '.'
            }
            $cycle++
            if ($register -eq ($cycle % 40) -or ($register - 1) -eq ($cycle % 40) -or ($register + 1) -eq ($cycle % 40)) {
                $pixels += '#'
            }
            else {
                $pixels += '.'
            }
            $cycle++
            $register += $value
        }
        'noop' {
            if ($register -eq ($cycle % 40) -or ($register - 1) -eq ($cycle % 40) -or ($register + 1) -eq ($cycle % 40)) {
                $pixels += '#'
            }
            else {
                $pixels += '.'
            }
            $cycle++
        }
    }
}

Write-Host $pixels.Substring(0, 40)
Write-Host $pixels.Substring(40, 40)
Write-Host $pixels.Substring(80, 40)
Write-Host $pixels.Substring(120, 40)
Write-Host $pixels.Substring(160, 40)
Write-Host $pixels.Substring(200, 40)
