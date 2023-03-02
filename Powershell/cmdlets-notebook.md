休眠 5 秒:

```powershell
Start-Sleep -Seconds 5
```

```powershell
Start-Job -ScriptBlock { Invoke-Expression -Command "raku background-job.raku" }
```