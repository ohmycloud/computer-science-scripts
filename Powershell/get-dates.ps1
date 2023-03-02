function DailyJob {
    [CmdletBinding()]
    [Parameter()]
    param(
        [string] $startDay,
        [string] $stopDay
    )
    $start = [DateTime]::ParseExact($startDay, "yyyy-MM-dd", $null)
    $end = [DateTime]::ParseExact($stopDay, "yyyy-MM-dd", $null)
    $count = 0
    while ($start.AddDays($count) -le $end) {
        $presentDay = $start.AddDays($count).ToString("yyyy-MM-dd")
        Write-Host "$presentDay"
        $count = $count + 1
    }
}

# Read-Host -Prompt "Press any key to continue"

# foreach ($f in dir d:\software) {
#     if ($f.Length -gt 1mb) {
#         Write-Host $f.Name
#     }
# }

# Read-Host -Prompt "Press any key to continue"

# $dates = @('2019-12-24','2019-12-25','2019-12-27','2020-01-16','2020-01-26','2020-01-28','2020-01-29')
# foreach ($day in $dates) {
#     Write-Host "$day"
# }

# 日期范围
# $daysRange = 1..7 | ForEach-Object { (Get-Date).AddDays($_).ToString("yyyyMMdd") }
# Write-Host "$daysRange"

# Read-Host -Prompt "Press any key to continue"

DailyJob -startDay '2021-08-10' -stopDay '2021-08-16'

#Get-Process | Export-Csv -Path 'D:\scripts\Powershell\process.csv'