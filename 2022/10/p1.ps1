Param(
    [string]$filename
)

$data = Get-Content $filename
$register = 1
$cycle = 0
$sum = 0

foreach ($item in $data) {
    $action = $item.Split()[0]
    if ($action -eq 'addx') {
        $value = $item.Split()[1]
    }
    switch ($action) {
        'addx' {
            Write-Verbose "value: $value"
            $cycle += 2
            if ($cycle -ge 20 -and $cycle -lt 22) {
                $sum += ($register * 20)
            }
            elseif ($cycle -ge 60 -and $cycle -lt 62) {
                $sum += ($register * 60)
            }
            elseif ($cycle -ge 100 -and $cycle -lt 102) {
                $sum += ($register * 100)
            }
            elseif ($cycle -ge 140 -and $cycle -lt 142) {
                $sum += ($register * 140)
            }
            elseif ($cycle -ge 180 -and $cycle -lt 182) {
                $sum += ($register * 180)
            }
            elseif ($cycle -ge 220 -and $cycle -lt 222) {
                $sum += ($register * 220)
            }
            $register += $value
        }
        'noop' {
            $cycle++
            if ($cycle -eq 20) {
                $sum += ($register * 20)
            }
            elseif ($cycle -eq 60) {
                $sum += ($register * 60)
            }
            elseif ($cycle -eq 100) {
                $sum += ($register * 100)
            }
            elseif ($cycle -eq 140) {
                $sum += ($register * 140)
            }
            elseif ($cycle -eq 180) {
                $sum += ($register * 180)
            }
            elseif ($cycle -eq 220) {
                $sum += ($register * 220)
            }
        }
    }
}

Write-Host $sum
