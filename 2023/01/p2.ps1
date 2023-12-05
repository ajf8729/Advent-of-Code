Param(
    [string]$filename
)

$data = Get-Content $filename

$data = $data.Replace('oneight', '18')
$data = $data.Replace('twone', '21')
$data = $data.Replace('threeight', '38')
$data = $data.Replace('fiveight', '58')
$data = $data.Replace('sevenine', '79')
$data = $data.Replace('eightwo', '82')
$data = $data.Replace('eighthree', '83')
$data = $data.Replace('nineight', '98')
$data = $data.Replace('one', '1')
$data = $data.Replace('two', '2')
$data = $data.Replace('three', '3')
$data = $data.Replace('four', '4')
$data = $data.Replace('five', '5')
$data = $data.Replace('six', '6')
$data = $data.Replace('seven', '7')
$data = $data.Replace('eight', '8')
$data = $data.Replace('nine', '9')

$cleandata = $data -replace '[A-Za-z,,]'
$values = $cleandata | ForEach-Object {$_.Substring(0, 1); $_.Substring($_.Length - 1, 1)}
$values = $values -join '' -split '(.{2})' | Where-Object {$_}

$total = 0
foreach ($value in $values) {
    $total += $value
}

return $total
