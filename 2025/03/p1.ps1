$d = Get-Content .\input.txt
foreach ($l in $d) {
    $l1 = $l.Substring(0, $l.Length - 1)
    $bat1 = $l1.ToCharArray() | Sort-Object -Descending | Select-Object -First 1
    $bat1index = $l.IndexOf($bat1)
    $l2 = $l.Substring($bat1index + 1)
    $bat2 = $l2.ToCharArray() | Sort-Object -Descending | Select-Object -First 1
    $bat = $bat1 + $bat2
    $total += [int]$bat
}
$total
