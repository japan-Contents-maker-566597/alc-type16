$base = "C:\Users\01051992\Desktop\NEWalctype16\alctype16"
$logo_entity = "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;"
$retry_entity = "&#12418;&#12358;&#19968;&#24230;&#35386;&#26029;&#12377;&#12427;"

$files = Get-ChildItem -Path $base -Filter *.html -Recurse

foreach ($f in $files) {
    $path = $f.FullName
    $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    
    $content = $content.Replace("縲仙・蠑上€鷹・繧ｿ繧､繝苓ｨｺ譁ｭ", $logo_entity)
    $content = $content.Replace("繧ゅ≧荳€蠎ｦ險ｺ譁ｭ縺吶ｋ", $retry_entity)

    if ($content -match '<h1>(?!<a)') {
        $rel = "index.html"
        if ($path -match "\\types\\") { $rel = "../index.html" }
        elseif ($path -match "\\en\\types\\") { $rel = "../index.html" }
        
        $content = [Regex]::Replace($content, '<h1>((?!<a).*?)</h1>', "<h1><a href=""$rel"">`$1</a></h1>")
    }

    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Processed: $path"
}
