<#
.SYNOPSIS

Convert between DateStr and unix timestamp.

.DESCRIPTION

Convert between DateStr and unix timestamp.

.PARAMETER PSdate

datestr, format: '2020-09-01 12:23:34'

.EXAMPLE

ConvertTo-UnixTimestamp '2020-09-01 12:23:34'

.EXAMPLE

dt2ut '2020-09-01 12:23:34'

.EXAMPLE

'2020-09-01 12:23:34' | ConvertTo-UnixTimestamp

.EXAMPLE

ut2dt 1718871277
'2020-09-01 12:23:34' | dt2ut


.EXAMPLE

1718875434,1718875451 | ut2dt
'2024-06-20 16:14:37','2024-06-20 16:23:54' | dt2ut

#>

function Convert-UnixTimestampToMilliseconds {
    param (
        [Parameter(Mandatory = $true)]
        [long]$Timestamp
    )
    
    # Check the length of the timestamp
    if ($Timestamp.ToString().Length -eq 10) {
        # If the timestamp is 10 digits, it is in seconds. Convert it to milliseconds.
        $Milliseconds = $Timestamp * 1000
    } elseif ($Timestamp.ToString().Length -eq 13) {
        # If the timestamp is 13 digits, it is already in milliseconds.
        $Milliseconds = $Timestamp
    } else {
        throw "Invalid timestamp length. Please provide a 10-digit or 13-digit Unix timestamp."
    }
    
    return $Milliseconds
}


function ConvertTo-UnixTimestamp {
    [CmdletBinding()]
    [Parameter()]

    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)][string[]] $PSdate
    )

    process {
        $PSdate | ForEach-Object {
            $epoch = [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970')
            (New-TimeSpan -Start $epoch -End $PSItem).TotalSeconds
        }
    }
}

function ConvertTo-Datetime {
    [CmdletBinding()]
    [Parameter()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)][int64[]] $PSseconds
    )

    process {
        $PSseconds | ForEach-Object {
            $milliseconds = Convert-UnixTimestampToMilliseconds -Timestamp $PSItem
            (Get-Date 01.01.1970).AddMilliseconds($milliseconds + 60 * 8 * 60 * 1000)
        }
    }
}

Set-Alias -Name dt2ut -Value ConvertTo-UnixTimestamp
Set-Alias -Name ut2dt -Value ConvertTo-Datetime
Export-ModuleMember -Function ConvertTo-UnixTimestamp,ConvertTo-Datetime
Export-ModuleMember -Alias dt2ut,ut2dt
