Param(
    [string]$filename
)

$data = Get-Content $filename
$total = 0

foreach ($line in $data) {
    $minred = 0
    $mingreen = 0
    $minblue = 0
    $new = $line.Replace(';', ',').split(':')[1].trim().split(',').trim()
    
    foreach ($item in $new) {
        if ($item -like '*red') {
            if ([int]$item.Split()[0] -gt $minred) {
                $minred = [int]$item.Split()[0]
            }
        }
        if ($item -like '*green') {
            if ([int]$item.Split()[0] -gt $mingreen) {
                $mingreen = [int]$item.Split()[0]
            }
        }
        if ($item -like '*blue') {
            if ([int]$item.Split()[0] -gt $minblue) {
                $minblue = [int]$item.Split()[0]
            }
        }
    }
    $total += ($minred * $mingreen * $minblue)
}

$total
