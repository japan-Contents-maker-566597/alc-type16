$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# "もう一度診断する" in HTML Entities
$TextJp = "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;"
$TextEn = "Diagnose Again"

function Final-Precision-Fix($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace('\', '/')
        $IsEn = $RelPath -match 'en/'
        
        # 1. Fix Rediagnosis Button Text
        if ($RelPath -match '/types/' -and $RelPath -notmatch 'list.html') {
            $TargetText = if ($IsEn) { $TextEn } else { $TextJp }
            $Pattern = '<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>'
            $NewBtn = "<a href=""../index.html"" class=""rediagnosis-button"">$TargetText</a>"
            
            if ($Content -match $Pattern) {
                $Content = [regex]::Replace($Content, $Pattern, $NewBtn, [System.Text.RegularExpressions.RegexOptions]::Singleline)
            }
        }

        # 2. Global Sync H1 (Remove inline styles, ensure clean link)
        # Match <h1 ...>...</h1> even with styles
        $H1Pattern = '(?s)<h1.*?>.*?</h1>'
        
        # Determine H1 content based on language
        $H1Text = if ($IsEn) { "16 Drunk Personalities" } else { "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;" }
        
        # Determine Link Depth
        $Depth = ($RelPath.Split('/') | Where-Object { $_ }).Count - 1
        $Href = '../' * $Depth + 'index.html'
        if ($IsEn) {
            if ($Depth -eq 1) { $Href = 'index.html' } # alctype16/en/index.html
            else { $Href = '../' * ($Depth - 1) + 'index.html' } # alctype16/en/types/*.html
        }
        
        $CleanH1 = "<h1><a href=""$Href"">$H1Text</a></h1>"
        
        # Only replace if H1 exists (exclude policy.html etc if they don't have it, but they usually do)
        if ($Content -match $H1Pattern) {
             # We use a trick to avoid replacing multiple if they exist (though we expect 1)
             $Content = [regex]::Replace($Content, $H1Pattern, $CleanH1, [System.Text.RegularExpressions.RegexOptions]::Singleline)
        }

        [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Final-Precision-Fix $File }
Write-Host "Precision Fix Done."
