param(
    [string]$filename
)

class Link {
    [string]$src
    [string]$dst
}

$data = Get-Content $filename
[System.Collections.ArrayList]$grid = @()
[System.Collections.ArrayList]$links = @()

# convert input data into a usable grid
foreach ($line in $data) {
    $grid.Add($line.ToCharArray()) | Out-Null
}

# get number of rows and columns
$rows = $grid.Count
$cols = $grid[0].Length

# find start and end coordinates
for ($x = 0; $x -lt $rows; $x++) {
    for ($y = 0; $y -lt $cols; $y++) {
        switch -CaseSensitive ($grid[$x][$y]) {
            'S' {[int[]]$start = $x, $y}
            'E' {[int[]]$end = $x, $y}
        }
    }
}

$grid[$start[0]][$start[1]] = 'a'
$grid[$end[0]][$end[1]] = 'z'

[System.Collections.ArrayList]$allStarts = @()
for ($a = 0; $a -lt $rows; $a++) {
    for ($b = 0; $b -lt $cols; $b++) {
        if ($grid[$a][$b] -eq 'a') {
            [int[]]$tmp = $a, $b
            $allStarts.Add($tmp) | Out-Null
        }
    }
}

Write-Host "allStarts: $($allStarts.count)"
#pause

# find all valid links
for ($currentX = 0; $currentX -lt $rows; $currentX++) {
    $aboveX = $currentX - 1
    $belowX = $currentX + 1
    $leftX = $currentX
    $rightX = $currentX
    for ($currentY = 0; $currentY -lt $cols; $currentY++) {
        $aboveY = $currentY
        $belowY = $currentY
        $leftY = $currentY - 1
        $rightY = $currentY + 1
        [int]$level = $grid[$currentX][$currentY]
        if ($aboveX -ge 0) {
            [int]$above = $grid[$aboveX][$aboveY]
            if ( ($above -eq $level) -or ($above -eq ($level + 1)) -or ($level -gt $above) ) {
                $link = [Link]::new()
                $link.src = $currentX, $currentY
                $link.dst = $aboveX, $aboveY
                $links.Add($link) | Out-Null
            }
        }
        if ($belowX -lt $rows) {
            [int]$below = $grid[$belowX][$belowY]
            if ( ($below -eq $level) -or ($below -eq ($level + 1)) -or ($level -gt $below) ) {
                $link = [Link]::new()
                $link.src = $currentX, $currentY
                $link.dst = $belowX, $belowY
                $links.Add($link) | Out-Null
            }
        }
        if ($leftY -ge 0) {
            [int]$left = $grid[$leftX][$leftY]
            if ( ($left -eq $level) -or ($left -eq ($level + 1)) -or ($level -gt $left) ) {
                $link = [Link]::new()
                $link.src = $currentX, $currentY
                $link.dst = $leftX, $leftY
                $links.Add($link) | Out-Null
            }
        }
        if ($rightY -lt $cols) {
            [int]$right = $grid[$rightX][$rightY]
            if ( ($right -eq $level) -or ($right -eq ($level + 1)) -or ($level -gt $right) ) {
                $link = [Link]::new()
                $link.src = $currentX, $currentY
                $link.dst = $rightX, $rightY
                $links.Add($link) | Out-Null
            }
        }
    }
}

#Write-Host "start: $start"
#Write-Host "end: $end"

Import-Module PSGraph

Graph x {foreach ($link in $links) {Edge -From $link.src -To $link.dst -Attributes @{dir = 'forward'}}} | Out-File links.dot
[System.Collections.ArrayList]$pathLengths = @()
$numProcessed = 0

foreach ($item in $allStarts) {
    $numProcessed++
    $stringStart = [string]$item
    $oldLocation = Get-Location
    New-Item "$oldLocation\dijkstra.dot" -ItemType File -Force | Out-Null
    $arguments = '-dp', "`"$stringStart`"", "`"$oldLocation\links.dot`""
    Set-Location -Path "$env:ProgramFiles\Graphviz\bin\"
    Start-Process -FilePath '.\dijkstra.exe' -ArgumentList $arguments -NoNewWindow -RedirectStandardOutput "$oldLocation\dijkstra.dot" -Wait
    Set-Location -Path $oldLocation

    $results = Get-Content 'dijkstra.dot'
    $nl = [System.Environment]::NewLine
    #$results.Split($nl) | ForEach-Object {if ($_ -like "*`"$end`"*dist*") {$_.Trim()}}
    $pathLength = $results.Split($nl) | ForEach-Object {if ($_ -like "*`"$end`"*dist*") {[int]((($_.Trim()).Split() | Select-Object -Last 1).Replace('[', '').Replace(',', '').Split('=') | Select-Object -Last 1)}}
    $pathLengths.Add($pathLength) | Out-Null
    if (($numProcessed % 25) -eq 0) {
        Write-Host "total processed so far: $numProcessed"
    }
}

$pathLengths.GetEnumerator() | Select-Object -Unique | Sort-Object | Select-Object -First 1
