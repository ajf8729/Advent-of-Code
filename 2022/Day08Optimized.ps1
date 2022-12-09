[CmdletBinding()]
Param(
    [string]$filename
)

$data = Get-Content $filename
$rows = $data[0].Length
$cols = $data.Length
$edges = ($rows * 2) + (($cols - 2) * 2)
$highScore = 0
$visible = 0

for ($row = 1; $row -lt $rows - 1; $row++) {
    for ($col = 1; $col -lt $cols - 1; $col++) {
        $visibleFromAbove = 0
        $visibleFromBelow = 0
        $visibleFromLeft = 0
        $visibleFromRight = 0

        $abovePoints = 0
        $belowPoints = 0
        $leftPoints = 0
        $rightPoints = 0

        $currentTree = $data[$row][$col]

        $addedBlockedPoint = $false
        $blocked = $false

        for ($i = $row - 1; $i -ge 0; $i--) {
            if ($currentTree -gt $data[$i][$col]) {
                $visibleFromAbove++
                if (!$blocked) {
                    $abovePoints++
                }
            }
            else {
                $blocked = $true
                if (!$addedBlockedPoint) {
                    $abovePoints++
                    $addedBlockedPoint = $true
                }
            }
        }

        $addedBlockedPoint = $false
        $blocked = $false

        for ($i = $row + 1; $i -lt $rows; $i++) {
            if ($currentTree -gt $data[$i][$col]) {
                $visibleFromBelow++
                if (!$blocked) {
                    $belowPoints++
                }
            }
            else {
                $blocked = $true
                if (!$addedBlockedPoint) {
                    $belowPoints++
                    $addedBlockedPoint = $true
                }
            }
        }

        $addedBlockedPoint = $false
        $blocked = $false

        for ($i = $col - 1; $i -ge 0; $i--) {
            if ($currentTree -gt $data[$row][$i]) {
                $visibleFromLeft++
                if (!$blocked) {
                    $leftPoints++
                }
            }
            else {
                $blocked = $true
                if (!$addedBlockedPoint) {
                    $leftPoints++
                    $addedBlockedPoint = $true
                }
            }
        }

        $addedBlockedPoint = $false
        $blocked = $false

        for ($i = $col + 1; $i -lt $cols; $i++) {
            if ($currentTree -gt $data[$row][$i]) {
                $visibleFromRight++
                if (!$blocked) {
                    $rightPoints++
                }
            }
            else {
                $blocked = $true
                if (!$addedBlockedPoint) {
                    $rightPoints++
                    $addedBlockedPoint = $true
                }
            }
        }

        if (($visibleFromAbove -eq $row) -or ($visibleFromBelow -eq $rows - ($row + 1)) -or ($visibleFromLeft -eq $col) -or ($visibleFromRight -eq $cols - ($col + 1))) {
            $visible++
            $visibleFromAbove = 0
            $visibleFromBelow = 0
            $visibleFromLeft = 0
            $visibleFromRight = 0
        }

        $score = ($abovePoints) * ($belowPoints) * ($leftPoints) * ($rightPoints)

        if ($score -gt $highScore) {
            $highScore = $score
        }
    }
}

$total = $edges + $visible

Write-Host "Part 01 answer: $total"
Write-Host "Part 02 answer: $highScore"
