Remove-Item .\day05gridtest.txt | Out-Null
Remove-Item .\day05movestest.txt | Out-Null
New-Item .\day05gridtest.txt -ItemType file | Out-Null
New-Item .\day05movestest.txt -ItemType file | Out-Null
$data = Get-Content .\Day05Input.txt
foreach ($line in $data) {
    if ($line.contains('[')) {
        $line | Out-File .\day05gridtest.txt -Append
    }
    if ($line.contains('move')) {
        $Line = $line.Replace('move ', '').Replace(' from ', ',').Replace(' to ', ',')
        $line | Out-File .\day05movestest.txt -Append
    }
}

$data = Get-Content .\day05gridtest.txt
<#
[N] [G]                     [Q]
[H] [B]         [B] [R]     [H]
[S] [N]     [Q] [M] [T]     [Z]
[J] [T]     [R] [V] [H]     [R] [S]
[F] [Q]     [W] [T] [V] [J] [V] [M]
[W] [P] [V] [S] [F] [B] [Q] [J] [H]
[T] [R] [Q] [B] [D] [D] [B] [N] [N]
[D] [H] [L] [N] [N] [M] [D] [D] [B]
#>
$data.Replace("["," ").Replace("]"," ").Replace("   ","").TrimStart(" ")
$stacks = (($data[$data.length - 1]).Replace('[', '').replace(']', '').replace(' ', '')).length
for (($h = 1); $h -le ($stacks * 4); $h += 4) {
    for (($i = ($data.length - 1)); $i -ge 0; $i--) {
        $rows += $data[$i][$h]
    }
    $rows = $rows.trim()
    $rows += "`n"
    $rows.Trim() | out-null
}
$rows | Out-File .\day05gridtest.txt -Force
