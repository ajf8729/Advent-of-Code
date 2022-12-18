Param(
    [string]$filename
)

$data = Get-Content $filename
$totalExposedFaces = 0

foreach ($cubeA in $data) {
    $a = $cubeA.Split(',')[0]
    $b = $cubeA.Split(',')[1]
    $c = $cubeA.Split(',')[2]
    $exposedFaces = 6
    foreach ($cubeB in $data) {
        $d = $cubeB.Split(',')[0]
        $e = $cubeB.Split(',')[1]
        $f = $cubeB.Split(',')[2]
        if ( ($a -eq $d) -and ($b -eq $e) -and ($c -eq $f) ) {
            continue
        }
        if ( ((([Math]::Abs($a - $d)) -eq 1) -and (([Math]::Abs($b - $e)) -eq 0) -and (([Math]::Abs($c - $f)) -eq 0)) -or
             ((([Math]::Abs($a - $d)) -eq 0) -and (([Math]::Abs($b - $e)) -eq 1) -and (([Math]::Abs($c - $f)) -eq 0)) -or
             ((([Math]::Abs($a - $d)) -eq 0) -and (([Math]::Abs($b - $e)) -eq 0) -and (([Math]::Abs($c - $f)) -eq 1)) ) {
            $exposedFaces--
        }
        if ($exposedFaces -eq 0) {
            continue
        }
    }
    $totalExposedFaces += $exposedFaces
}

Write-Host "total exposed faces: $totalExposedFaces"
