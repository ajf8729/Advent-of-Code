[CmdletBinding()]
Param(
    [string]$filename
)

$moves = Get-Content $filename
$headCoordinates = 0, 0
$tailCoordinates = 0, 0
$tailCoordinatesVisited = @{}

foreach ($move in $moves) {
    $direction = $move.Split()[0]
    $steps = $move.Split()[1]
    for ($i = 0; $i -lt $steps; $i++) {
        switch ($direction) {
            'R' {$headCoordinates[0]++; break}
            'L' {$headCoordinates[0]--; break}
            'U' {$headCoordinates[1]++; break}
            'D' {$headCoordinates[1]--; break}
        }
        if ($headCoordinates[0] -eq $tailCoordinates[0] -and $headCoordinates[1] -eq $tailCoordinates[1]) {
            $xSeparation = 0
            $ySeparation = 0
        }
        elseif ($headCoordinates[0] -eq $tailCoordinates[0] -and $headCoordinates[1] -ne $tailCoordinates[1]) {
            $xSeparation = 0
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        elseif ($headCoordinates[0] -ne $tailCoordinates[0] -and $headCoordinates[1] -eq $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = 0
        }
        elseif ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        elseif ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
            $xSeparation = $tailCoordinates[0] - $headCoordinates[0]
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        elseif ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = $tailCoordinates[1] - $headCoordinates[1]
        }
        elseif ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
            $xSeparation = $tailCoordinates[0] - $headCoordinates[0]
            $ySeparation = $tailCoordinates[1] - $headCoordinates[1]
        }
        $distanceApart = [Math]::Sqrt([Math]::Pow($xSeparation, 2) + [Math]::Pow($ySeparation, 2))
        switch ($distanceApart) {
            2 {
                switch ($direction) {
                    'R' {$tailCoordinates[0]++; break}
                    'L' {$tailCoordinates[0]--; break}
                    'U' {$tailCoordinates[1]++; break}
                    'D' {$tailCoordinates[1]--; break}
                }
                break
            }
            ([Math]::Sqrt(5)) {
                if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
                    $tailCoordinates[0]++
                    $tailCoordinates[1]++
                }
                elseif ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
                    $tailCoordinates[0]--
                    $tailCoordinates[1]++
                }
                elseif ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
                    $tailCoordinates[0]++
                    $tailCoordinates[1]--
                }
                elseif ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
                    $tailCoordinates[0]--
                    $tailCoordinates[1]--
                }
                break
            }
        }
        if ($null -eq $tailCoordinatesVisited[[string]$tailCoordinates]) {
            [string]$key = $tailCoordinates
            [int]$val = 1
            $tailCoordinatesVisited.Add($key, $val)
        }
        else {
            $tailCoordinatesVisited[[string]$tailCoordinates]++
        }
    }
}

Write-Host "Tail coordinates visited: $($tailCoordinatesVisited.Count)"
