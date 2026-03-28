$source = "C:\Users\01051992\Desktop\NEWalctype16\alctype16\*"
$destination = "C:\Users\01051992\Desktop\alc-type16\alctype16"
Remove-Item -Path "$destination\*" -Recurse -Force
Copy-Item -Path $source -Destination $destination -Recurse -Force
Write-Host "Sync complete."
