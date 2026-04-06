# ============================================================
# Adjust FAB Position (bottom: 80px -> 160px)
# ============================================================

$base = "C:\Users\01051992\Desktop\NEWalctype16\alctype16"

# --- Define the search and replace patterns ---
$old_bottom = "bottom:80px;"
$new_bottom = "bottom:160px;"

# --- Get all HTML files ---
$files = Get-ChildItem -Path $base -Filter *.html -Recurse

foreach ($f in $files) {
    $path = $f.FullName
    $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    
    if ($content -match $old_bottom) {
        $content = $content -replace $old_bottom, $new_bottom
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Adjusted position: $($f.FullName)"
    }
}

Write-Host "Position adjustment complete."
