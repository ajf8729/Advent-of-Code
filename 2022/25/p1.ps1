Param(
    [string]$filename
)

$data = Get-Content $filename
$decSum = 0

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
    $decSum += $decValue
}

<# converting from balanced base 5 to base 10

-2 <= r <= 2

4890/5 = 978 r  0
 978/5 = 196 r -2
 196/5 = 39  r  1
  39/5 = 8   r -1
   8/5 = 2   r -2
   2/5 = 0   r  2

"4890" == "2=-1=0"

dividand / divisor = quotient + remainder
#>

$dividand = $decSum
$result = ''

do {
    $quotient = [math]::floor($dividand / 5)
    $remainder = $dividand % 5
    if ($remainder -gt 2) {
        $quotient++
    }
    $result += $remainder
    $dividand = $quotient
} until ($quotient -eq 0)

$result = $result.ToCharArray()

for ($i = 0; $i -lt $result.Length; $i++) {
    switch ($result[$i]) {
        '3' {$result[$i] = '='}
        '4' {$result[$i] = '-'}
    }
}

[array]::Reverse($result)
$result = $result -join ''

return $result
