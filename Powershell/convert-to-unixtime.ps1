<#
.SYNOPSIS

将日期字符串转换为 10 位 unix 时间戳

.DESCRIPTION

日期和 unix timestamp 之间的转换 

.PARAMETER PSdate

日期字符串

.EXAMPLE

ConvertTo-UnixTimestamp '2020-09-01 12:23:34'

.EXAMPLE

'2020-09-01 12:23:34' | ConvertTo-UnixTimestamp

#>

function ConvertTo-UnixTimestamp {
    [CmdletBinding()]
    [Parameter()]

    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)][string] $PSdate
    )

    $epoch = [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970')
    (New-TimeSpan -Start $epoch -End $PSdate).TotalSeconds
}

Set-Alias -Name dt2ut -Value ConvertTo-UnixTimestamp
Export-ModuleMember -Function ConvertTo-UnixTimestamp
Export-ModuleMember -Alias dt2ut