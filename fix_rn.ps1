$ErrorActionPreference = "Stop"
$dirs = @(
    "C:\Users\01051992\Desktop\NEWalctype16\alctype16\types",
    "C:\Users\01051992\Desktop\NEWalctype16\alctype16\en\types",
    "C:\Users\01051992\Desktop\alc-type16\alctype16\types",
    "C:\Users\01051992\Desktop\alc-type16\alctype16\en\types"
)

$utf8NoBom = New-Object System.Text.UTF8Encoding $False
$count = 0

foreach ($dir in $dirs) {
    if (Test-Path $dir) {
        foreach ($file in Get-ChildItem -Path $dir -Filter "*.html") {
            $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
            
            # Looking for literal backtick r backtick n
            if ($content.Contains("``r``n")) {
                # Replace with actual newline (`r`n in double quotes)
                $content = $content.Replace("``r``n", "`r`n")
                [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
                $count++
            }
        }
    }
}
Write-Host "Fixed literal string in $count files."
