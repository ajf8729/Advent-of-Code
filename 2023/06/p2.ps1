Param(
    [string]$filename
)

$data = Get-Content $filename

$time = ($data[0].Split(':')[1].trim() -replace '\s+', '')
$distance = ($data[1].Split(':')[1].trim() -replace '\s+', '')
$heldtime = 1
$wins = 0

while ($heldtime -lt $time) {
    $speed = $heldtime
    $timeleft = $time - $heldtime
    $distancetraveled = $timeleft * $speed
    if ($distancetraveled -gt $distance) {
        $wins++
    }
    $heldtime++
}

$wins
