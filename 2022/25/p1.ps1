Param(
    [string]$filename
)

$data = Get-Content $filename
$dividand = 0
$result = ''

foreach ($line in $data) {
    $snafuDigits = $line.ToCharArray()
    $decValue = 0
    [array]::Reverse($snafuDigits)
    for ($i = 0; $i -lt $snafuDigits.Length; $i++) {
        switch ($snafuDigits[$i]) {
            '2' {$decValue += (2 * [math]::pow(5, $i))}
            '1' {$decValue += ([math]::pow(5, $i))}
            '-' {$decValue += (-1 * [math]::pow(5, $i))}
            '=' {$decValue += (-2 * [math]::pow(5, $i))}
        }
    }
    $dividand += $decValue
}

do {
    $quotient = [math]::floor($dividand / 5)
    $remainder = $dividand % 5
    if ($remainder -gt 2) {
        $quotient++
    }
    switch ($remainder) {
        '3' {$remainder = '='}
        '4' {$remainder = '-'}
    }
    $result += $remainder
    $dividand = $quotient
} until ($quotient -eq 0)

$result = $result.ToCharArray()
[array]::Reverse($result)

return $result -join ''
