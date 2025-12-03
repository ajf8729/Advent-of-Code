function Get-PossibleFactors {
    param([bigint]$Value)
    [int[]]$possiblefactors = @()
    [int]$i = 0
    for ($i = 1; $i -le [math]::Floor([math]::Sqrt($Value)); $i++) {
        if (($value % $i) -eq 0) {
            $possiblefactors += $i
            if (($value / $i) -ne $i -and ($Value / $i) -ne $Value) {
                $possiblefactors += ($Value / $i)
            }
        }
    }
    return $possiblefactors | Sort-Object
}

$data = Get-Content .\z.txt
$data = $data.Split(',')
$invalid = 0
$counter = 0
foreach ($item in $data) {
    $counter++
    "PROCESSING: $counter out of 38"
    [bigint]$start = $item.Split('-')[0]
    [bigint]$end = $item.Split('-')[1]
    $difference = $end - $start
    #"difference = $difference"
    for ($i = 0; $i -lt $difference + 1; $i++) {
        [int]$length = $start.ToString().Length
        if ($length -gt 1) {
            #"length = $length"
            #"start = $start"
            $factors = Get-PossibleFactors -Value $length
            #"factors = $factors"
            foreach ($factor in $factors) {
                #"start = $start"
                #"factor = $factor"
                #"length = $length"
                $substrings = @()
                for ($j = 0; $j -lt $length; $j += $factor) {
                    #"j = $j"
                    #"factor = $factor"
                    $substrings += $start.ToString().Substring($j, $factor)
                    #"substrings = $substrings"
                    #pause
                }
                if ($substrings | Group-Object | Where-Object { $_.Count -eq $substrings.length }) {
                    $invalid += $start
                    "INVALID: $substrings"
                    if ($start.ToString().ToCharArray() | Group-Object | Where-Object { $_.Count -eq $start.ToString().Length }) {
                        break
                    }
                }
                #Pause
            
            }
        }
        $start = $start + 1
    }
}
$invalid
