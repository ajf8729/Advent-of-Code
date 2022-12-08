[CmdletBinding()]
Param(
    [string]$filename
)

$data = Get-Content $filename
$rows = $data[0].Length
$cols = $data.Length
Write-Verbose "rows: $rows"
Write-Verbose "cols: $cols"
$visible = 0

for ($rownum = 1; $rownum -lt $rows - 1; $rownum++) {
    $isAboveVisible = 0
    $isBelowVisible = 0
    $isLeftVisible = 0
    $isRightVisible = 0
    for ($colnum = 1; $colnum -lt $cols - 1; $colnum++) {
        #$data
        $isAboveVisible = 0
        $isBelowVisible = 0
        $isLeftVisible = 0
        $isRightVisible = 0
        Write-Verbose "rownum: $rownum"
        Write-Verbose "colnum: $colnum"
        $current = $data[$rownum][$colnum]
        Write-Verbose ''
        Write-Verbose "current: $current ($rownum,$colnum)"
        Write-Verbose ''
        Write-Verbose 'above check:'
        Write-Verbose "isAboveVisible: $isAboveVisible"
        for ($i = $rownum - 1; $i -ge 0; $i--) {
            Write-Verbose "i: $i"
            if ($current -gt $data[$i][$colnum]) {
                Write-Verbose "$current is visible from above ($($data[$i][$colnum]))"
                $isAboveVisible++
            }
            else {
                Write-Verbose "$current is not visible from above ($($data[$i][$colnum]))"
            }
        }
        Write-Verbose "isAboveVisible: $isAboveVisible"
        Write-Verbose "rownum: $rownum"
        if ($isAboveVisible -eq $rownum) {
            write-verbose "above visible = yes"
            $visible++
            Write-Verbose "visible = $visible"
            $isAboveVisible = 0
            continue
        }
        Write-Verbose ''
        Write-Verbose 'below check:'
        for ($i = $rownum + 1; $i -lt $rows; $i++) {
            if ($current -gt $data[$i][$colnum]) {
                Write-Verbose "$current is visible from below ($($data[$i][$colnum]))"
                $isBelowVisible++
            }
            else {
                Write-Verbose "$current is not visible from below ($($data[$i][$colnum]))"
            }
        }
        if ($isBelowVisible -eq $rows - ($rownum + 1)) {
            write-verbose "below visible = yes"
            $visible++
            Write-Verbose "visible = $visible"
            $isBelowVisible = 0
            continue
        }
        Write-Verbose ''
        Write-Verbose 'left check:'
        for ($i = $colnum - 1; $i -ge 0; $i--) {
            if ($current -gt $data[$rownum][$i]) {
                Write-Verbose "$current is visible from the left ($($data[$rownum][$i]))"
                $isLeftVisible++
            }
            else {
                Write-Verbose "$current is not visible from the left ($($data[$rownum][$i]))"
            }
        }
        if ($isLeftVisible -eq $colnum) {
            write-verbose "left visible = yes"
            $visible++
            Write-Verbose "visible = $visible"
            $isLeftVisible = 0
            continue
        }
        Write-Verbose ''
        Write-Verbose 'right check:'
        Write-Verbose "isRightVisible: $isRightVisible"
        for ($i = $colnum + 1; $i -lt $cols; $i++) {
            Write-Verbose "i: $i"
            if ($current -gt $data[$rownum][$i]) {
                Write-Verbose "$current is visible from the right ($($data[$rownum][$i]))"
                $isRightVisible++
            }
            else {
                Write-Verbose "$current is not visible from the right ($($data[$rownum][$i]))"
            }
        }
        Write-Verbose "isRightVisible: $isRightVisible"
        if ($isRightVisible -eq $cols - ($colnum + 1)) {
            write-verbose "right visible = yes"
            $visible++
            Write-Verbose "visible = $visible"
            $isRightVisible = 0
            continue
        }
    }
    Write-Verbose ''
    Write-Verbose 'next row'
}
Write-Verbose 'done'

$edges = ($data[0].Length * 2) + (($data.Length - 2) * 2)

Write-Host "edges: $edges"
Write-Host "visible: $visible"
$total = $edges + $visible
Write-Host "total: $total"
