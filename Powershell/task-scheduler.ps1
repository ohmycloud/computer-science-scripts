# Specify the trigger settings
$Trigger = New-ScheduledTaskTrigger -Daily -At "11:42am"

# get User Object
$UserObj = [Security.Principal.WindowsIdentity]::GetCurrent()

# Specify the account to run the script
$User = $UserObj.Name

# Specify what program to run and with its parameters
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "D:\scripts\Powershell\get-dates.ps1"

# Specify the name of the task
Register-ScheduledTask -TaskName "DailySparkJob" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force