$d = Get-Content d.txt
$l = $d.Length
$x = $d | ForEach-Object {(-split $_)[0]} | Sort-Object
$y = $d | ForEach-Object {(-split $_)[1]} | Sort-Object
$p1 = 0
$p2 = 0
for ($i = 0; $i -lt $l; $i++) {
    if ($x[$i] -gt $y[$i]) {
        $p1 += ($x[$i] - $y[$i])
    }
    else {
        $p1 += ($y[$i] - $x[$i])
    }
}
$p1

for ($i = 0; $i -lt $l; $i++) {
    $m = 0
    $c = $x[$i]
    for ($j = 0; $j -lt $l; $j++) {
        if ($y[$j] -eq $c) {
            $m++
        }
    }
    $p2 += ([int]$c * $m)
}
$p2
