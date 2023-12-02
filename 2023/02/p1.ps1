Param(
    [string]$filename
)

$data = Get-Content $filename

$red = 12
$green = 13
$blue = 14
$total = 0
$i = 0

foreach ($line in $data) {
    $new = $line.Replace(';', ',').split(':')[1].trim().split(',').trim()
    $i++
    
    foreach ($item in $new) {
        if ($item -like '*red') {
            if ([int]$item.Split()[0] -gt $red) {
                $impossible = $true
            }
        }
        if ($item -like '*green') {
            if ([int]$item.Split()[0] -gt $green) {
                $impossible = $true
            }
        }
        if ($item -like '*blue') {
            if ([int]$item.Split()[0] -gt $blue) {
                $impossible = $true
            }
        }
    }
    if (-not $impossible) {
        $total += $i
    }
    $impossible = $false
}
$total
