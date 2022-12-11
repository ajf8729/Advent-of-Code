[CmdletBinding()]
Param(
    [string]$filename
)

class Monkey {
    [int]$id
    [System.Collections.ArrayList]$itemWorryLevels
    [string]$operation
    $operationValue
    [int]$divisibilityTest
    [int]$throwToIfTrue
    [int]$throwToIfFalse
    [int]$itemsInspected
}

$data = (Get-Content -Path $filename -Raw).Split("$nl$nl")
$nl = [System.Environment]::NewLine
$monkeyNum = 0
$monkeys = [System.Collections.ArrayList]@()

foreach ($item in $data) {
    $monkey = [Monkey]::new()
    $monkey.id = $monkeyNum
    $monkey.itemWorryLevels = $item.Split("$nl")[1].TrimStart().Substring(16, $item.Split("$nl")[1].TrimStart().TrimStart().Length - 16).Split(', ')
    $monkey.operation = $item.Split("$nl")[2].TrimStart().Substring(21, $item.Split("$nl")[2].TrimStart().length - 21).Split()[0]
    $monkey.operationValue = $item.Split("$nl")[2].TrimStart().Substring(21, $item.Split("$nl")[2].TrimStart().length - 21).Split()[1]
    $monkey.divisibilityTest = $item.Split("$nl")[3].TrimStart().Substring(19, $item.Split("$nl")[3].TrimStart().length - 19)
    $monkey.throwToIfTrue = $item.Split("$nl")[4].TrimStart().Substring(25, $item.Split("$nl")[4].TrimStart().length - 25)
    $monkey.throwToIfFalse = $item.Split("$nl")[5].TrimStart().Substring(26, $item.Split("$nl")[5].TrimStart().length - 26)
    $monkey.itemsInspected = 0
    $monkeys.Add($monkey) | Out-Null
    $monkeyNum++
}

for ($i = 1; $i -le 20; $i++) {
    foreach ($monkey in $monkeys) {
        $monkeyHasObjects = $true
        while ($monkeyHasObjects) {
            if ($monkey.itemWorryLevels.Count -gt 0) {
                $monkey.itemsInspected++
                if ($monkey.operationValue -eq 'old') {
                    $opValIsOld = $true
                    $monkey.operationValue = [int]$monkey.itemWorryLevels[0]
                }
                switch ($monkey.operation) {
                    '+' {
                        [int]$monkey.itemWorryLevels[0] += [int]$monkey.operationValue
                        break
                    }
                    '*' {
                        [int]$monkey.itemWorryLevels[0] *= [int]$monkey.operationValue
                        break
                    }
                }
                $monkey.itemWorryLevels[0] = [Math]::Floor($monkey.itemWorryLevels[0] / 3)
                $check = $monkey.itemWorryLevels[0] % $monkey.divisibilityTest
                if ($check -eq 0) {
                    $monkeys[$monkey.throwToIfTrue].itemWorryLevels.Add($monkey.itemWorryLevels[0]) | Out-Null
                    $monkey.itemWorryLevels.Remove($monkey.itemWorryLevels[0]) | Out-Null
                }
                else {
                    $monkeys[$monkey.throwToIfFalse].itemWorryLevels.Add($monkey.itemWorryLevels[0]) | Out-Null
                    $monkey.itemWorryLevels.Remove($monkey.itemWorryLevels[0]) | Out-Null
                }
                if ($monkey.itemWorryLevels.Count -eq 0) {
                    $monkeyHasObjects = $false
                }
                if ($opValIsOld) {
                    $opValIsOld = $false
                    $monkey.operationValue = 'old'
                }
            }
            else {
                $monkeyHasObjects = $false
            }
        }
    }
}

$topTwo = $monkeys.GetEnumerator() | Sort-Object itemsInspected -Descending | Select-Object -exp itemsInspected -First 2
$topTwo[0] * $topTwo[1]
