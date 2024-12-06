$d = Get-Content s.txt
if (Test-Path bad.txt) {
    Remove-Item bad.txt
}
$rules = (Select-String -InputObject $d -Pattern '\d\d\|\d\d' -AllMatches).Matches.Value
$updates = $d -replace '\d\d\|\d\d', '' | Where-Object { $_.Trim() -ne ''}
$p1 = 0
foreach ($update in $updates) {
    $pages = $update.Split(',')
    $length = $pages.Length
    for ($i = 0; $i -lt $length - 1; $i++) {
        $bad = $false
        for ($j = $i + 1; $j -lt $length; $j++) {
            if ("$($pages[$j])|$($pages[$i])" -in $rules) {
                $bad = $true
                $update >> bad.txt
                break
            }
        }
        if ($bad) {
            break
        }
    }
    if (!$bad) {
        $p1 += $pages[[math]::floor($pages.Length / 2)]
        $bad = $false
    }
}
$p1
