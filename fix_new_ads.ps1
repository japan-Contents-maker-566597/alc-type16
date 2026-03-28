$ErrorActionPreference = "Stop"
$jp_dir = "C:\Users\01051992\Desktop\NEWalctype16\alctype16\types"
$en_dir = "C:\Users\01051992\Desktop\NEWalctype16\alctype16\en\types"

$ad_code = "<!-- admax -->`r`n<script src=`"https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30`"></script>`r`n<!-- admax -->"

$utf8NoBom = New-Object System.Text.UTF8Encoding $False

$count_en = 0
foreach ($file in Get-ChildItem -Path $en_dir -Filter "*.html") {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    
    $targetOld = '<script src="https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30"></script>'
    
    if ($content.Contains($targetOld) -and !$content.Contains("<!-- admax -->")) {
        $content = $content.Replace($targetOld, $ad_code)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $count_en++
    }
}

$count_jp = 0
foreach ($file in Get-ChildItem -Path $jp_dir -Filter "*.html") {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    
    $pattern = '(?s)<div style="text-align:center;margin:20px auto;">\s*</div>'
    $replacement = '<div style="text-align:center;margin:20px auto;">`r`n' + $ad_code + '`r`n</div>'
    
    if ($content -match $pattern) {
        $content = $content -replace $pattern, $replacement
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $count_jp++
    }
}

Write-Host "Patched $count_en English files and $count_jp Japanese files in NEWalctype16."
