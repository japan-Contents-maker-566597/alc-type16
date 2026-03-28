$ErrorActionPreference = "Stop"
$src_dir = "alctype16\types"
$en_dir = "alctype16\en\types"

# 1. Ensure en_dir exists
New-Item -ItemType Directory -Force -Path $en_dir | Out-Null

# 2. Copy the current English files to en_dir
Write-Host "Copying current English versions..."
foreach ($file in Get-ChildItem -Path $src_dir -Filter "*.html") {
    $en_path = Join-Path -Path $en_dir -ChildPath $file.Name
    Copy-Item -Path $file.FullName -Destination $en_path -Force
    Write-Host "  Copied to en/types/$($file.Name)"
}

# 3. Restore the Japanese files
Write-Host "`nRestoring original Japanese files..."
git restore $src_dir
Write-Host "  Git restore completed."

# 4. Patch all 32 files
Write-Host "`nPatching ads..."
$target = '<script src="https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30"></script>'
$replacement = "<!-- admax -->`r`n<script src=`"https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30`"></script>`r`n<!-- admax -->"

$utf8NoBom = New-Object System.Text.UTF8Encoding $False

$count_en = 0
$count_ja = 0

foreach ($file in Get-ChildItem -Path $en_dir -Filter "*.html") {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    if ($content.Contains($target)) {
        $content = $content.Replace($target, $replacement)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $count_en++
    }
}

foreach ($file in Get-ChildItem -Path $src_dir -Filter "*.html") {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    if ($content.Contains($target)) {
        $content = $content.Replace($target, $replacement)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $count_ja++
    }
}

Write-Host "Successfully patched $count_en English files and $count_ja Japanese files."
