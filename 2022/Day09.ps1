[CmdletBinding()]
Param(
    [string]$filename
)

$moves = Get-Content $filename
$headCoordinates = 0, 0
$tailCoordinates = 0, 0
$tailCoordinatesVisited = @{}
$headCoordinatesVisited = @{}

foreach ($move in $moves) {
    Write-Verbose 'begin move'
    $direction = $move.Split()[0]
    $steps = $move.Split()[1]
    Write-Verbose "direction:                $direction"
    Write-Verbose "steps:                    $steps"
    for ($i = 0; $i -lt $steps; $i++) {
        Write-Verbose "current head coordinates: $headCoordinates"
        Write-Verbose "current tail coordinates: $tailCoordinates"
        Write-Verbose "move 1 step in direction: $direction"
        switch ($direction) {
            'R' {$headCoordinates[0]++}
            'L' {$headCoordinates[0]--}
            'U' {$headCoordinates[1]++}
            'D' {$headCoordinates[1]--}
        }
        Write-Verbose "new head coordinates:     $headCoordinates"
        # head is on top of tail
        if ($headCoordinates[0] -eq $tailCoordinates[0] -and $headCoordinates[1] -eq $tailCoordinates[1]) {
            $xSeparation = 0
            $ySeparation = 0
        }
        # head is above tail
        if ($headCoordinates[0] -eq $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
            $xSeparation = 0
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        # head is below tail
        if ($headCoordinates[0] -eq $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
            $xSeparation = 0
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        # head is right of tail
        if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -eq $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = 0
        }
        # head is left of tail
        if ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -eq $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = 0
        }
        # head is up & right from tail
        if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        # head is up & left from tail
        if ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
            $xSeparation = $tailCoordinates[0] - $headCoordinates[0]
            $ySeparation = $headCoordinates[1] - $tailCoordinates[1]
        }
        # head is down & right from tail
        if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
            $xSeparation = $headCoordinates[0] - $tailCoordinates[0]
            $ySeparation = $tailCoordinates[1] - $headCoordinates[1]
        }
        # head is down & left from tail
        if ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
            $xSeparation = $tailCoordinates[0] - $headCoordinates[0]
            $ySeparation = $tailCoordinates[1] - $headCoordinates[1]
        }
        Write-Verbose "x xeparation:             $xSeparation"
        Write-Verbose "y xeparation:             $ySeparation"
        $distanceApart = [Math]::Sqrt([Math]::Pow($xSeparation, 2) + [Math]::Pow($ySeparation, 2))
        Write-Verbose "distance apart:           $distanceApart"
        switch ($distanceApart) {
            0 {
                break
            }
            1 {
                break
            }
            ([Math]::Sqrt(2)) {
                break
            }
            2 {
                switch ($direction) {
                    'R' {$tailCoordinates[0]++}
                    'L' {$tailCoordinates[0]--}
                    'U' {$tailCoordinates[1]++}
                    'D' {$tailCoordinates[1]--}
                }
                break
            }
            ([Math]::Sqrt(5)) {
                # head is up & right from tail
                if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
                    $tailCoordinates[0]++
                    $tailCoordinates[1]++
                }
                # head is up & left from tail
                if ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -gt $tailCoordinates[1]) {
                    $tailCoordinates[0]--
                    $tailCoordinates[1]++
                }
                # head is down & right from tail
                if ($headCoordinates[0] -gt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
                    $tailCoordinates[0]++
                    $tailCoordinates[1]--
                }
                # head is down & left from tail
                if ($headCoordinates[0] -lt $tailCoordinates[0] -and $headCoordinates[1] -lt $tailCoordinates[1]) {
                    $tailCoordinates[0]--
                    $tailCoordinates[1]--
                }
                break
            }
            default {
                Write-Host 'shit is fucked'
                exit
            }
        }
        if ($null -eq $headCoordinatesVisited[[string]$headCoordinates]) {
            [string]$key = $headCoordinates
            [int]$val = 1
            $headCoordinatesVisited.Add($key, $val)
        }
        else {
            $headCoordinatesVisited[[string]$headCoordinates]++
        }
        if ($null -eq $tailCoordinatesVisited[[string]$tailCoordinates]) {
            [string]$key = $tailCoordinates
            [int]$val = 1
            $tailCoordinatesVisited.Add($key, $val)
        }
        else {
            $tailCoordinatesVisited[[string]$tailCoordinates]++
        }
        Write-Verbose "new tail coordinates:     $tailCoordinates"
    }
    if ($PSBoundParameters['Verbose']) {
        #Pause
    }
    Write-Verbose 'end move'
    Write-Verbose ''
}
if ($PSBoundParameters['Verbose']) {
    #Pause
}
Write-Host "tail coordinates visited: $($tailCoordinatesVisited.count)"
