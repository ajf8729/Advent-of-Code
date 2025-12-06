$data = Get-Content .\input.txt | Out-String
$nl = [System.Environment]::NewLine
$data = $data -split "$nl$nl"
$ranges = $data[0] -split $nl
$items = $data[1].Trim() -split $nl
$valid = 0
foreach ($item in $items) {
    foreach ($range in $ranges) {
        [bigint]$low = ($range -split '-')[0]
        [bigint]$high = ($range -split '-')[1]
        if ([bigint]$item -ge $low -and [bigint]$item -le $high) {
            $valid++
            break
        }
    }
}
$valid
