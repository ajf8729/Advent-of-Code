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
$start = "$locX,$locY"
$startX = $locX
$startY = $locY
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
    $visits.Add("$locX,$locY") | Out-Null
    ($visits | Select-Object -Unique).count
}

[System.Collections.ArrayList]$visits = $visits | Select-Object -Unique
if ($start -in $visits) {
    $visits.Remove($start) | Out-Null
}


$loop = 0
#$visits
#Pause
foreach ($visit in $visits) {
    $obstacles = [System.Collections.ArrayList]::new()
    #Write-Host "new obstacle: $visit"
    $map = Get-Content d.txt
    $line = ($map[$visit.Split(',')[0]]).ToCharArray()
    $line[$visit.Split(',')[1]] = '#'
    $map[$visit.Split(',')[0]] = $line -join ''
    #$map
    #Pause
    $locX = $startX
    $locY = $startY
    $isLoop = $false
    try {
        while ($true) {
            do {
                if ($map[$locX - 1][$locY] -eq '.' -or $map[$locX - 1][$locY] -eq '^' -or $locX -gt 0) {
                    #move up
                    #$visits.Add("$locX,$locY") | Out-Null
                    $locX -= 1
                }
            }
            until ($map[$locX - 1][$locY] -eq '#' -or $locX -eq 0)
            $obstacle = "U,$($locX - 1),$locY"
            #$obstacle
            #$obstacle -in $obstacles
            if ($obstacle -in $obstacles) {
                $isLoop = $true
                #$loop++
                #break
            }
            $obstacles.Add($obstacle) | Out-Null
            #$obstacles
            #Pause

            do {
                if ($map[$locX][$locY + 1] -eq '.' -or $map[$locX][$locY + 1] -eq '^' -or $locY -lt $len) {
                    #move right
                    #$visits.Add("$locX,$locY") | Out-Null
                    $locY += 1
                }
            }
            until ($map[$locX][$locY + 1] -eq '#' -or $locY -eq $len)
            $obstacle = "R,$locX,$($locY + 1)"
            #$obstacle
            #$obstacle -in $obstacles
            if ($obstacle -in $obstacles) {
                $isLoop = $true
                #$loop++
                #break
            }
            $obstacles.Add($obstacle) | Out-Null
            #$obstacles
            #Pause

            do {
                if ($map[$locX + 1][$locY] -eq '.' -or $map[$locX + 1][$locY] -eq '^' -or $locX -lt $len) {
                    #move down
                    #$visits.Add("$locX,$locY") | Out-Null
                    $locX += 1
                }
            }
            until ($map[$locX + 1][$locY] -eq '#' -or $locX -eq $len)
            $obstacle = "D,$($locX + 1),$locY"
            #$obstacle
            #$obstacle -in $obstacles
            if ($obstacle -in $obstacles) {
                $isLoop = $true
                #$loop++
                #break
            }
            $obstacles.Add($obstacle) | Out-Null
            #$obstacles
            #Pause
        
            do {
                if ($map[$locX][$locY - 1] -eq '.' -or $map[$locX][$locY - 1] -eq '^' -or $locY -gt 0) {
                    #move left
                    #$visits.Add("$locX,$locY") | Out-Null
                    $locY -= 1
                }
            }
            until ($map[$locX][$locY - 1] -eq '#' -or $locY -eq 0)
            $obstacle = "L,$locX,$($locY - 1)"
            #$obstacle
            #$obstacle -in $obstacles
            if ($obstacle -in $obstacles) {
                $isLoop = $true
                #$loop++
                #break
            }
            $obstacles.Add($obstacle) | Out-Null
            #$obstacles
            #Pause
            if ($isLoop) {
                #$obstacles
                #pause
                $loop++
                break
            }
        }
    }
    catch {
        
    }
}
$loop
