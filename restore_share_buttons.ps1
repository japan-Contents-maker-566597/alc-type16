$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Restore-Share-Button($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        # If already has share-section, skip
        if ($Content -match 'class="share-section"') { return }

        # Get Type Name from H2
        $TypeName = ""
        if ($Content -match '<h2 class="result-title">(.*?)</h2>') {
            $TypeName = $Matches[1]
        }
        
        $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace('\', '/')
        $IsEn = $RelPath -match 'en/'
        
        $ShareTitle = if ($IsEn) { "Share your result!" } else { "&#35386;&#26029;&#32080;&#26524;&#12434;&#12471;&#12455;&#12450;&#12375;&#12424;&#12358;&#65281;" } # 診断結果をシェアしよう！
        $BtnText = if ($IsEn) { "Post on X" } else { "X&#12391;&#12509;&#12473;&#12488;&#12377;&#12427;" } # Xでポストする
        
        $TwitterText = if ($IsEn) { "My drunk type is [$TypeName]! Check yours here:" } else { "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;&#12398;&#32080;&#26524;&#12399;&#8230;&#12300;$TypeName&#12301;&#12391;&#12375;&#12383;&#65281;" }
        $TwitterUrl = "https://sync-loft.com/alctype16/$RelPath"
        
        $ShareHtml = @"
        <div class="share-section">
            <p class="share-title">$ShareTitle</p>
            <a href="https://twitter.com/intent/tweet?text=$TwitterText&url=$TwitterUrl" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
                $BtnText
            </a>
        </div>
"@

        $TargetPattern = '<a href="../index.html" class="rediagnosis-button">'
        if ($Content -match $TargetPattern) {
            $Content = $Content.Replace($TargetPattern, "$ShareHtml`n        $TargetPattern")
            [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
            Write-Host "Restored Share: $($File.Name)"
        }
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path "$BaseDir\types" -Filter "*.html"
foreach ($File in $Files) { Restore-Share-Button $File }

$FilesEn = Get-ChildItem -Path "$BaseDir\en\types" -Filter "*.html"
foreach ($File in $FilesEn) { Restore-Share-Button $File }

Write-Host "X Share Button Restoration Complete."
