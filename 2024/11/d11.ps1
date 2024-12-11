function Start-StoneProcessing {
    param (
        $stones
    )
    $newStones = [System.Collections.ArrayList]::new()
    foreach ($stone in $stones) {
        if ($stone -eq '0') {
            $newStones.Add('1') | Out-Null
        }
        elseif ([string]$stone.ToString().length % 2 -eq 0) {
            $newStones.Add([int]$stone.ToString().Substring(0, $stone.ToString().Length / 2)) | Out-Null
            $newStones.Add([int]$stone.ToString().Substring($stone.ToString().Length / 2)) | Out-Null
        }
        else {
            $newStones.Add([bigint]$stone * 2024) | Out-Null
        }
    }
    return $newStones
}
$d = Get-Content d.txt
$stones = [System.Collections.ArrayList]::new()
foreach ($item in $d.Split()) {
    $stones.Add([string]$item) | Out-Null
}
for ($i = 0; $i -lt 75; $i++) {
    Get-Date
    $stones = Start-StoneProcessing -stones $stones
    Write-Host "$($i): $($stones.length)"
}
