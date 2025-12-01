$data = Get-Content input.txt
$dial = 50
$count = 0
$dialzero = $false
foreach ($step in $data) {
    $currentvalue = [int]$step.Substring(1)
    if ($currentvalue -gt 100) {
        $hundreds = ($currentvalue - ($currentvalue % 100)) / 100
        $count += $hundreds
        $currentvalue %= 100
    }
    switch -wildcard ($step) {
        'L*' { $dial -= $currentvalue }
        'R*' { $dial += $currentvalue }
    }
    if ($dial -lt 0) {
        $dial += 100
        if (!$dialzero) {
            $count++
        }
    }
    if ($dial -gt 100) {
        $dial -= 100
        $count++
    }
    if ($dial -eq 100) {
        $dial = 0
    }
    $dialzero = $false
    if ($dial -eq 0) {
        $count++
        $dialzero = $true
    }
}
$count
