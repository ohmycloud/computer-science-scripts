$entries = New-Object System.Collections.Generic.List[System.Object] 

$exclude = "alg"

# Get initial directory listing
$dirlist = Get-ChildItem . -ad -Exclude ".gitignore", "*_app.py", "*.txt", "*.ps1", "*.sh", "*.md", "*.zip", "*.bat", "*.pyc", "__pycache__", ".idea" | ForEach-Object { $_.FullName }

# Exclude bin and obj directories and add entry path to our zip entry list
foreach ($dir in $dirlist)
{
    $sub = Get-ChildItem $dir -Exclude "*.pyc", ".gitignore", "__pycache__", "alg" | ForEach-Object { $_.FullName }

    $entries.Add("$($dir.split('/')[-1])/")
    foreach ($itm in $sub)
    {
        Write-Host $itm
        $entries.Add($itm)
    }
}

# Get-ChildItem -Path . -Recurse -Exclude "__pycache__", ".gitignore", "*_app.py" |
#       Compress-Archive -DestinationPath d:\PipelineRecurse.zip

Compress-Archive -Path $entries -CompressionLevel Optimal -DestinationPath "d:\tmp.zip"
