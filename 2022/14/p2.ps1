Param(
    [string]$filename
)

$data = Get-Content $filename

[int]$minX = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[0])} | Select-Object -Unique | Sort-Object | Select-Object -First 1
[int]$maxX = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[0])} | Select-Object -Unique | Sort-Object | Select-Object -Last 1
[int]$maxY = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[1])} | Select-Object -Unique | Sort-Object | Select-Object -Last 1

[int]$xRange = $maxX - $minX + 1
[int]$yRange = $maxY + 1

$grid = New-Object 'char[,]' $yRange, $xRange

foreach ($line in $data) {
    $coords = $line.Split(' -> ')
    $numCoords = $coords.Count
    for ($i = 0; $i -lt ($numCoords - 1); $i++) {
        $src = $coords[$i].Split(',')
        $dst = $coords[$i + 1].Split(',')
        [int]$srcX = $src[0] - $minX
        [int]$srcY = $src[1]
        [int]$dstX = $dst[0] - $minX 
        [int]$dstY = $dst[1] 
        # if src x = dst x, line is vertical
        if ($srcX -eq $dstX) {
            # if src y < dst y, we're going down the y axis
            if ($srcY -lt $dstY) {
                for ($y = $srcY; $y -le $dstY; $y++) {
                    $grid[$y, $srcX] = '#'
                }
            }
            # if dst y < src y, we're going up the y axis
            if ($dstY -lt $srcY) {
                for ($y = $dstY; $y -le $srcY; $y++) {
                    $grid[$y, $srcX] = '#'
                }
            }
        }
        # if src y = dst y, line is horizontal
        if ($srcY -eq $dstY) {
            # if src x < dst x, we're going right on the x axis
            if ($srcX -lt $dstX) {
                for ($x = $srcX; $x -le $dstX; $x++) {
                    $grid[$srcY, $x] = '#'
                }
            }
            # if dst x < src x, we're going left on the x axis
            if ($dstX -lt $srcX) {
                for ($x = $dstX; $x -le $srcX; $x++) {
                    $grid[$srcY, $x] = '#'
                }
            }
        }
    }
}

for ($i = 0; $i -lt $xRange; $i++) {
    for ($j = 0; $j -lt $yRange; $j++) {
        if ($grid[$j, $i] -ne '#') {
            $grid[$j, $i] = '.'
        }
    }
}

$sandStartRow = 0
$sandStartCol = (500 - $minX)
$sandStart = $sandStartRow, $sandStartCol
$grid[$sandStart] = '+'

class Sand {
    [int]$row
    [int]$col
}

$grains = 0
$notdone = $true

while ($notDone) {
    
    $sand = [Sand]::new()
    $sand.row = $sandStartRow + 1
    $sand.col = $sandStartCol
    $grains++

    while ($notDone) {
        if ($grid[($sandStartRow + 1), $sandStartCol] -eq 'o' -and $grid[($sandStartRow + 1), ($sandStartCol + 1)] -eq 'o' -and $grid[($sandStartRow + 1), ($sandStartCol - 1)] -eq 'o') {
            $notDone = $false
        }
        if ($grid[$sand.row, $sand.col] -eq '.') {
            $sand.row += 1
        }
        elseif ($grid[$sand.row, $sand.col] -match '[#o]' -and $grid[$sand.row, ($sand.col - 1)] -eq '.') {
            $sand.row += 1
            $sand.col -= 1
        }
        elseif ($grid[$sand.row, $sand.col] -match '[#o]' -and $grid[$sand.row, ($sand.col - 1)] -match '[#o]' -and $grid[$sand.row, ($sand.col + 1)] -eq '.') {
            $sand.row += 1
            $sand.col += 1
        }
        elseif (($grid[$sand.row, $sand.col] -match '[#o]' -and $grid[$sand.row, ($sand.col - 1)] -match '[#o]' -and $grid[$sand.row, ($sand.col + 1)] -match '[#o]') -or ($sand.row) -eq $yRange) {
            break
        }
    }
    if ($sand.col -ne -1) {
        $grid[($sand.row - 1), $sand.col] = 'o'
    }
}

Write-Host "grains of sand: $grains"
