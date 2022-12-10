Param(
    [string]$Filename
)

$Data = Get-Content $Filename
$Id = 0
$Totals = @{}

foreach ($Item in $Data) {
    if ($Item -ne '') {
        $Total += [int]$Item
    }
    else {
        $Totals.Add($Id, [int]$Total)
        $Total = 0
        $Id++
    }
}
$Totals.Add($Id, $Total)

Write-Host 'Part 01 Answer: ' -NoNewline
$totals.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1 | Select-Object -ExpandProperty Value

Write-Host 'Part 02 Answer: ' -NoNewline
$totals.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 3 | ForEach-Object {
    $TopThree += $_.Value
}
Write-Host $TopThree
