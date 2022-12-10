# Day05Input.txt is my unaltered source input data
# Day05Grid.txt is just the starting layout from Day05Input.txt
# Day05Moves.txt is just the moves list from Day05Input.txt
# Day05Start.txt is my massaged grid in a workable format
# Day05MovesWorkable.txt is my massaged list of moves in a workable format

#$grid = Get-Content .\Day05Start.txt
$grid = Get-Content .\day05gridtest.txt
<#
$grid contents:

DTWFJSHN
HRPQTNBG
LQV
NBSWRQ
NDFTVMB
MDBVHTR
DBQJ
DNJVRZHQ
BNHMS
#>

#$moves = Get-Content .\Day05MovesWorkable.txt
$moves = Get-Content .\day05movestest.txt
foreach ($move in $moves) {
    $move = $move.Split(',')
    <#
    $move example: "move 3 from 1 to 2"
    $move[0] is 3
    $move[1] is 1
    $move[2] is 2
    #>
    for ($i = 1; $i -le $move[0]; $i++) {
        $grid[$move[2] -1] += $grid[$move[1] -1].Substring($grid[$move[1] - 1].Length - 1, 1)
        $grid[$move[1] -1 ] = $grid[$move[1] -1].Substring(0, (($grid[$move[1] - 1]).Length - 1))
    }
}
foreach ($line in $grid) {
    $p1answer += $line.Substring($line.Length -1, 1)
}

Write-Host "Part 01 Answer: $p1answer"

$grid = Get-Content .\Day05Start.txt
$moves = Get-Content .\Day05MovesWorkable.txt

foreach ($move in $moves) {
    $move = $move.Split(',')
    # $move example, "move 3 from 1 to 2"
    # $move[0] is 3
    # $move[1] is 1
    # $move[2] is 2
    $grid[$move[2] -1] += $grid[$move[1] -1].Substring($grid[$move[1] - 1].Length - $move[0], $move[0])
    $grid[$move[1] -1 ] = $grid[$move[1] -1].Substring(0, (($grid[$move[1] - 1]).Length - $move[0]))
}
foreach ($line in $grid) {
    $p2answer += $line.Substring($line.Length -1, 1)
}

Write-Host "Part 02 Answer: $p2answer"
