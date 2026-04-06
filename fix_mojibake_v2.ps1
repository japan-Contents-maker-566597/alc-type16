$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Using ASCII-safe Unicode escapes for Japanese characters to avoid script encoding issues
$TextRediagnosis = "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;"
$TextHeader = "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;"

function Fix-Mojibake-And-Sync($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        # known mojibake pattern for "もう一度診断する"
        $Mojibake = '繧ゅ≧荳€蠎ｦ險ｺ譁ｭ縺吶ｋ'
        if ($Content.Contains($Mojibake)) {
            $Content = $Content.Replace($Mojibake, $TextRediagnosis)
        }

        $PathPart = $File.FullName.Substring($BaseDir.Length + 1)
        $RelPath = $PathPart.Replace('\', '/')
        $Depth = ($RelPath.Split('/') | Where-Object { $_ }).Count - 1
        
        # Calculate Href for the base index.html
        $H1Href = '../' * $Depth + 'index.html'
        if ($RelPath -match 'en/') {
             if ($Depth -eq 1) { $H1Href = 'index.html' }
             else { $H1Href = '../' * ($Depth - 1) + 'index.html' }
        }
        
        if ($RelPath -notmatch 'en/') {
            $ExpectedH1 = "<h1><a href=""$H1Href"">$TextHeader</a></h1>"
            $Content = [regex]::Replace($Content, '<h1>.*?</h1>', $ExpectedH1, [System.Text.RegularExpressions.RegexOptions]::Singleline)
        }

        if ($RelPath -match '/types/' -and $RelPath -notmatch 'list.html') {
            $IsEn = $RelPath -match 'en/'
            $FinalBtnText = if ($IsEn) { "Diagnose Again" } else { $TextRediagnosis }
            $BtnHtml = "<a href=""../index.html"" class=""rediagnosis-button"">$FinalBtnText</a>"
            
            # Clean up current
            $Content = [regex]::Replace($Content, '<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
            
            if ($Content -match '<div class="bottom-nav-wrapper">') {
                $Content = $Content.Replace('<div class="bottom-nav-wrapper">', "$BtnHtml`n        <div class=""bottom-nav-wrapper"">")
            }
        }

        [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
    } catch {
        Write-Host "Error processing $($File.FullName): $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Fix-Mojibake-And-Sync $File }
Write-Host "Mojibake Fixed."
