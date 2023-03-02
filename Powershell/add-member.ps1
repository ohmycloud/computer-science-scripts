$log1 = New-Object System.Management.Automation.PSObject
$log1 | Add-Member -Name "Path"       -Value "Log1.txt" -MemberType NoteProperty
$log1 | Add-Member -Name "TotalCount" -Value 3          -MemberType NoteProperty


$log2 = New-Object System.Management.Automation.PSObject
$log2 | Add-Member -Name "Path"       -Value "Log2.txt" -MemberType NoteProperty
$log2 | Add-Member -Name "TotalCount" -Value 5          -MemberType NoteProperty


$log3 = New-Object System.Management.Automation.PSObject
$log3 | Add-Member -Name "Path" -Value "Log3.txt" -MemberType NoteProperty
$log3 | Add-Member -Name "Tail" -Value 2          -MemberType NoteProperty


$log4 = New-Object System.Management.Automation.PSObject
$log4 | Add-Member -Name "Path" -Value "Log4.txt" -MemberType NoteProperty
$log4 | Add-Member -Name "Tail" -Value 4          -MemberType NoteProperty


@(
    @{ Path="Log1.txt"; TotalCount=3 },
    @{ Path="Log2.txt"; TotalCount=5 },
    @{ Path="Log3.txt"; Tail=4 },
    @{ Path="Log4.txt"; Tail=2 }
)