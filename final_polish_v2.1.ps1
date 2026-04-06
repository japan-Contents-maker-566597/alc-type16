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
      --brand-purple: #6a1b9a;
    }
    
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    
    body { 
      font-family: 'M PLUS Rounded 1c', sans-serif; 
      background: var(--background-gradient); 
      margin: 0; 
      padding: 20px; 
      color: var(--text-color); 
      padding-bottom: env(safe-area-inset-bottom, 120px) !important;
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
      color: var(--brand-purple) !important; 
      white-space: nowrap !important; 
      font-size: clamp(1.4rem, 7vw, 3rem) !important; 
      margin-bottom: 25px !important; 
      text-align: center !important; 
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 1.2;
    }
    
    h1 a { 
      text-decoration: none !important; 
      color: var(--brand-purple) !important; 
      transition: opacity 0.2s; 
      display: inline-block; 
    }
    h1 a:hover { opacity: 0.7; }
    
    h2 { 
      font-size: clamp(1.6rem, 5vw, 2.4rem); 
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
      font-size: 1.15em; 
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
      background: linear-gradient(135deg, #6a1b9a, #8e24aa) !important;
      box-shadow: 0 6px 18px rgba(106, 27, 154, 0.35);
    }
    
    .secondary-button, .bottom-nav-button {
      background: #ffffff !important; 
      color: var(--brand-purple) !important;
      border: 2px solid var(--brand-purple) !important;
      padding: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    
    .bottom-nav-button.primary {
      background-color: #3949ab !important;
      color: #fff !important;
      border-color: #3949ab !important;
      background-image: none !important;
    }
    
    .action-button:hover, .bottom-nav-button:hover, .rediagnosis-button:hover { 
      transform: translateY(-2px); 
      box-shadow: 0 8px 22px rgba(0,0,0,0.18) !important; 
    }
    
    .action-button:active, .bottom-nav-button:active, .rediagnosis-button:active { 
      transform: scale(0.97) translateY(1px) !important; 
    }
    
    /* Layout Helpers */
    .button-wrapper { margin-top: 30px; }
    .bottom-nav-wrapper { margin-top: 40px; padding-top: 20px; border-top: 1px solid #eee; display: flex; justify-content: center; align-items: center; gap: 15px; flex-wrap: wrap; }
    .footer-nav { text-align: center; margin-top: 40px; padding-bottom: 20px; font-size: 0.85em; color: #777; }
    .footer-nav a { color: var(--brand-purple); margin: 0 10px; text-decoration: none; font-weight: 700; }

    /* Top Page Specific */
    .top-description { text-align: center; margin: 0 auto 30px auto; max-width: 600px; font-weight: 700; color: #555; font-size: 0.95em; line-height: 1.7; }
    .alert-accordion { background: #fffde7; border: 2px solid #fff176; border-radius: 20px; margin-bottom: 25px; overflow: hidden; }
    .alert-accordion summary { padding: 15px 20px; cursor: pointer; font-weight: 800; color: #f57f17; list-style: none; display: flex; justify-content: space-between; align-items: center; }
    .alert-detail { padding: 20px; background: #fff; border-top: 1px solid #fff176; font-size: 0.9em; line-height: 1.8; }
    .banner-attention { display: block; text-align: center; font-size: 0.8em; font-weight: 800; color: #6a1b9a; margin-top: 20px; margin-bottom: -10px; }

    /* Diagnosis Page Specific */
    .question-card { background-color: #f8f9fa; padding: clamp(15px, 4vw, 25px); border-radius: 20px; margin-bottom: 25px; border: 1px solid #e9ecef; }
    .question-text { font-weight: 700; font-size: 1.15em; margin-bottom: 20px; text-align: center; color: var(--brand-purple); }
    .question-choice { font-size: 1.05em; font-weight: 700; padding: 12px; border-radius: 12px; text-align: center; }
    .question-choice-a { color: var(--accent-color-a); background-color: #ffebee; }
    .question-choice-b { color: var(--accent-color-b); background-color: #e3f2fd; }
    .options-container { display: flex; justify-content: space-around; width: 100%; margin: 20px 0; padding: 0; }
    .option-label { display: flex; flex-direction: column; align-items: center; cursor: pointer; text-align: center; font-size: 0.85em; padding: 8px 4px; border-radius: 12px; transition: background-color 0.2s; flex: 1; }
    .option-label input[type="radio"] { width: 1.8em; height: 1.8em; cursor: pointer; margin-bottom: 8px; }
    .option-label.selected { background-color: #dbeafe; font-weight: 800; }
    .name-input { width: 100%; max-width: 400px; display: block; margin: 0 auto; padding: 15px; border-radius: 16px; border: 2px solid #ddd; font-size: 1.1em; text-align: center; font-family: inherit; }
    .select-input { width: 100%; max-width: 320px; display: block; margin: 0 auto; padding: 12px; border-radius: 16px; border: 2px solid #ddd; font-family: inherit; }

    /* Result Page Specific */
    .result-header { text-align: center; background: linear-gradient(135deg, #fce4ec, #e3f2fd); padding: 25px; border-radius: var(--border-radius); margin-bottom: 20px; border: 1px solid rgba(255,255,255,0.5); }
    .result-title { font-size: clamp(2rem, 6vw, 2.8rem); font-weight: 800; margin: 0 0 10px 0; background: -webkit-linear-gradient(135deg, #ad1ea2, #2979ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .result-image-wrapper { width: 220px; height: 220px; border-radius: 50%; background-color: #fff; margin: 0 auto 20px auto; display: flex; justify-content: center; align-items: center; overflow: hidden; box-shadow: 0 8px 30px rgba(0,0,0,0.12); border: 4px solid #fff; }
    .result-illustration { width: 100%; height: 100%; object-fit: contain; }
    .result-catchphrase-display { text-align: center; font-weight: 800; color: #555; margin-bottom: 25px; font-size: 1.1em; line-height: 1.6; padding: 0 10px;}
    .result-card { background-color: var(--secondary-color); padding: 25px; border-radius: 20px; margin-bottom: 20px; border: 1px solid #e1f5fe; }
    .result-card h3 { display: inline-block; font-size: 1.05em; padding: 6px 16px; background-color: #d1c4e9; color: #311b92; border-radius: 30px; margin-top: 0; margin-bottom: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .result-card p { line-height: 1.9 !important; letter-spacing: 0.02em; margin-bottom: 1.2em; }
    .key-sentence { font-weight: 800; background: linear-gradient(transparent 60%, #fff9c4 60%) !important; padding: 2px 4px; border-radius: 4px; }
    .result-good { background-color: #e8f5e9; padding: 18px; border-radius: 16px; border-left: 5px solid #4caf50; }
    .result-bad { background-color: #ffebee; padding: 18px; border-radius: 16px; border-left: 5px solid #f44336; }

    /* List Page Specific */
    #type-list-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; margin-top: 20px; }
    .type-card-link { text-decoration: none; color: inherit; display: block; height: 100%; transition: transform 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
    .type-card-link:hover { transform: translateY(-8px); }
    .type-card { background: #fff; border: 1px solid #eee; border-radius: 24px; padding: 25px; text-align: center; box-shadow: 0 4px 20px rgba(0,0,0,0.06); height: 100%; box-sizing: border-box; display: flex; flex-direction: column; align-items: center; }
    .type-card-image-wrapper { width: 150px; height: 150px; border-radius: 50%; overflow: hidden; margin-bottom: 18px; border: 4px solid #f3e5f5; background: #fafafa; }
    .type-card-illustration { width: 100%; height: 100%; object-fit: contain; }
    .type-card-name { font-size: 1.25em; font-weight: 800; color: var(--brand-purple); margin: 10px 0; line-height: 1.3; }
    .type-card-catchphrase { font-size: 0.88em; line-height: 1.6; color: #666; margin: 0; }

    /* Share Section */
    .share-section { text-align: center; margin: 40px 0 30px 0; padding: 25px; background-color: #f8f9fa; border-radius: 20px; border: 1px solid #eee; }
    .share-title { font-weight: 800; color: var(--brand-purple); margin-bottom: 15px; }
    .x-share-button { background-color: #000; color: #fff !important; margin: 0 auto; max-width: 300px; display: inline-flex; align-items: center; justify-content: center; gap: 10px; }
    .x-logo { width: 22px; height: 22px; fill: #fff; }

    /* LINE stamp floating banner (Optimized size) */
    #line-stamp-fab{position:fixed;bottom:120px;right:20px;z-index:9999;text-decoration:none}
    #line-stamp-fab::before{content:'';position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:70px;height:70px;border-radius:50%;background:rgba(6,199,85,0.4);animation:fab-pulse 2s ease-out infinite;z-index:-1}
    #line-stamp-fab .fab-inner{position:relative;display:flex;flex-direction:column;align-items:center;justify-content:center;width:70px;height:70px;border-radius:50%;background:linear-gradient(145deg,#09e865,#05a847);color:#fff;font-family:inherit;font-weight:800;box-shadow:0 8px 25px rgba(6,199,85,0.5),inset 0 2px 4px rgba(255,255,255,0.3);transition:transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);line-height:1.3;text-align:center;overflow:hidden}
    #line-stamp-fab:hover .fab-inner{transform:scale(1.15) rotate(5deg);}
    #line-stamp-fab .fab-badge{position:absolute;top:-2px;right:-2px;background:#ff3b30;color:#fff;font-size:10px;font-weight:900;padding:2px 6px;border-radius:12px;border:2px solid #fff;z-index:2}
    #line-stamp-fab .fab-icon { font-size: 1.2em; margin-bottom: 1px; }
    #line-stamp-fab .fab-label-main { font-size: 0.52em; letter-spacing: -0.2px; white-space: nowrap; }
    @keyframes fab-pulse{0%{transform:translate(-50%,-50%) scale(1);opacity:0.8}100%{transform:translate(-50%,-50%) scale(2);opacity:0}}

    /* Global Utils */
    .lang-toggle { position: fixed; top: 16px; right: 16px; z-index: 10000; }
    .lang-toggle a { display: inline-flex; align-items: center; gap: 6px; background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); color: var(--brand-purple); font-weight: 800; font-size: 0.88em; padding: 10px 16px; border-radius: 30px; text-decoration: none; box-shadow: 0 4px 15px rgba(0,0,0,.12); border: 2px solid #e1f5fe; transition: all 0.2s; }
    .lang-toggle a:hover { background: var(--brand-purple); color: #fff; border-color: var(--brand-purple); transform: translateY(-2px); }

    /* Hide Unstyled/Unwanted elements */
    #roulette-fab { display: none !important; }
    .roulette-overlay { display: none !important; }
    .sp-only { display: none; }
    @media (max-width: 600px) { .sp-only { display: block; } }
"@

function Emergency-Restore($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        $StylePattern = '(?s)<style.*?</style>'
        $NewStyle = "<style>`n$MasterCss`n  </style>"
        
        if ($Content -match $StylePattern) {
            $Content = [regex]::Replace($Content, $StylePattern, $NewStyle, [System.Text.RegularExpressions.RegexOptions]::Singleline)
            [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
            Write-Host "Polished: $($File.Name)"
        }
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Emergency-Restore $File }
Write-Host "Final Polish V2.1 Complete."
