$d = Get-Content d.txt
$len = $d.Length
$visits = [System.Collections.ArrayList]::new()
for ($i = 0; $i -lt $len; $i++) {
    for ($j = 0; $j -lt $len; $j++) {
        if ($d[$i][$j] -eq '^') {
            $locX = $i
            $locY = $j
        }
    }
}
try {
    while ($true) {
        do {
            if ($d[$locX - 1][$locY] -eq '.' -or $d[$locX - 1][$locY] -eq '^') {
                #move up
                $visits.Add("$locX,$locY") | Out-Null
                $locX -= 1
            }
        }
        until ($d[$locX - 1][$locY] -eq '#')
        do {
            if ($d[$locX][$locY + 1] -eq '.' -or $d[$locX][$locY + 1] -eq '^') {
                #move right
                $visits.Add("$locX,$locY") | Out-Null
                $locY += 1
            }
        }
        until ($d[$locX][$locY + 1] -eq '#')
        do {
            if ($d[$locX + 1][$locY] -eq '.' -or $d[$locX + 1][$locY] -eq '^') {
                #move down
                $visits.Add("$locX,$locY") | Out-Null
                $locX += 1
            }
        }
        until ($d[$locX + 1][$locY] -eq '#')
        do {
            if ($d[$locX][$locY - 1] -eq '.' -or $d[$locX][$locY - 1] -eq '^') {
                #move left
                $visits.Add("$locX,$locY") | Out-Null
                $locY -= 1
            }
        }
        until ($d[$locX][$locY - 1] -eq '#')
    }
}
catch {
    ($visits | Select-Object -Unique).count + 1
}
