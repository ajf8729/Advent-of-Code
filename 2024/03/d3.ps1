$d = Get-Content d.txt
$p1vals = (Select-String -Pattern 'mul\(\d+,\d+\)' -InputObject $d -AllMatches).Matches.Value
foreach ($val in $p1vals) {
    $nums = ($val -replace 'mul\(|\)', '') -split ','
    [int]$p1 += ([int]$nums[0] * [int]$nums[1])
}
$p1

$p2vals = (Select-String -Pattern "(mul\(\d+,\d+\)|do\(\)|don't\(\))" -InputObject $d -AllMatches).Matches.Value
$multiply = $true
foreach ($val in $p2vals) {
    if ($val -match 'mul\(\d+,\d+\)') {
        if ($multiply) {
            $nums = ($val -replace 'mul\(|\)', '') -split ','
            [int]$p2 += ([int]$nums[0] * [int]$nums[1])
        }
    }
    elseif ($val -match 'do\(\)') {
        $multiply = $true
    }
    elseif ($val -match "don't\(\)") {
        $multiply = $false
    }
}
$p2
