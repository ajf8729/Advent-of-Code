Param(
    [string]$filename
)

$data = Get-Content $filename

$times = ($data[0].Split(':')[1].trim() -replace '\s+', ' ').split()
$distances = ($data[1].Split(':')[1].trim() -replace '\s+', ' ').split()
$races = $times.length
$heldtime = 1
$wins = 0
$winstotal = 1

for ($i = 0; $i -lt $races; $i++) {
    $time = $times[$i]
    $distance = $distances[$i]
    while ($heldtime -lt $time) {
        $speed = $heldtime
        $timeleft = $time - $heldtime
        $distancetraveled = $timeleft * $speed
        if ($distancetraveled -gt $distance) {
            $wins++
        }
        $heldtime++
    }
    $winstotal *= $wins
    $heldtime = 1
    $wins = 0
}

$winstotal
