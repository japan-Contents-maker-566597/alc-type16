$BaseDir = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$FinalCss = @"
  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 { 
    color: #6a1b9a !important; 
    white-space: nowrap !important; 
    font-size: clamp(1.2rem, 5.5vw, 2.8rem) !important; 
    margin-bottom: 20px !important; 
    text-align: center !important; 
    overflow: hidden;
    text-overflow: ellipsis;
  }
  h1 a { 
    text-decoration: none !important; 
    color: #6a1b9a !important; 
    transition: opacity 0.2s; 
    display: inline-block; 
  }
  h1 a:hover { opacity: 0.7; }
  .action-button, .bottom-nav-button, .x-share-button, .secondary-button, .rediagnosis-button { 
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important; 
    cursor: pointer; 
  }
  .action-button:hover, .bottom-nav-button:hover, .rediagnosis-button:hover { 
    transform: translateY(-2px); 
    box-shadow: 0 8px 20px rgba(0,0,0,0.15) !important; 
  }
  .action-button:active, .bottom-nav-button:active, .rediagnosis-button:active { 
    transform: scale(0.97) translateY(1px) !important; 
  }
  .result-card p { line-height: 1.9 !important; letter-spacing: 0.03em; margin-bottom: 1.2em; }
  .key-sentence { 
    font-weight: 800; 
    background: linear-gradient(transparent 60%, #fff9c4 60%) !important; 
    padding: 2px 4px; 
    border-radius: 4px;
  }
  .rediagnosis-button {
    display: block; width: 100%; max-width: 320px; margin: 25px auto; padding: 18px;
    font-size: 1.2em; font-weight: 800; color: #fff !important;
    background: linear-gradient(135deg, #6a1b9a, #8e24aa);
    border: none; border-radius: 50px; text-align: center; text-decoration: none;
    box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3);
  }
"@

function Final-Fix-File($File) {
    # READ with UTF8 (might have BOM or not)
    $Content = [System.IO.File]::ReadAllText($File.FullName, [System.Text.Encoding]::UTF8)
    
    $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace("\", "/")
    $IsEn = $RelPath -match "en/"
    $IsTypePage = ($RelPath -match "/types/") -and ($RelPath -notmatch "list.html")
    
    # 1. Update CSS
    if ($Content -match '/\* Professional UI/UX Updates \*/') {
        $Pattern = '(?s)/\* Professional UI/UX Updates \*/.*?</style>'
        $Content = $Content -replace $Pattern, "$FinalCss`n  </style>"
    }
    
    # 2. Rediagnosis Button
    if ($IsTypePage) {
        $BtnText = if ($IsEn) { "Diagnose Again" } else { "もう一度診断する" }
        $BtnHtml = "<a href=`"../index.html`" class=`"rediagnosis-button`">$BtnText</a>"
        
        # Clean current (prevent Mojibake duplicate)
        # We use a pattern to find any rediagnosis button even if it's mojibake
        $Content = $Content -replace '<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>', ""
        
        if ($Content -match '<div class="bottom-nav-wrapper">') {
            $Content = $Content.Replace('<div class="bottom-nav-wrapper">', "$BtnHtml`n        <div class=" + '"bottom-nav-wrapper">')
        }
    }
    
    # 3. Logo Linking Cleanup
    # Ensure H1 is wrapped exactly once
    if ($Content -match '<h1><a href=".*?">.*?</a></h1>') {
        # Already linked, check path
        # (Assuming path is mostly ok for now, focus on fixing duplicates)
    }
    
    # WRITE with NO BOM UTF8
    [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Final-Fix-File $File }

Write-Host "PowerShell Final Fix Complete."
