$data = Get-Content .\Day07Input.txt
$diskSize = 70000000
$spaceNeeded = 30000000

$dirSizes = @{}

foreach ($line in $data) {
    switch -wildcard ($line) {
        '$ cd /' {
            $currentPath = '/'
            break
        }
        '$ cd ..' {
            $currentPath = $currentPath.TrimEnd('/')
            $currentPath = $currentPath.Substring(0, $currentPath.LastIndexOf('/'))
            $currentPath += '/'
            break
        }
        '$ cd*' {
            $currentPath += (($line.Split())[2]) + '/'
            break
        }
        '$ ls*' {
            # ls command, do nothing
            break
        }
        'dir*' {
            # item is a directory name, do nothing
            break
        }
        default {
            #item is assumed to be a file, process it
            $fileSize = ($line.Split())[0]
            if ($null -eq $dirSizes[$currentPath]) {
                $dirSizes.Add($currentPath, [int]$filesize)
            }
            else {
                $dirSizes[$currentPath] += [int]$filesize
            }
            $workingPath = $currentPath
            while (![string]::IsNullOrEmpty($workingPath)) {
                $workingPath = $workingPath.TrimEnd('/')
                if ([string]::IsNullOrEmpty($workingPath)) {
                    break
                }
                $workingPath = $workingPath.Substring(0, $workingPath.LastIndexOf('/') + 1)
                $dirSizes[$workingPath] += [int]$filesize
            }
            break
        }
    }
}

foreach ($item in ($dirSizes.GetEnumerator() | Where-Object {$_.Value -le 100000})) {
    $total += $item.value
}

$totalUsed = $dirSizes['/']
$freeSpace = $diskSize - $totalUsed
$spaceNeeded = $spaceNeeded - $freeSpace
$sizeToDelete = ($dirSizes.GetEnumerator() | Where-Object {$_.value -ge $spaceNeeded} | Sort-Object value | Select-Object -First 1).Value

Write-Host "Part 01 answer: $total"
Write-Host "Part 02 answer: $sizeToDelete"
