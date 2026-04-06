$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$MasterCss = @"
    :root {
      --primary-color: #ffffff;
      --secondary-color: #f0f4ff;
      --background-gradient: linear-gradient(135deg, #f3e5f5, #e1f5fe);
      --text-color: #333;
      --accent-color-a: #d32f2f;
      --accent-color-b: #1976d2;
      --border-radius: 24px;
      --shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }
    
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    
    body { 
      font-family: 'M PLUS Rounded 1c', sans-serif; 
      background: var(--background-gradient); 
      margin: 0; 
      padding: 20px; 
      color: var(--text-color); 
      padding-bottom: env(safe-area-inset-bottom, 100px) !important;
      animation: fadeIn 0.6s ease-out;
    }
    
    .container { 
      max-width: 800px; 
      width: 100%; 
      margin: 0 auto; 
      background-color: var(--primary-color); 
      border-radius: var(--border-radius); 
      box-shadow: var(--shadow); 
      padding: clamp(20px, 5vw, 40px); 
      box-sizing: border-box; 
    }
    
    h1, h2, h3 { text-align: center; font-weight: 800; }
    
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
    
    h2 { 
      font-size: clamp(1.8rem, 5vw, 2.5rem); 
      background: -webkit-linear-gradient(135deg, #ad1ea2, #2979ff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 0 0 20px 0;
    }
    
    p { line-height: 1.8; }
    
    /* Buttons */
    .action-button, .bottom-nav-button, .x-share-button, .secondary-button, .rediagnosis-button { 
      display: block; 
      width: 100%; 
      padding: 18px; 
      font-size: 1.2em; 
      font-weight: 800; 
      border-radius: 50px; 
      cursor: pointer; 
      transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important; 
      text-align: center; 
      text-decoration: none; 
      box-sizing: border-box; 
      border: none;
      margin-top: 15px;
    }
    
    .action-button, .rediagnosis-button { 
      color: #fff !important; 
      background: linear-gradient(135deg, #6a1b9a, #8e24aa);
      box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3);
    }
    
    .secondary-button, .bottom-nav-button {
      background-color: #fff;
      color: #3949ab !important;
      border: 2px solid #3949ab;
      padding: 16px;
    }
    
    .bottom-nav-button.primary {
      background-color: #3949ab;
      color: #fff !important;
    }
    
    .action-button:hover, .bottom-nav-button:hover, .rediagnosis-button:hover { 
      transform: translateY(-2px); 
      box-shadow: 0 8px 20px rgba(0,0,0,0.15) !important; 
    }
    
    .action-button:active, .bottom-nav-button:active, .rediagnosis-button:active { 
      transform: scale(0.97) translateY(1px) !important; 
    }
    
    /* Layout Helpers */
    .button-wrapper { margin-top: 30px; }
    .bottom-nav-wrapper { margin-top: 40px; padding-top: 20px; border-top: 1px solid #eee; display: flex; justify-content: center; align-items: center; gap: 15px; flex-wrap: wrap; }
    .footer-nav { text-align: center; margin-top: 30px; padding-bottom: 20px; font-size: 0.9em; opacity: 0.7; }
    .footer-nav a { color: inherit; margin: 0 10px; text-decoration: underline; }

    /* Top Page Specific */
    .top-description { text-align: center; margin-bottom: 30px; font-weight: 700; color: #555; }
    .alert-accordion { background: #fffde7; border: 2px solid #fff176; border-radius: 16px; margin-bottom: 25px; overflow: hidden; }
    .alert-accordion summary { padding: 15px; cursor: pointer; font-weight: 800; color: #f57f17; list-style: none; display: flex; justify-content: space-between; align-items: center; }
    .alert-detail { padding: 15px; background: #fff; border-top: 1px solid #fff176; font-size: 0.9em; }
    .banner-attention { display: block; text-align: center; font-size: 0.8em; font-weight: 800; color: #6a1b9a; margin-top: 20px; margin-bottom: -10px; }

    /* Diagnosis Page Specific */
    .question-card { background-color: #f8f9fa; padding: clamp(15px, 4vw, 25px); border-radius: 16px; margin-bottom: 25px; border: 1px solid #e9ecef; }
    .question-text { font-weight: 700; font-size: 1.2em; margin-bottom: 20px; text-align: center; }
    .question-choice { font-size: 1.1em; font-weight: 700; padding: 12px; border-radius: 12px; text-align: center; }
    .question-choice-a { color: var(--accent-color-a); background-color: #ffebee; }
    .question-choice-b { color: var(--accent-color-b); background-color: #e3f2fd; }
    .options-container { display: flex; justify-content: space-around; width: 100%; margin: 20px 0; padding: 0; }
    .option-label { display: flex; flex-direction: column; align-items: center; cursor: pointer; text-align: center; font-size: 0.9em; padding: 8px 4px; border-radius: 8px; transition: background-color 0.2s; flex: 1; }
    .option-label input[type="radio"] { width: 1.8em; height: 1.8em; cursor: pointer; }
    .option-label.selected { background-color: #dbeafe; }
    .name-input { width: 100%; max-width: 400px; display: block; margin: 0 auto; padding: 15px; border-radius: 16px; border: 2px solid #ddd; font-size: 1.1em; text-align: center; }
    .select-input { width: 100%; max-width: 320px; display: block; margin: 0 auto; padding: 12px; border-radius: 16px; border: 2px solid #ddd; }

    /* Result Page Specific */
    .result-header { text-align: center; background: linear-gradient(135deg, #fce4ec, #e3f2fd); padding: 20px; border-radius: var(--border-radius); margin-bottom: 20px; }
    .result-title { font-size: clamp(2rem, 6vw, 2.8rem); font-weight: 800; margin: 0 0 10px 0; background: -webkit-linear-gradient(135deg, #ad1ea2, #2979ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .result-image-wrapper { width: 220px; height: 220px; border-radius: 50%; background-color: #fff; margin: 0 auto 20px auto; display: flex; justify-content: center; align-items: center; overflow: hidden; box-shadow: 0 0 25px rgba(0,0,0,0.1); }
    .result-illustration { width: 100%; height: 100%; object-fit: contain; }
    .result-card { background-color: var(--secondary-color); padding: 25px; border-radius: 16px; margin-bottom: 20px; }
    .result-card h3 { display: inline-block; font-size: 1.1em; padding: 6px 14px; background-color: #d1c4e9; color: #311b92; border-radius: 10px; margin-top: 0; margin-bottom: 12px; }
    .result-card p { line-height: 1.9 !important; letter-spacing: 0.03em; margin-bottom: 1.2em; }
    .key-sentence { font-weight: 800; background: linear-gradient(transparent 60%, #fff9c4 60%) !important; padding: 2px 4px; border-radius: 4px; }
    .result-good { background-color: #e8f5e9; padding: 15px; border-radius: 12px; }
    .result-bad { background-color: #ffebee; padding: 15px; border-radius: 12px; }

    /* Share Section */
    .share-section { text-align: center; margin: 30px 0; padding: 20px; background-color: #f5f5f5; border-radius: 16px; }
    .x-share-button { background-color: #000; color: #fff !important; margin: 0 auto; max-width: 280px; }
    .x-logo { width: 20px; height: 20px; margin-right: 10px; fill: #fff; vertical-align: middle; }

    /* LINE stamp floating banner (Redesigned) */
    #line-stamp-fab{position:fixed;bottom:130px;right:20px;z-index:1000;text-decoration:none}
    #line-stamp-fab::before{content:'';position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:80px;height:80px;border-radius:50%;background:rgba(6,199,85,0.35);animation:fab-pulse 2s ease-out infinite;z-index:-1}
    #line-stamp-fab .fab-inner{position:relative;display:flex;flex-direction:column;align-items:center;justify-content:center;width:80px;height:80px;border-radius:50%;background:linear-gradient(145deg,#09e865,#05a847);color:#fff;font-family:inherit;font-weight:800;box-shadow:0 6px 20px rgba(6,199,85,0.6),0 2px 8px rgba(0,0,0,0.2),inset 0 2px 4px rgba(255,255,255,0.3);transition:transform 0.15s,box-shadow 0.15s;line-height:1.35;text-align:center;overflow:hidden}
    #line-stamp-fab .fab-inner::after{content:'';position:absolute;top:0;left:0;right:0;height:50%;background:linear-gradient(to bottom,rgba(255,255,255,0.22),transparent);pointer-events:none}
    #line-stamp-fab:hover .fab-inner{transform:scale(1.1);box-shadow:0 10px 28px rgba(6,199,85,0.7),0 4px 10px rgba(0,0,0,0.25)}
    #line-stamp-fab .fab-badge{position:absolute;top:-2px;right:-2px;background:#ff3b30;color:#fff;font-size:9px;font-weight:900;padding:2px 5px;border-radius:10px;letter-spacing:0.5px;border:2px solid #fff;line-height:1.2;z-index:2}
    @keyframes fab-pulse{0%{transform:translate(-50%,-50%) scale(1);opacity:0.8}100%{transform:translate(-50%,-50%) scale(1.9);opacity:0}}

    /* Global Utils */
    .lang-toggle { position: fixed; top: 16px; right: 16px; z-index: 9999; }
    .lang-toggle a { display: inline-flex; align-items: center; gap: 6px; background: rgba(255,255,255,0.9); backdrop-filter: blur(8px); color: #6a1b9a; font-weight: 800; font-size: 0.85em; padding: 8px 14px; border-radius: 20px; text-decoration: none; box-shadow: 0 2px 10px rgba(0,0,0,.15); border: 2px solid #d1c4e9; transition: all 0.2s; }
    .lang-toggle a:hover { background: #6a1b9a; color: #fff; border-color: #6a1b9a; transform: translateY(-2px); }

    /* Hide Unstyled/Unwanted elements */
    #roulette-fab { display: none !important; }
    .roulette-overlay { display: none !important; }
"@

function Emergency-Restore($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        # We replace the entire <style> block with our MasterCss
        $StylePattern = '(?s)<style.*?</style>'
        $NewStyle = "<style>`n$MasterCss`n  </style>"
        
        if ($Content -match $StylePattern) {
            $Content = [regex]::Replace($Content, $StylePattern, $NewStyle, [System.Text.RegularExpressions.RegexOptions]::Singleline)
            [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
            Write-Host "Restored: $($File.Name)"
        } else {
            # If no style tag, search for </head> and insert before it
            if ($Content -match '</head>') {
                $Content = $Content.Replace('</head>', "$NewStyle`n</head>")
                [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
                Write-Host "Injected into: $($File.Name)"
            }
        }
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Emergency-Restore $File }
Write-Host "Emergency Restoration Complete."
