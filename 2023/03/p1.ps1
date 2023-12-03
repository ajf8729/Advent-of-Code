Param(
    [string]$filename
)

$data = Get-Content $filename
$row = 0
$col = 0
$total = 0
$validpartnumber = $false
$charindex = 1

foreach ($line in $data) {
    $num = $null
    $chars = $line.ToCharArray()
    foreach ($char in $chars) {
        if ($char -match '[\d]') {
            [string]$num += $char
            if ($row -ne 0 -and $col -ne 0 -and ($data[$row - 1])[$col - 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($row -ne 0 -and ($data[$row - 1])[$col] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($row -ne 0 -and $col -le $line.length -and ($data[$row - 1])[$col + 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($col -ne 0 -and ($data[$row])[$col - 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if (($data[$row])[$col + 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($row -lt ($data.length - 1) -and $col -ne 0 -and ($data[$row + 1])[$col - 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($row -lt ($data.length - 1) -and ($data[$row + 1])[$col] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            if ($row -lt ($data.length - 1) -and $col -lt ($line.length - 1) -and ($data[$row + 1])[$col + 1] -match '[-@\*/&#%\+=\$]') {
                $validpartnumber = $true
            }
            
            if ($charindex -eq ($chars.Length)) {
                if ($validpartnumber) {
                    $total += [int]$num
                    $num = $null
                    $validpartnumber = $false
                }
            }
        }
        else {
            if ($validpartnumber) {
                $total += [int]$num
            }
            $num = $null
            $validpartnumber = $false
        }
        $charindex++
        $col++
    }
    $charindex = 1
    $row++
    $col = 0
}

$total
