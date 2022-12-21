do {
    $result = .\p2.ps1 -filename .\input.txt -humanValue $humanValue
    if ($result -eq $true) {
        return $humanValue
    }
    $humanValue++
    $humanValue
} until ($result -eq $true)
