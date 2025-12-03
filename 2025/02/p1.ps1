$data = Get-Content .\input.txt
$data = $data.Split(',')
$invalid = 0
foreach ($item in $data) {
    [bigint]$start = $item.Split('-')[0]
    [bigint]$end = $item.Split('-')[1]
    $difference = $end - $start
    for ($i = 0; $i -le $difference; $i++) {
        [int]$length = $start.ToString().Length
        if (($length % 2) -eq 0) {
            $half = $length / 2
            [bigint]$firsthalf = $start.ToString().Substring(0, $half)
            [bigint]$secondhalf = $start.ToString().Substring($half)
            if ($firsthalf -eq $secondhalf) {
                $invalid += $start
            }
        }
        $start = $start + 1
    }
}
$invalid
