# function Get-Dates {
    
    
# }

Read-Host -Prompt "Press any key to continue"

foreach ($f in dir d:\software) {
    if ($f.Length -gt 1mb) {
        Write-Host $f.Name
    }
}

# Read-Host -Prompt "Press any key to continue"

$dates = @('2019-12-24','2019-12-25','2019-12-27','2020-01-16','2020-01-26','2020-01-28','2020-01-29','2020-02-07','2020-02-25','2020-03-24','2020-04-02','2020-04-20','2020-04-28','2020-05-10','2020-05-17','2020-06-17','2020-06-28','2020-07-10','2020-07-26','2020-08-19','2020-08-25')
foreach ($day in $dates) {
    Write-Host "$day"
}

# Read-Host -Prompt "Press any key to continue"