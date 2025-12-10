$data = Get-Content .\input.txt
$maxarea = 0
foreach ($item1 in $data) {
    foreach ($item2 in $data) {
        if ($item1 -eq $item2) {
            break
        }
        $ax = $item1.Split(',')[0]
        $ay = $item1.Split(',')[1]
        $bx = $item2.Split(',')[0]
        $by = $item2.Split(',')[1]
        $x = $bx - $ax + 1
        $y = $by - $ay + 1
        $area = $x * $y
        if ($area -gt $maxarea) {
            $maxarea = $area
        }
    }
}
$maxarea
