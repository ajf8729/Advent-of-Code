$d = Get-Content d.txt
[int]$regA = $d.Split()[2]
[int]$regB = $d.Split()[5]
[int]$regC = $d.Split()[8]
[int[]]$prog = $d.Split()[11].Split(',')
$p1 = [System.Collections.ArrayList]::new()
$jump = $false
$i = 0
do {
    $instruction = $prog[$i]
    $operand = $prog[$i + 1]
    if ($instruction -notin 1, 3 -and $operand -notin 0, 1, 2, 3) {
        switch ($operand) {
            4 {$operand = $regA}
            5 {$operand = $regB}
            6 {$operand = $regC}
        }
    }
    switch ($instruction) {
        0 {
            $regA = [Math]::Floor($regA / ([Math]::Pow(2, $operand)))
        }
        1 {
            $regB = $regB -bxor $operand
        }
        2 {
            $regB = $operand % 8
        }
        3 {
            if ($regA -eq 0) {
                break
            }
            else {
                $i = $operand
                $jump = $true
            }
        }
        4 {
            $regB = $regB -bxor $regC
        }
        5 {
            $p1.Add($operand % 8) | Out-Null
        }
        6 {
            $regB = [Math]::Floor($regA / ([Math]::Pow(2, $operand)))
        }
        7 {
            $regC = [Math]::Floor($regA / ([Math]::Pow(2, $operand)))
        }
    }
    if ($jump) {
        $jump = $false
    }
    else {
        $i += 2
    }
} until ($regA -eq 0 -and $i -eq $prog.Length)
$p1 -join ','
