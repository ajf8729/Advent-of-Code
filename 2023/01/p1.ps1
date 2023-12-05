Param(
    [string]$filename
)

$data = Get-Content $filename

$cleandata = $data -replace '[A-Za-z,,]'
$values = $cleandata | ForEach-Object {$_.Substring(0, 1); $_.Substring($_.Length - 1, 1)}
$values = $values -join '' -split '(.{2})' | Where-Object {$_}

$total = 0
foreach ($value in $values) {
    $total += $value
}

return $total
