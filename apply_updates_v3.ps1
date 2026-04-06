$base = "C:\Users\01051992\Desktop\NEWalctype16\alctype16"
$logo_entity = "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;"
$retry_entity = "&#12418;&#12358;&#19968;&#24230;&#35386;&#26029;&#12377;&#12427;"
$css = "/* Professional UI/UX Updates */`n@keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }`nbody { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }`nh1 a, h2 a { text-decoration: none; color: inherit; transition: opacity 0.2s; display: inline-block; }`nh1 a:hover, h2 a:hover { opacity: 0.7; }`n.action-button, .bottom-nav-button, .x-share-button, .secondary-button, .rediagnosis-button { transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important; cursor: pointer; }`n.action-button:hover, .bottom-nav-button:hover, .rediagnosis-button:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.15) !important; }`n.action-button:active, .bottom-nav-button:active, .rediagnosis-button:active { transform: scale(0.97) translateY(1px) !important; }`n.result-card p { line-height: 1.9 !important; letter-spacing: 0.03em; margin-bottom: 1.2em; }`n.key-sentence { font-weight: 800; background: linear-gradient(transparent 60%, #fff9c4 60%) !important; padding: 2px 4px; border-radius: 4px; }`n.rediagnosis-button { display: block; width: 100%; max-width: 320px; margin: 25px auto; padding: 18px; font-size: 1.2em; font-weight: 800; color: #fff; background: linear-gradient(135deg, #6a1b9a, #8e24aa); border: none; border-radius: 50px; text-align: center; text-decoration: none; box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3); }"

Get-ChildItem -Path $base -Filter *.html -Recurse | ForEach-Object {
    $p = $_.FullName
    $c = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
    $c = $c.Replace("縲仙・蠑上€鷹・繧ｿ繧､繝苓ｨｺ譁ｭ", $logo_entity)
    $c = $c.Replace("繧ゅ≧荳€蠎ｦ險ｺ譁ｭ縺吶ｋ", $retry_entity)
    if ($c -notmatch "Professional UI/UX Updates" -and $c -match "</style>") { $c = $c -replace "</style>", "$css`n</style>" }
    if ($c -notmatch 'name="theme-color"' -and $c -match '<head>') { $c = $c -replace '<head>', '<head><meta name="theme-color" content="#6a1b9a">' }
    $rel = "index.html"
    if ($p -match "\\types\\") { $rel = "../index.html" }
    if ($p -match "\\en\\types\\") { $rel = "../index.html" }
    if ($c -match "<h1>(?!<a)") { $c = [Regex]::Replace($c, '(<h1>)(.*?)(</h1>)', "`$1<a href=""$rel"">`$2</a>`$3") }
    [System.IO.File]::WriteAllText($p, $c, [System.Text.Encoding]::UTF8)
}
