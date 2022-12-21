Param(
    [string]$filename,
    [int]$humanValue
)

class mathMonkey {
    $name
    $value1
    $operation
    $value2
}

$data = Get-Content $filename
$nl = [System.Environment]::NewLine
$lines = $data.Split($nl)
[System.Collections.ArrayList]$mathMonkeys = @()
$numberMonkeys = @{}

foreach ($line in $lines) {
    switch ($line.Split().Count) {
        2 {
            $key = $line.Split()[0].Replace(':', '')
            $value = $line.Split()[1]
            $numberMonkeys.Add($key, $value)
            break
        }
        4 {
            $mathMonkey = [mathMonkey]::New()
            $mathMonkey.name = $line.Split()[0].Replace(':', '')
            $mathMonkey.value1 = $line.Split()[1]
            $mathMonkey.operation = $line.Split()[2]
            $mathMonkey.value2 = $line.Split()[3]
            $mathMonkeys.Add($mathMonkey) | Out-Null
            break
        }
    }
}
$numberMonkeys['humn'] = $humanValue
$mathMonkeys | Where-Object {$_.name -eq 'root'} | ForEach-Object {$_.operation = '='}
$count = $mathMonkeys.Count
$check = $false
do {
    do {
        foreach ($mathMonkey in $mathMonkeys) {
            if ( ($mathMonkey.value1 -notmatch '[0-9]+') ) {
                if ($numberMonkeys[$mathMonkey.value1]) {
                    $mathMonkey.value1 = $numberMonkeys[$mathMonkey.value1]
                }
            }
            if ( ($mathMonkey.value2 -notmatch '[0-9]+') ) {
                if ($numberMonkeys[$mathMonkey.value2]) {
                    $mathMonkey.value2 = $numberMonkeys[$mathMonkey.value2]
                }
            }
        }
        foreach ($mathMonkey in $mathMonkeys) {
            if ( ($mathMonkey.value1 -match '[0-9]+') -and ($mathMonkey.value2 -match '[0-9]+') ) {
                switch ($mathMonkey.operation) {
                    '+' {
                        [float]$result = [float]$mathMonkey.value1 + [float]$mathMonkey.value2
                        break
                    }
                    '-' {
                        [float]$result = [float]$mathMonkey.value1 - [float]$mathMonkey.value2
                        break
                    }
                    '*' {
                        [float]$result = [float]$mathMonkey.value1 * [float]$mathMonkey.value2
                        break
                    }
                    '/' {
                        [float]$result = [float]$mathMonkey.value1 / [float]$mathMonkey.value2
                        break
                    }
                    '=' {
                        if ([float]$mathMonkey.value1 -eq [float]$mathMonkey.value2) {
                            return $true
                        }
                        else {
                            return $false
                        }
                    }
                }
                $key = $mathMonkey.name
                $value = $result
                if (!$numberMonkeys[$key]) {
                    try {
                        $numberMonkeys.Add($key, $value)
                    }
                    catch {
                        exit
                    }
                    $count--
                }
            }
        }
    } until ($count -eq 0)
} until ($check)
