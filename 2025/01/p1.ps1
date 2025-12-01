$data = Get-Content input.txt
$dial = 50
$count = 0
foreach ($step in $data) {
    $currentvalue = [int]$step.Substring(1)
    if ($currentvalue -ge 100) {
        $currentvalue %= 100
    }
    switch -wildcard ($step) {
        'L*' { $dial -= $currentvalue }
        'R*' { $dial += $currentvalue }
    }
    if ($dial -lt 0) {
        $dial += 100
    }
    if ($dial -gt 100) {
        $dial -= 100
    }
    if ($dial -eq 100) {
        $dial = 0
    }
    if ($dial -eq 0) {
        $count++
    }
}
$count
