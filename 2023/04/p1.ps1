Param(
    [string]$filename
)

$data = Get-Content $filename
$matchedNumbers = 0
$total = 0

foreach ($line in $data) {
    $winningNumbers = [int[]]($line.Split(':')[1].trim().split('|')[0].split() | Where-Object {$_ -ne ''}) | Sort-Object
    $myNumbers = [int[]]($line.Split(':')[1].trim().split('|').trim()[1].split() | Where-Object {$_ -ne ''}) | Sort-Object
    foreach ($myNumber in $myNumbers) {
        if ($myNumber -in $winningNumbers) {
            $matchedNumbers++
        }
    }
    if ($matchedNumbers -gt 0) {
        $total += [math]::pow(2, $matchedNumbers - 1)
    }
    $matchedNumbers = 0
}

$total
