Param(
    [string]$filename
)

$data = Get-Content $filename
$data = $data.split(',')
$currentValue = 0
$sum = 0

foreach ($line in $data) {
    $chars = $line.ToCharArray()
    foreach ($char in $chars) {
        $asciiValue = [int][byte]$char
        $currentValue += $asciiValue
        $currentValue *= 17
        $currentValue %= 256
    }
    $sum += $currentValue
    $currentValue = 0
}

return $sum
