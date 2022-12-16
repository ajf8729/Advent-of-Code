Param(
    [string]$filename
)

$data = Get-Content $filename

[int]$minX = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[0])} | Select-Object -Unique | Sort-Object | Select-Object -First 1
[int]$maxX = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[0])} | Select-Object -Unique | Sort-Object | Select-Object -Last 1
#[int]$minY = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[1])} | Select-Object -Unique | Sort-Object | Select-Object -First 1
[int]$maxY = ($data.Split(' -> ')) | ForEach-Object {[int]($_.Split(',')[1])} | Select-Object -Unique | Sort-Object | Select-Object -Last 1

[int]$xRange = $maxX - $minX + 1
[int]$yRange = $maxY + 1

#Write-Host "minX: $minX"
#Write-Host "maxX: $maxX"
#Write-Host "minY: $minY"
#Write-Host "maxY: $maxY"
#Write-Host ''
#Write-Host "xRange: $xRange"
#Write-Host "yRange: $yRange"
#Write-Host ''

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
    #Clear-Host
    $sand = [Sand]::new()
    $sand.row = $sandStartRow + 1
    $sand.col = $sandStartCol
    $grains++

    while ($notDone) {
        
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
        <#
        if ($sand.row -eq 171 -and $sand.col -eq 52) {
            [string]$stringGrid = $grid
            $stringGrid = $stringGrid.Replace(' ', '')
            $length = $stringGrid.Length
        
            for ($i = 0; $i -lt $length; $i += $xRange) {
                $stringGrid.Substring($i, $xRange)
            }
            pause
        }
        #>
        #Write-Host "sand: $($sand.row), $($sand.col)"
        if (($sand.col) -lt 0 -or ($sand.col) -gt $maxX -or ($sand.row) -eq $yRange) {
            $notDone = $false
        }
    }
    if ($sand.col -ne -1) {
        $grid[($sand.row - 1), $sand.col] = 'o'
    }

    <#
    [string]$stringGrid = $grid
    $stringGrid = $stringGrid.Replace(' ', '')
    $length = $stringGrid.Length

    for ($i = 0; $i -lt $length; $i += $xRange) {
        $stringGrid.Substring($i, $xRange)
    }
    Start-Sleep -Milliseconds 50
    #>
}
<#
[string]$stringGrid = $grid
$stringGrid = $stringGrid.Replace(' ', '')
$length = $stringGrid.Length

for ($i = 0; $i -lt $length; $i += $xRange) {
    $stringGrid.Substring($i, $xRange)
}
#>
Write-Host "grains of sand: $($grains - 1)"
