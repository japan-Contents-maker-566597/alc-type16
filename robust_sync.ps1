$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# --- Global Cleanup & Robustness Update ---
function Update-File-Robust($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        # 1. Remove Duplicate LINE FABs (keep only one)
        $FabPattern = '(?s)  <!-- LINE stamp floating banner -->.*?</a>'
        $Matches = [regex]::Matches($Content, $FabPattern)
        if ($Matches.Count -gt 1) {
            for ($i = 1; $i -lt $Matches.Count; $i++) {
                $Content = $Content.Replace($Matches[$i].Value, "")
            }
        }
        
        # 2. Ensure Share Section and Buttons are properly marked in HTML
        # (Already done in previous steps, but ensuring consistency)
        
        # 3. Final Master CSS Patch for "Absolute Visibility"
        $VisibilityFix = @"
    /* Absolute Visibility Fixes */
    .share-section, .rediagnosis-button, .bottom-nav-wrapper {
      display: block !important;
      visibility: visible !important;
      opacity: 1 !important;
      position: relative !important;
      z-index: 10 !important;
      clear: both !important;
    }
    .x-share-button { display: inline-flex !important; }
"@
        if ($Content -match '(  </style>)') {
            # Only add if not already present
            if ($Content -notmatch "Absolute Visibility Fixes") {
                $Content = $Content -replace '(  </style>)', "`n$VisibilityFix`n`$1"
            }
        }

        [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
        Write-Host "Updated Robustness: $($File.Name)"
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Update-File-Robust $File }
Write-Host "Robustness Sync Complete."
