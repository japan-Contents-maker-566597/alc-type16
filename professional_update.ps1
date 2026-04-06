# ============================================================
# UI/UX & Professional Engineering Update Script
# ============================================================

$base = "C:\Users\01051992\Desktop\NEWalctype16\alctype16"

# --- Common CSS to inject ---
$common_css = @"
  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 a, h2 a { text-decoration: none; color: inherit; transition: opacity 0.2s; display: inline-block; }
  h1 a:hover, h2 a:hover { opacity: 0.7; }
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
    font-size: 1.2em; font-weight: 800; color: #fff;
    background: linear-gradient(135deg, #6a1b9a, #8e24aa);
    border: none; border-radius: 50px; text-align: center; text-decoration: none;
    box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3);
  }
"@

# --- Get all HTML files ---
$files = Get-ChildItem -Path $base -Filter *.html -Recurse

foreach ($f in $files) {
    $path = $f.FullName
    $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    
    # 1. Inject common CSS into <style>
    if ($content -match '</style>') {
        $content = $content -replace '</style>', "$common_css`n</style>"
    }

    # 2. Add Link to <h1> (Logo)
    # Relative path logic
    $relPath = "index.html"
    if ($f.Directory.Name -eq "types") { $relPath = "../index.html" }
    elseif ($f.Directory.Name -eq "en") { $relPath = "index.html" } # en/index.html
    elseif ($path -match "en\\types") { $relPath = "../index.html" } # en/types/fodt.html -> en/index.html

    if ($content -match '<h1>(.*?)</h1>') {
        $content = [Regex]::Replace($content, '<h1>(.*?)</h1>', "<h1><a href=""$relPath"">`$1</a></h1>")
    }

    # 3. Handle Types Pages (h1 might be missing)
    if ($f.Directory.Name -eq "types" -or $f.Directory.FullName -match "en\\types") {
        # Add a mini-header if h1 is missing (standard types pages have result-header)
        if ($content -notmatch '<h1>') {
            $logoText = if ($path -match "alctype16\\en") { "Drunk Personality Test" } else { "&#30330;&#22770;&#20013;&#65281;" } # Using entity text? No, use logo title
            $logoText = if ($path -match "alctype16\\en") { "Drunk Personality Test" } else { "【公式】酒タイプ診断" }
            $content = $content -replace '<div class="container">', "<div class=""container""><h1 style=""font-size: 1.1em; margin-bottom: 25px; border-bottom: 1px solid #eee; padding-bottom: 10px; text-align: left;""><a href=""$relPath"" style=""color: #6a1b9a;"">${logoText}</a></h1>"
        }

        # 4. Add Rediagnosis Button
        $btnText = if ($path -match "alctype16\\en") { "Diagnose Again" } else { "もう一度診断する" }
        if ($content -match '<div class="share-section">') {
            # Insert before the end of container or after share section
            $content = $content -replace '(<div class="share-section">)', "<a href=""$relPath"" class=""rediagnosis-button"">${btnText}</a>`n  `$1"
        }
    }

    # 5. Bold key phrases automatically (Point 3)
    # Replace anything in brakets or key paragraphs with emphasis? No, it's manually set in result files usually.
    # I'll just refine the existing .key-sentence style in the common CSS.

    # 6. Add Meta tags (Point 5)
    if ($content -notmatch 'name="theme-color"') {
        $content = $content -replace '<head>', "<head><meta name=""theme-color"" content=""#6a1b9a"">"
    }

    # Write back as UTF-8
    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated UI/UX: $($f.FullName)"
}

Write-Host "Professional UI/UX Update complete."
