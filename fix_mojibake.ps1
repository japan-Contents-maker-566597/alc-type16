$BaseDir = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# HTML Entities for reliable Japanese text
$TextRediagnosis = "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;" # もう一度診断する
$TextHeader = "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;" # 【公式】酒タイプ診断

function Fix-Mojibake-And-Sync($File) {
    $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
    $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
    
    # Force fix specifically known mojibake pattern for "もう一度診断する"
    $Mojibake = "繧ゅ≧荳€蠎ｦ險ｺ譁ｭ縺吶ｋ"
    if ($Content.Contains($Mojibake)) {
        $Content = $Content.Replace($Mojibake, $TextRediagnosis)
    }

    # Ensure H1 title is correct and linked
    $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace("\", "/")
    $Depth = $RelPath.Split('/').Count - 1
    $Href = "../" * $Depth + "index.html"
    if ($RelPath -match "en/" -and $Depth -eq 1) { $Href = "index.html" }
    elseif ($RelPath -match "en/" -and $Depth -gt 1) { $Href = "../" * ($Depth - 1) + "index.html" }
    
    # For Non-English pages, ensure the title is the Japanese one with entities
    if ($RelPath -notmatch "en/") {
        # Fix H1 if broken or missing link
        $ExpectedH1 = "<h1><a href=""$Href"">$TextHeader</a></h1>"
        $Content = [regex]::Replace($Content, "<h1>.*?</h1>", $ExpectedH1, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    }

    # Ensure the rediagnosis button is correct in results pages
    if ($RelPath -match "/types/" -and $RelPath -notmatch "list.html") {
        $IsEn = $RelPath -match "en/"
        $FinalBtnText = if ($IsEn) { "Diagnose Again" } else { $TextRediagnosis }
        $BtnHtml = "<a href=`"../index.html`" class=`"rediagnosis-button`">$FinalBtnText</a>"
        
        # Clean up any existing rediagnosis buttons
        $Content = [regex]::Replace($Content, '<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>', "", [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        # Insert properly
        if ($Content -match '<div class="bottom-nav-wrapper">') {
            $Content = $Content.Replace('<div class="bottom-nav-wrapper">', "$BtnHtml`n        <div class=" + '"bottom-nav-wrapper">')
        }
    }

    [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Fix-Mojibake-And-Sync $File }

Write-Host "Mojibake Fixed and UI Synced."
