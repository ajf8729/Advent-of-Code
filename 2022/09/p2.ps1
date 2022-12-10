[CmdletBinding()]
Param(
    [string]$filename
)

function Move-Head {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$direction,
        [Parameter(Mandatory = $true)]
        $headCoordinates,
        [Parameter(Mandatory = $true)]
        $tailCoordinates
    )

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
    return $headCoordinates, $tailCoordinates
}

function Move-Tail {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        $tailACoordinates,
        [Parameter(Mandatory = $true)]
        $tailBCoordinates
    )

    if ($tailACoordinates[0] -eq $tailBCoordinates[0] -and $tailACoordinates[1] -eq $tailBCoordinates[1]) {
        $xSeparation = 0
        $ySeparation = 0
    }
    elseif ($tailACoordinates[0] -eq $tailBCoordinates[0] -and $tailACoordinates[1] -ne $tailBCoordinates[1]) {
        $xSeparation = 0
        $ySeparation = $tailACoordinates[1] - $tailBCoordinates[1]
    }
    elseif ($tailACoordinates[0] -ne $tailBCoordinates[0] -and $tailACoordinates[1] -eq $tailBCoordinates[1]) {
        $xSeparation = $tailACoordinates[0] - $tailBCoordinates[0]
        $ySeparation = 0
    }
    elseif ($tailACoordinates[0] -gt $tailBCoordinates[0] -and $tailACoordinates[1] -gt $tailBCoordinates[1]) {
        $xSeparation = $tailACoordinates[0] - $tailBCoordinates[0]
        $ySeparation = $tailACoordinates[1] - $tailBCoordinates[1]
    }
    elseif ($tailACoordinates[0] -lt $tailBCoordinates[0] -and $tailACoordinates[1] -gt $tailBCoordinates[1]) {
        $xSeparation = $tailBCoordinates[0] - $tailACoordinates[0]
        $ySeparation = $tailACoordinates[1] - $tailBCoordinates[1]
    }
    elseif ($tailACoordinates[0] -gt $tailBCoordinates[0] -and $tailACoordinates[1] -lt $tailBCoordinates[1]) {
        $xSeparation = $tailACoordinates[0] - $tailBCoordinates[0]
        $ySeparation = $tailBCoordinates[1] - $tailACoordinates[1]
    }
    elseif ($tailACoordinates[0] -lt $tailBCoordinates[0] -and $tailACoordinates[1] -lt $tailBCoordinates[1]) {
        $xSeparation = $tailBCoordinates[0] - $tailACoordinates[0]
        $ySeparation = $tailBCoordinates[1] - $tailACoordinates[1]
    }
    $distanceApart = [Math]::Sqrt([Math]::Pow($xSeparation, 2) + [Math]::Pow($ySeparation, 2))
    switch ($distanceApart) {
        2 {
            if ($tailACoordinates[0] -gt $tailBCoordinates[0]) {
                $tailBCoordinates[0]++
            }
            if ($tailACoordinates[0] -lt $tailBCoordinates[0]) {
                $tailACoordinates[0]++
            }
            if ($tailACoordinates[1] -gt $tailBCoordinates[1]) {
                $tailBCoordinates[1]++
            }
            if ($tailACoordinates[1] -lt $tailBCoordinates[1]) {
                $tailACoordinates[0]++
            }
            break
        }
        ([Math]::Sqrt(5)) {
            if ($tailACoordinates[0] -gt $tailBCoordinates[0] -and $tailACoordinates[1] -gt $tailBCoordinates[1]) {
                $tailBCoordinates[0]++
                $tailBCoordinates[1]++
            }
            elseif ($tailACoordinates[0] -lt $tailBCoordinates[0] -and $tailACoordinates[1] -gt $tailBCoordinates[1]) {
                $tailBCoordinates[0]--
                $tailBCoordinates[1]++
            }
            elseif ($tailACoordinates[0] -gt $tailBCoordinates[0] -and $tailACoordinates[1] -lt $tailBCoordinates[1]) {
                $tailBCoordinates[0]++
                $tailBCoordinates[1]--
            }
            elseif ($tailACoordinates[0] -lt $tailBCoordinates[0] -and $tailACoordinates[1] -lt $tailBCoordinates[1]) {
                $tailBCoordinates[0]--
                $tailBCoordinates[1]--
            }
            break
        }
    }
    return $tailACoordinates, $tailBCoordinates
}

$moves = Get-Content $filename
$hCoordinates = 0, 0
$t1Coordinates = 0, 0
$t2Coordinates = 0, 0
$t3Coordinates = 0, 0
$t4Coordinates = 0, 0
$t5Coordinates = 0, 0
$t6Coordinates = 0, 0
$t7Coordinates = 0, 0
$t8Coordinates = 0, 0
$t9Coordinates = 0, 0
$t1CoordinatesVisited = @{}
$t2CoordinatesVisited = @{}
$t3CoordinatesVisited = @{}
$t4CoordinatesVisited = @{}
$t5CoordinatesVisited = @{}
$t6CoordinatesVisited = @{}
$t7CoordinatesVisited = @{}
$t8CoordinatesVisited = @{}
$t9CoordinatesVisited = @{}

