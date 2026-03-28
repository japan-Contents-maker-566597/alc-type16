$ErrorActionPreference = "Stop"
$jp_dir = "C:\Users\01051992\Desktop\NEWalctype16\alctype16\types"

$ad_code = "<!-- admax -->`r`n<script src=`"https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30`"></script>`r`n<!-- admax -->"

$utf8NoBom = New-Object System.Text.UTF8Encoding $False

$count_jp = 0
foreach ($file in Get-ChildItem -Path $jp_dir -Filter "*.html") {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    
    if (-not $content.Contains("<!-- admax -->")) {
        $pattern = '(?s)<div class="share-section">'
        $replacement = '<div style="text-align:center;margin:20px auto;">`r`n' + $ad_code + '`r`n</div>`r`n<div class="share-section">'
        
        $content = $content -replace $pattern, $replacement
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $count_jp++
    }
}

Write-Host "Patched $count_jp remaining Japanese files in NEWalctype16."
