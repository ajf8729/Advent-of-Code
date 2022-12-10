[CmdletBinding()]
Param(
    [string]$filename
)

$data = Get-Content $filename
$rows = $data[0].Length
$cols = $data.Length
$highScore = 0
$visible = 0

for ($row = 1; $row -lt $rows - 1; $row++) {
    $visibleFromAbove = 0
    $visibleFromBelow = 0
    $visibleFromLeft = 0
    $visibleFromRight = 0
    $abovePoints = 0
    $belowPoints = 0
    $leftPoints = 0
    $rightPoints = 0
    Write-Verbose "begin row: $row"
    Write-Verbose ''
    for ($col = 1; $col -lt $cols - 1; $col++) {
        #$data
        $visibleFromAbove = 0
        $visibleFromBelow = 0
        $visibleFromLeft = 0
        $visibleFromRight = 0
        $abovePoints = 0
        $belowPoints = 0
        $leftPoints = 0
        $rightPoints = 0
        Write-Verbose "begin col: $col"
        Write-Verbose ''
        $currentTree = $data[$row][$col]
        Write-Verbose "currentTree number: $currentTree, at position ($row,$col)"
        Write-Verbose ''
        Write-Verbose 'begin above check'
        $blocked = $false
        for ($i = $row - 1; $i -ge 0; $i--) {
            if ($currentTree -gt $data[$i][$col]) {
                Write-Verbose "$currentTree is visible from above ($($data[$i][$col]))"
                $visibleFromAbove++
                if (!$blocked) {
                    $abovePoints++
                }
                Write-Verbose "above points: $abovePoints"
            }
            else {
                Write-Verbose "$currentTree is not visible from above ($($data[$i][$col]))"
                if ($currentTree -le $($data[$i][$col])) {
                    Write-Verbose 'blocked'
                    $blocked = $true
                }
                if ($blocked) {
                    If (!$addedBlockedPoint) {
                        Write-Verbose 'adding blocked point'
                        $abovePoints++
                        Write-Verbose "above points: $abovePoints"
                        $addedBlockedPoint = $true
                    }
                }
            }
            Write-Verbose ''
            Write-Verbose 'next tree'
        }
        Write-Verbose ''
        Write-Verbose 'begin below check'
        $blocked = $false
        for ($i = $row + 1; $i -lt $rows; $i++) {
            if ($currentTree -gt $data[$i][$col]) {
                Write-Verbose "$currentTree is visible from below ($($data[$i][$col]))"
                $visibleFromBelow++
                if (!$blocked) {
                    $belowPoints++
                }
                Write-Verbose "below points: $belowPoints"
            }
            else {
                Write-Verbose "$currentTree is not visible from below ($($data[$i][$col]))"
                if ($currentTree -le $data[$i][$col]) {
                    Write-Verbose 'blocked'
                    $blocked = $true
                }
                if ($blocked) {
                    If (!$addedBlockedPoint) {
                        Write-Verbose 'adding blocked point'
                        $belowPoints++
                        Write-Verbose "below points: $belowPoints"
                        $addedBlockedPoint = $true
                    }
                }
            }
            Write-Verbose ''
            Write-Verbose 'next tree'
        }
        $addedBlockedPoint = $false
        Write-Verbose ''
        Write-Verbose 'begin left check'
        $blocked = $false
        for ($i = $col - 1; $i -ge 0; $i--) {
            if ($currentTree -gt $data[$row][$i]) {
                Write-Verbose "$currentTree is visible from the left ($($data[$row][$i]))"
                $visibleFromLeft++
                if (!$blocked) {
                    $leftPoints++
                }
                Write-Verbose "left points: $leftPoints"
            }
            else {
                Write-Verbose "$currentTree is not visible from the left ($($data[$row][$i]))"
                if ($currentTree -le $data[$row][$i]) {
                    Write-Verbose 'blocked'
                    $blocked = $true
                }
                if ($blocked) {
                    If (!$addedBlockedPoint) {
                        Write-Verbose 'adding blocked point'
                        $leftPoints++
                        Write-Verbose "left points: $leftPoints"
                        $addedBlockedPoint = $true
                    }
                }
            }
            Write-Verbose ''
            Write-Verbose 'next tree'
        }
        $addedBlockedPoint = $false
        Write-Verbose ''
        Write-Verbose 'begin right check'
        $blocked = $false
        for ($i = $col + 1; $i -lt $cols; $i++) {
            if ($currentTree -gt $data[$row][$i]) {
                Write-Verbose "$currentTree is visible from the right ($($data[$row][$i]))"
                $visibleFromRight++
                if (!$blocked) {
                    $rightPoints++
                }
                Write-Verbose "right points: $rightPoints"
            }
            else {
                Write-Verbose "$currentTree is not visible from the right ($($data[$row][$i]))"
                if ($currentTree -le $data[$row][$i]) {
                    Write-Verbose 'blocked'
                    $blocked = $true
                }
                if ($blocked) {
                    If (!$addedBlockedPoint) {
                        Write-Verbose 'adding blocked point'
                        $rightPoints++
                        Write-Verbose "right points: $rightPoints"
                        $addedBlockedPoint = $true
                    }
                }
            }
            Write-Verbose ''
            Write-Verbose 'next tree'
        }
        $addedBlockedPoint = $false
        if (($visibleFromAbove -eq $row) -or ($visibleFromBelow -eq $rows - ($row + 1)) -or ($visibleFromLeft -eq $col) -or ($visibleFromRight -eq $cols - ($col + 1))) {
            Write-Verbose ''
            Write-Verbose "$currentTree is visible"
            $visible++
            $visibleFromAbove = 0
            $visibleFromBelow = 0
            $visibleFromLeft = 0
            $visibleFromRight = 0
        }
        Write-Verbose ''
        Write-Verbose 'begin points check'
        Write-Verbose "above points: $abovePoints"
        Write-Verbose "below points: $belowPoints"
        Write-Verbose "left points: $leftPoints"
        Write-Verbose "right points: $rightPoints"
        $score = ($abovePoints) * ($belowPoints) * ($leftPoints) * ($rightPoints)
        Write-Verbose "score: $score"
        if ($score -gt $highScore) {
            $highScore = $score
        }
        Write-Verbose ''
        Write-Verbose "col $col done"
    }
    Write-Verbose ''
    Write-Verbose "row $row done"
}
Write-Verbose ''
Write-Verbose 'all done'

$edges = ($data[0].Length * 2) + (($data.Length - 2) * 2)

Write-Verbose "edges: $edges"
Write-Verbose "visible: $visible"
$total = $edges + $visible
Write-Host "Part 01 answer: $total"
Write-Host "Part 02 answer: $highScore"
