$d = Get-Content d.txt
$vals = (Select-String -Pattern 'mul\(\d+,\d+\)' -InputObject $d -AllMatches).Matches.Value
foreach ($val in $vals) {
    $nums = ($val -replace 'mul\(|\)', '') -split ','
    [int]$total += ([int]$nums[0] * [int]$nums[1])
}
$total
