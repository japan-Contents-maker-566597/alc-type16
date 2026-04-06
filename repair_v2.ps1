$BaseDir = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"

# Corrected CSS to ensure
$CssToApply = @"
  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 { 
    color: #6a1b9a !important; 
    white-space: nowrap !important; 
    font-size: clamp(1.2rem, 5.5vw, 2.5rem) !important; 
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

function Repair-File($File) {
    Write-Host "Repairing $($File.Name)..."
    $Content = [System.IO.File]::ReadAllText($File.FullName, [System.Text.Encoding]::UTF8)
    
    $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace("\", "/")
    $IsEn = $RelPath.StartsWith("en/")
    
    # --- 1. Fix missing tags (especially in diagnosis.html) ---
    if ($Content -match '/\* Professional UI/UX Updates \*/' -and $Content -notmatch '</style>') {
        # Find the last closing brace before the start of HTML body
        if ($Content -match 'REDiagnosis-button\s*\{[^}]*\}') {
             $Content = $Content -replace '(rediagnosis-button\s*\{[^}]*\})', "`$1`n</style>`n</head>`n<body>"
        } elseif ($Content -match '\}[^}]*$') {
            # Last resort: insert at the very end of styles
             $Content = $Content -replace '(\}[^}]*$)', "`$1`n</style>`n</head>`n<body>"
        }
    }
    
    # --- 2. Update CSS Block ---
    if ($Content -match '/\* Professional UI/UX Updates \*/') {
        $Pattern = '(?s)/\* Professional UI/UX Updates \*/.*?</style>'
        if ($Content -match $Pattern) {
            $Content = $Content -replace $Pattern, "$CssToApply`n</style>"
        }
    }

    # --- 3. Result Pages (Share buttons) ---
    if ($RelPath -match "/types/") {
        # Extract title from H2
        if ($Content -match '<h2 class="result-title">(.*?)</h2>') {
            $TypeName = $Matches[1].Trim()
            $Code = [System.IO.Path]::GetFileNameWithoutExtension($RelPath)
            
            $ShareTitleText = if ($IsEn) { "Share your result!" } else { "&#x7D50;&#x679C;&#x3092;&#x30B7;&#x30A7;&#x30A2;&#x3057;&#x3000;&#x3046;&#xFF01;" } # 結果をシェアしよう！
            $TweetPrefix = if ($IsEn) { "My drunk type is [$TypeName]! 🍻 #16DrunkPersonalities" } else { "&#x79C1;&#x306E;&#x9152;&#x30BF;&#x30A4;&#x30D7;&#x306F;&#x3010;$TypeName&#x3011;&#x3067;&#x3057;&#x305F;&#xFF01;&#127867; #&#37202;&#x30BF;&#x30A4;&#x30D7;&#x8A3A;&#x65AD;" }
            $BaseUrl = if ($IsEn) { "https://sync-loft.com/alctype16/en/types/$Code.html" } else { "https://sync-loft.com/alctype16/types/$Code.html" }
            
            $TwitterUrl = "https://twitter.com/intent/tweet?text=" + [uri]::EscapeDataString($TweetPrefix) + "&url=" + [uri]::EscapeDataString($BaseUrl)
            $XButtonText = if ($IsEn) { "Post on X" } else { "X&#x3067;&#x30DD;&#x30B9;&#x30C8;&#x3059;&#x308B;" } # Xでポストする

            $ShareSection = @"
        <div class="share-section">
            <p class="share-title">$ShareTitleText</p>
            <a href="$TwitterUrl" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
                $XButtonText
            </a>
        </div>
"@
            # Remove existing redundancy and insert
            $Content = $Content -replace '(?s)<div class="share-section">.*?</div>', ""
            if ($Content -match '<div class="bottom-nav-wrapper">') {
                $Content = $Content -replace '<div class="bottom-nav-wrapper">', ("$ShareSection`n" + '<div class="bottom-nav-wrapper">')
            }
        }
    }

    # --- 4. Diagnosis (JP) restoration ---
    if ($RelPath -eq "diagnosis.html" -and $Content -match "Tell Us About Yourself") {
        # Restore JP Labels
        $Content = $Content.Replace("<h2>Tell Us About Yourself</h2>", "<h2>&#12354;&#12394;&#12383;&#12398;&#12371;&#12392;&#12434;&#25945;&#12360;&#12390;&#12367;&#12384;&#12373;&#12354;&#12356;</h2>")
        $Content = $Content.Replace("placeholder=`"Enter your nickname`"", "placeholder=`"&#12491;&#12483;&#12463;&#12493;&#12540;&#12512;&#12434;&#20837;&#21147;`"")
        $Content = $Content.Replace("Gender (optional)", "&#x6027;&#x5225;&#xFF08;&#x4EFB;&#x610F;&#xFF09;")
        $Content = $Content.Replace("Get My Result!", "&#x3055;&#x3063;&#x305D;&#x304F;&#x8A3A;&#x65AD;&#x3059;&#x308B;")
        $Content = $Content.Replace("Prefer not to say", "&#x56DE;&#x7B54;&#x3057;&#x306A;&#x3044;")
        $Content = $Content.Replace("Male", "&#x7537;&#x6027;")
        $Content = $Content.Replace("Female", "&#x5973;&#x6027;")
    }

    [System.IO.File]::WriteAllText($File.FullName, $Content, [System.Text.Encoding]::UTF8)
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Repair-File $File }
Write-Host "All Fixed."
