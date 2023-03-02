<#
.SYNOPSIS

A example about ValueFromPipelineByPropertyName.

.DESCRIPTION

The usage about ValueFromPipelineByPropertyName and multi parameter from command line.

.PARAMETER ComputerName

The name of property name.

.EXAMPLE

"www.baidu.com","www.sina.com","www.jianshu.com" | ForEach-Object {[pscustomobject]@{ComputerName=$_}} | ValueFromPipelineByPropertyNameDemo

.EXAMPLE

"www.baidu.com","www.sina.com","www.jianshu.com" | ForEach-Object {[pscustomobject]@{ComputerName=$_; IpAddress=$_.toUpper()}} | ValueFromPipelineByPropertyNameDemo

#>
function ValueFromPipelineByPropertyNameDemo {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String[]]$ComputerName,
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String[]]$IpAddress
    )

    Process {
        if ($ComputerName -ne $null) {
            $ComputerName | ForEach-Object {
                Write-Host $PSItem
            }
        }

        if ($IpAddress -ne $null) {
            $IpAddress | ForEach-Object {
                Write-Host $PSItem
            }
        }
    }
}