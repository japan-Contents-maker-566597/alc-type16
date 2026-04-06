# ============================
# Full LINE stamp re-application script
# ============================

$base = "C:\Users\01051992\Desktop\NEWalctype16\alctype16"

# --- New CSS block (minified, for all non-index pages) ---
$fab_css = @"
  /* LINE stamp floating banner */
  #line-stamp-fab{position:fixed;bottom:80px;right:20px;z-index:1000;text-decoration:none}
  #line-stamp-fab::before{content:'';position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:80px;height:80px;border-radius:50%;background:rgba(6,199,85,0.35);animation:fab-pulse 2s ease-out infinite;z-index:-1}
  #line-stamp-fab .fab-inner{position:relative;display:flex;flex-direction:column;align-items:center;justify-content:center;width:80px;height:80px;border-radius:50%;background:linear-gradient(145deg,#09e865,#05a847);color:#fff;font-family:'M PLUS Rounded 1c',sans-serif;font-weight:800;box-shadow:0 6px 20px rgba(6,199,85,0.6),0 2px 8px rgba(0,0,0,0.2),inset 0 2px 4px rgba(255,255,255,0.3);transition:transform 0.15s,box-shadow 0.15s;line-height:1.35;text-align:center;overflow:hidden}
  #line-stamp-fab .fab-inner::after{content:'';position:absolute;top:0;left:0;right:0;height:50%;background:linear-gradient(to bottom,rgba(255,255,255,0.22),transparent);pointer-events:none}
  #line-stamp-fab .fab-inner:hover{transform:scale(1.1);box-shadow:0 10px 28px rgba(6,199,85,0.7),0 4px 10px rgba(0,0,0,0.25),inset 0 2px 4px rgba(255,255,255,0.3)}
  #line-stamp-fab .fab-inner:active{transform:scale(0.94)}
  #line-stamp-fab .fab-badge{position:absolute;top:-2px;right:-2px;background:#ff3b30;color:#fff;font-size:9px;font-weight:900;padding:2px 5px;border-radius:10px;letter-spacing:0.5px;border:2px solid #fff;line-height:1.2;z-index:2}
  #line-stamp-fab .fab-icon{font-size:1.3em;line-height:1;margin-bottom:1px;display:block}
  #line-stamp-fab .fab-label-main{font-size:0.58em;letter-spacing:0.2px;display:block;line-height:1.4}
  @keyframes fab-pulse{0%{transform:translate(-50%,-50%) scale(1);opacity:0.8}100%{transform:translate(-50%,-50%) scale(1.9);opacity:0}}
"@

# --- New HTML block ---
$fab_html = @"
  <!-- LINE stamp floating banner -->
  <a id="line-stamp-fab"
     href="https://store.line.me/stickershop/product/33138149/ja?utm_source=gnsh_stickerDetail"
     target="_blank" rel="noopener"
     onclick="typeof gtag==='function'&&gtag('event','line_stamp_click',{event_category:'engagement',event_label:'floating_banner'})">
      <span class="fab-badge">NEW</span>
      <div class="fab-inner">
          <span class="fab-icon">🍻</span>
          <span class="fab-label-main">LINEスタンプ<br>発売中！</span>
      </div>
  </a>
"@

# === Process list.html, about.html, policy.html, and all types/*.html ===
$targets = @(
    "$base\list.html",
    "$base\about.html",
    "$base\policy.html"
) + (Get-ChildItem "$base\types\*.html" | Select-Object -ExpandProperty FullName)

$updated = 0
foreach ($file in $targets) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

    # Skip if already has the banner
    if ($content -match "fab-pulse") {
        Write-Host "Already updated: $(Split-Path $file -Leaf)"
        $updated++
        continue
    }

    # Insert CSS before .lang-toggle CSS (which is always the last thing before </style>)
    $content = $content -replace '(\.lang-toggle\{position:fixed)', "$fab_css`r`n  `$1"

    # Insert HTML before the Shinobi admax script (which is just before </body>)
    $content = $content -replace '(\s*<script src="https://adm\.shinobi\.jp)', "`r`n$fab_html`r`n`$1"

    [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated: $(Split-Path $file -Leaf)"
    $updated++
}

Write-Host "`nDone: $updated files processed"
