function test-stuff {
    param (
        $data
    )
    $pages = $data.Split(',')
    $length = $pages.Length
    for ($i = 0; $i -lt $length - 1; $i++) {
        $bad = $false
        for ($j = $i + 1; $j -lt $length; $j++) {
            if ("$($pages[$j])|$($pages[$i])" -in $rules) {
                $bad = $true
                break
            }
        }
        if ($bad) {
            break
        }
    }
    #write-host $bad
    return $bad
}

$updates = Get-Content bad.txt
$rules = (Select-String -InputObject (Get-Content s.txt) -Pattern '\d\d\|\d\d' -AllMatches).Matches.Value
foreach ($update in $updates) {
    $pages = $update.Split(',')
    $length = $pages.Length
    $pagesList = [System.Collections.Generic.List[System.Object]]($update.Split(','))
    $stillBad = $true
    while ($stillBad) {
        for ($i = 0; $i -lt $length; $i++) {
            for ($j = 0; $j -lt $length - 1; $j++) {
                #write-host "before: " ($pagesList -join ',')
                $remove = $pagesList[$i]
                $pagesList.RemoveAt($i)
                $pagesList.Add($remove)
                #write-host "after: " ($pagesList -join ',')
                #Pause
                $stillBad = test-stuff -data $pagesList -join ','
                if (!$stillBad) {
                    break
                }
            }
            if (!$stillBad) {
                break
            }
        }
        
    }
    write-host "winner: " ($pagesList -join ',')
    Pause
}
