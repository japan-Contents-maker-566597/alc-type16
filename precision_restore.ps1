$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# --- Supplement Page Custom CSS (Extracted from test.html) ---
$SupplementCustomCss = @"
        .pr-mark { position: absolute; top: 10px; left: 20px; font-size: 0.8rem; color: #999; border: 1px solid #ccc; padding: 2px 6px; border-radius: 4px; background: #fff; }
        .hero-img { width: 100%; border-radius: 12px; margin-bottom: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); object-fit: cover; }
        .intro-text { text-align: center; margin-bottom: 30px; line-height: 1.8; font-size: 1.0rem; }
        .intro-highlight { display: inline-block; background: linear-gradient(transparent 60%, #fff176 60%); font-weight: 800; padding: 0 5px; margin-bottom: 5px; }
        .intro-desc { margin-top: 15px; font-size: 0.95rem; color: #444; display: block; }
        .honest-box { background: #fff3e0; border: 1px dashed #ffb74d; padding: 12px; border-radius: 12px; font-size: 0.8rem; margin-bottom: 30px; line-height: 1.5; color: #555; }
        .honest-title { font-weight: 800; color: #e65100; display: inline-block; margin-right: 5px; }
        .regulation-box { background: #e3f2fd; border: 2px solid #90caf9; padding: 20px; border-radius: 16px; margin-bottom: 30px; text-align: left; }
        .regulation-title { font-weight: 800; color: #1565c0; display: block; margin-bottom: 10px; font-size: 1.1rem; text-align: center; }
        .regulation-desc { text-align: center; margin-bottom: 20px; line-height: 1.7; color: #333; font-size: 1.0rem; font-weight: bold; }
        .regulation-item { margin-bottom: 15px; }
        .regulation-label { font-weight: 800; color: #1565c0; display: block; margin-bottom: 8px; border-bottom: 1px dashed #90caf9; padding-bottom: 2px; }
        .drink-menu { list-style: none; padding: 0; margin: 0; font-weight: bold; font-size: 1.0rem; }
        .drink-menu li { margin-bottom: 5px; padding-left: 0.5em; }
        .drink-count { color: #d32f2f; font-weight: 800; }
        .chara-box { margin: 40px 0; display: flex; align-items: center; justify-content: center; gap: 15px; }
        .chara-icon { width: 80px; height: 80px; border-radius: 50%; border: 3px solid #ffca28; box-shadow: 0 4px 6px rgba(0,0,0,0.1); object-fit: cover; background: #fff; flex-shrink: 0; }
        .chara-bubble { position: relative; background: #fff8e1; border: 2px solid #ffca28; border-radius: 12px; padding: 15px; font-weight: 800; color: #f57f17; font-size: 1.0rem; line-height: 1.5; white-space: nowrap; }
        .chara-bubble::after { content: ''; position: absolute; left: -10px; top: 50%; transform: translateY(-50%); border-width: 10px 10px 10px 0; border-style: solid; border-color: transparent #ffca28 transparent transparent; }
        .snnm-style .chara-icon { border-color: #f06292; }
        .snnm-style .chara-bubble { background: #fce4ec; border-color: #f06292; color: #c2185b; font-size: 0.8rem; line-height: 1.4; padding: 12px; text-align: left; white-space: normal; }
        .snnm-style .chara-bubble::after { border-color: transparent #f06292 transparent transparent; }
        .marker { background: linear-gradient(transparent 60%, #fff176 60%); font-weight: 800; }
        .item-card { border: 2px solid #eee; border-radius: 16px; padding: 20px; margin-bottom: 30px; background: #fff; transition: transform 0.2s; }
        .price-display { font-weight: 800; color: #555; background: #f0f0f0; padding: 5px 10px; border-radius: 6px; display: inline-block; font-size: 0.85rem; margin-bottom: 10px; }
        .good .price-display { background: #e3f2fd; color: #1565c0; }
        .product-area { margin: 15px 0 20px 0; text-align: center; }
        .product-img-box { margin-bottom: 15px; text-align: center; display: flex; justify-content: center; align-items: center; }
        .product-img-box img { width: 100%; max-width: 400px; height: auto; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: opacity 0.2s; }
        .product-img-box img:hover { opacity: 0.9; }
        .product-desc-text { font-size: 0.9rem; text-align: left; background: #fff; border: 1px solid #e0e0e0; padding: 15px; border-radius: 8px; line-height: 1.7; color: #444; }
        .product-desc-title { font-weight: 800; color: #333; display: block; margin-bottom: 8px; border-bottom: 1px solid #eee; padding-bottom: 4px; }
        .recommend-list { margin: 15px 0; padding: 0; list-style: none; font-size: 0.9rem; background: #f9f9f9; border-radius: 8px; padding: 15px; }
        .recommend-title { font-weight: 800; display: block; margin-bottom: 8px; color: #333; border-bottom: 1px dashed #ccc; padding-bottom: 4px; }
        .recommend-list li { margin-bottom: 5px; padding-left: 1em; text-indent: -1em; }
        .recommend-list li::before { content: "・"; font-weight: bold; }
        .item-card.bad { background: #f5f5f5; border-color: #ddd; opacity: 0.9; }
        .item-card.bad .item-title { color: #666; }
        .item-card.bad .star-rating { color: #999; }
        .item-card.normal { background: #fffde7; border-color: #fff59d; }
        .item-card.normal .item-title { color: #fbc02d; border-color: #fff176; }
        .item-card.normal .star-rating { color: #fbc02d; }
        .item-card.normal .comment { background: #fff9c4; border-left-color: #fbc02d; }
        .item-card.good { border: 2px solid #e3f2fd; box-shadow: 0 4px 10px rgba(0,0,0,0.03); }
        .item-card.good .item-title { color: #1565c0; border-color: #e3f2fd; }
        .item-card.good .star-rating { color: #fbc02d; }
        .item-card.good .comment { background: #e3f2fd; border-left-color: #2196f3; color: #0d47a1; }
        .item-title { font-size: 1.2rem; font-weight: 800; margin-bottom: 10px; display: block; border-bottom: 2px solid #eee; padding-bottom: 5px; }
        .star-rating { font-weight: 800; font-size: 1.1rem; margin-bottom: 10px; display: flex; align-items: center; }
        .stars-outer { display: inline-block; position: relative; font-family: FontAwesome, sans-serif; color: #ddd; }
        .stars-outer::before { content: "★★★★★"; }
        .stars-inner { position: absolute; top: 0; left: 0; white-space: nowrap; overflow: hidden; width: 0; color: #fbc02d; }
        .stars-inner::before { content: "★★★★★"; }
        .rating-text { margin-left: 8px; font-size: 0.9em; color: #666; }
        .comment { background: #fafafa; padding: 10px; border-radius: 8px; margin: 10px 0 20px 0; font-size: 0.95rem; border-left: 4px solid #ddd; line-height: 1.7; }
        .micro-copy { display: block; text-align: center; font-size: 0.8rem; color: #f57c00; font-weight: bold; margin-top: 15px; margin-bottom: -5px; }
        .cv-button { display: block; width: 100%; padding: 16px 0; background: linear-gradient(135deg, #ff8f00, #f57c00); color: white !important; text-align: center; text-decoration: none; font-weight: 800; border-radius: 50px; margin-top: 10px; box-shadow: 0 4px 0 #e65100; transition: transform 0.1s; }
        .cv-button:active { transform: translateY(4px); box-shadow: none; }
        .back-link { display: block; text-align: center; margin-top: 40px; color: #6a1b9a !important; text-decoration: underline; font-size: 1rem; font-weight: bold; }
        .disclaimer { font-size: 0.75rem; color: #999; text-align: center; margin-top: 30px; line-height: 1.4; }
"@

# --- Restore Supplement Page ---
$SupFile = Join-Path $BaseDir "supplement\index.html"
if (Test-Path $SupFile) {
    $RawBytes = [System.IO.File]::ReadAllBytes($SupFile)
    $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
    
    # Inject unique styles before the closing </style>
    $Content = $Content -replace '(  </style>)', "`n$SupplementCustomCss`n`$1"
    
    # Remove duplicate LINE FAB in the body (the second one)
    $FabPattern = '(?s)  <!-- LINE stamp floating banner -->.*?</a>'
    $Matches = [regex]::Matches($Content, $FabPattern)
    if ($Matches.Count -gt 1) {
        # Keep the first, remove the rest
        for ($i = 1; $i -lt $Matches.Count; $i++) {
            $Content = $Content.Replace($Matches[$i].Value, "")
        }
    }
    
    [System.IO.File]::WriteAllText($SupFile, $Content, $Utf8NoBom)
    Write-Host "Restored Supplement Page Unique Styles."
}

# --- Restore About Page Unique Styles ---
$AboutFile = Join-Path $BaseDir "about.html"
$AboutCss = @"
    .axis-list { list-style: none; padding: 0; margin: 30px 0; }
    .axis-item { display: flex; align-items: flex-start; gap: 20px; background: #f8f9fa; padding: 20px; border-radius: 20px; margin-bottom: 20px; border: 1px solid #eee; transition: transform 0.2s; }
    .axis-item:hover { transform: scale(1.02); background: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    .axis-label { flex-shrink: 0; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; color: #fff; font-size: 1.25em; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    .axis-label.lf { background: linear-gradient(135deg, #ff5252, #ff1744); }
    .axis-label.or { background: linear-gradient(135deg, #448aff, #2979ff); }
    .axis-label.ud { background: linear-gradient(135deg, #00e676, #00c853); }
    .axis-label.ty { background: linear-gradient(135deg, #ffd740, #ffc400); }
    .axis-desc { flex-grow: 1; }
    .axis-desc h4 { margin: 0 0 5px 0; color: #333; font-size: 1.1em; text-align: left; }
    .axis-desc p { margin: 0; font-size: 0.9em; color: #666; line-height: 1.6; text-align: left; }
"@

if (Test-Path $AboutFile) {
    $RawBytes = [System.IO.File]::ReadAllBytes($AboutFile)
    $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
    $Content = $Content -replace '(  </style>)', "`n$AboutCss`n`$1"
    # Remove duplicate LINE FAB
    $Matches = [regex]::Matches($Content, $FabPattern)
    if ($Matches.Count -gt 1) {
        for ($i = 1; $i -lt $Matches.Count; $i++) { $Content = $Content.Replace($Matches[$i].Value, "") }
    }
    [System.IO.File]::WriteAllText($AboutFile, $Content, $Utf8NoBom)
    Write-Host "Restored About Page Unique Styles."
}

Write-Host "Precision Restoration Complete."
