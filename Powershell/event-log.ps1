$logDir = 'd:\temp'
$logFile = "$logDir\AppLog_$(Get-Date -format 'yyyy-mm-dd_hh-mm-ss-tt').xml"

Get-WinEvent -LogName application -MaxEvents 10 | Export-Clixml -Path $logFile -Force