# Create a new Task Action
$taskAction = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument 'D:\scripts\Powershell\event_log.ps1'

# Create a new trigger(Dailt at 2 AM)
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 2PM

# Register the new PowerShell scheduled task
# The name of the scheduled task
$taskName = "Demo"

# 任务描述
$description = "Daily Spark Job by ohmycloudy"

# Register the scheduled task
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Description $description


# # Set the task principal's user ID and run level.
# $taskPrincipal = New-ScheduledTaskPrincipal -UserId 'DEVPC\svcTask' -RunLevel Highest
# # Set the task compatibility value to Windows 10.
# $taskSettings = New-ScheduledTaskSettingsSet -Compatibility Win8
# # Update the task principal settings
# Set-ScheduledTask -TaskName 'ExportAppLog' -Principal $taskPrincipal -Settings $taskSettings

# Url
# https://adamtheautomator.com/powershell-scheduled-task/

# 设置新的 Trigger
$taskTrigger1 = New-ScheduledTaskTrigger -Daily -At 4:30PM
$taskTrigger2 = New-ScheduledTaskTrigger -Daily -At 1:00AM

$UserObj = [Security.Principal.WindowsIdentity]::GetCurrent()
$User = $UserObj.Name

# Updating the scheduled task with multiple triggers
Set-ScheduledTask -TaskName 'Demo' -Trigger $taskTrigger1,$taskTrigger2 -User $User -Password 'PASSWORD'

# 备份定时任务
# Export the scheduled task object to XML
Get-ScheduledTask -TaskName 'Demo' | Export-Clixml c:\temp\ExportAppLog.xml

# 删除定时任务
# Unregister the scheduled task
Unregister-ScheduledTask -TaskName 'Demo' -Confirm:$false

# 确认是否已经删除
Get-ScheduledTask -TaskName 'Demo'

# 从备份中恢复定时任务
# Import the Schedule Task backup
$stBackup = Import-Clixml -Path C:\temp\backup.xml

# Reset the logon type to "Run only when the user is logged on."
$stBackup.Principal.LogonType = 'Interactive'

# Create a new Scheduled Task object using the imported values
$restoreTask = New-ScheduledTask `
    -Action $stBackup.Actions `
    -Trigger $stBackup.Triggers `
    -Settings $stBackup.Settings `
    -Principal $stBackup.Principal


Register-ScheduledTask `
    -TaskName 'Demo_restored' `
    -InputObject $restoreTask `
    -User 'thinkenergy\xxx' `
    -Password 'PASSWORD'  