foreach ($move in $moves) {
    $direction = $move.Split()[0]
    $steps = $move.Split()[1]
    for ($i = 0; $i -lt $steps; $i++) {
        $hCoordinates, $t1Coordinates = Move-Head -direction $direction -headCoordinates $hCoordinates -tailCoordinates $t1Coordinates
        if ($null -eq $t1CoordinatesVisited[[string]$t1Coordinates]) {
            [string]$key = $t1Coordinates
            [int]$val = 1
            $t1CoordinatesVisited.Add($key, $val)
        }
        else {
            $t1CoordinatesVisited[[string]$t1Coordinates]++
        }
        $t1Coordinates, $t2Coordinates = Move-Tail -tailACoordinates $t1Coordinates -tailBCoordinates $t2Coordinates
        if ($null -eq $t2CoordinatesVisited[[string]$t2Coordinates]) {
            [string]$key = $t2Coordinates
            [int]$val = 1
            $t2CoordinatesVisited.Add($key, $val)
        }
        else {
            $t2CoordinatesVisited[[string]$t2Coordinates]++
        }
        $t2Coordinates, $t3Coordinates = Move-Tail -tailACoordinates $t2Coordinates -tailBCoordinates $t3Coordinates
        if ($null -eq $t3CoordinatesVisited[[string]$t3Coordinates]) {
            [string]$key = $t3Coordinates
            [int]$val = 1
            $t3CoordinatesVisited.Add($key, $val)
        }
        else {
            $t3CoordinatesVisited[[string]$t3Coordinates]++
        }
        $t3Coordinates, $t4Coordinates = Move-Tail -tailACoordinates $t3Coordinates -tailBCoordinates $t4Coordinates
        if ($null -eq $t4CoordinatesVisited[[string]$t4Coordinates]) {
            [string]$key = $t4Coordinates
            [int]$val = 1
            $t4CoordinatesVisited.Add($key, $val)
        }
        else {
            $t4CoordinatesVisited[[string]$t4Coordinates]++
        }
        $t4Coordinates, $t5Coordinates = Move-Tail -tailACoordinates $t4Coordinates -tailBCoordinates $t5Coordinates
        if ($null -eq $t5CoordinatesVisited[[string]$t5Coordinates]) {
            [string]$key = $t5Coordinates
            [int]$val = 1
            $t5CoordinatesVisited.Add($key, $val)
        }
        else {
            $t5CoordinatesVisited[[string]$t5Coordinates]++
        }
        $t5Coordinates, $t6Coordinates = Move-Tail -tailACoordinates $t5Coordinates -tailBCoordinates $t6Coordinates
        if ($null -eq $t6CoordinatesVisited[[string]$t6Coordinates]) {
            [string]$key = $t6Coordinates
            [int]$val = 1
            $t6CoordinatesVisited.Add($key, $val)
        }
        else {
            $t6CoordinatesVisited[[string]$t6Coordinates]++
        }
        $t6Coordinates, $t7Coordinates = Move-Tail -tailACoordinates $t6Coordinates -tailBCoordinates $t7Coordinates
        if ($null -eq $t7CoordinatesVisited[[string]$t7Coordinates]) {
            [string]$key = $t7Coordinates
            [int]$val = 1
            $t7CoordinatesVisited.Add($key, $val)
        }
        else {
            $t7CoordinatesVisited[[string]$t7Coordinates]++
        }
        $t7Coordinates, $t8Coordinates = Move-Tail -tailACoordinates $t7Coordinates -tailBCoordinates $t8Coordinates
        if ($null -eq $t8CoordinatesVisited[[string]$t8Coordinates]) {
            [string]$key = $t8Coordinates
            [int]$val = 1
            $t8CoordinatesVisited.Add($key, $val)
        }
        else {
            $t8CoordinatesVisited[[string]$t8Coordinates]++
        }
        $t8Coordinates, $t9Coordinates = Move-Tail -tailACoordinates $t8Coordinates -tailBCoordinates $t9Coordinates
        if ($null -eq $t9CoordinatesVisited[[string]$t9Coordinates]) {
            [string]$key = $t9Coordinates
            [int]$val = 1
            $t9CoordinatesVisited.Add($key, $val)
        }
        else {
            $t9CoordinatesVisited[[string]$t9Coordinates]++
        }
    }
}

Write-Host "Tail 1 coordinates visited: $($t1CoordinatesVisited.Count)"
Write-Host "Tail 2 coordinates visited: $($t2CoordinatesVisited.Count)"
Write-Host "Tail 3 coordinates visited: $($t3CoordinatesVisited.Count)"
Write-Host "Tail 4 coordinates visited: $($t4CoordinatesVisited.Count)"
Write-Host "Tail 5 coordinates visited: $($t5CoordinatesVisited.Count)"
Write-Host "Tail 6 coordinates visited: $($t6CoordinatesVisited.Count)"
Write-Host "Tail 7 coordinates visited: $($t7CoordinatesVisited.Count)"
Write-Host "Tail 8 coordinates visited: $($t8CoordinatesVisited.Count)"
Write-Host "Tail 9 coordinates visited: $($t9CoordinatesVisited.Count)"
