# To use the -EncodedCommand parameter:
$command = 'cmd /k C:\ProgramData\Anaconda3\Scripts\activate.bat'
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)

powershell.exe -encodedCommand $encodedCommand