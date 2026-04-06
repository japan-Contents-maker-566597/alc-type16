$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Repair-ResultPage($FilePath, $IsEn) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($FilePath)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        $FileName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath).ToUpper()
        
        # Mapping for Type Names
        $TypeNames = @{
            "LOUT"="アル中番長"; "LOUY"="ハイテンション時限爆弾"; "LODT"="飲み参謀"; "LODY"="爆発インキャ";
            "LRUT"="自称プロ幹事"; "LRUY"="ちゃんとした人"; "LRDT"="朝までうんちく先輩"; "LRDY"="水泥棒";
            "FOUT"="酒飲み聖母"; "FOUY"="情熱のたぎりモンスター"; "FODT"="飲み飲みカウンセラー"; "FODY"="涙腺崩壊ベビー";
            "FRUT"="酔いどれ学級委員長"; "FRUY"="飲んだふり常習犯"; "FRDT"="お会計くん"; "FRDY"="空気読みすぎ天使"
        }
        $TypeName = if ($TypeNames.ContainsKey($FileName)) { $TypeNames[$FileName] } else { $FileName }
        
        $ShareText = if ($IsEn) { "[Official] Sake Quiz Result: $FileName" } else { "【公式】酒タイプ診断の結果は…「$TypeName ($FileName)」でした！" }
        $Url = "https://sync-loft.com/alctype16/$((if($IsEn){'en/types'}else{'types'}))/$($FileName.ToLower()).html"
        
        $ShareTitle = if ($IsEn) { "Share your result!" } else { "&#35386;&#26029;&#32080;&#26524;&#12434;&#12471;&#12455;&#12450;&#12375;&#12424;&#12358;&#65281;" }
        $RediagText = if ($IsEn) { "Diagnose Again" } else { "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;" }
        $BackText = if ($IsEn) { "Back to TOP" } else { "TOP&#12506;&#12540;&#12472;&#12395;&#25147;&#12427;" }
        
        # 1. Strip everything after the last result card or corrupted area
        $Content = $Content -replace '(?s)<div style="text-align:\s*center;\s*margin:\s*20px\s*auto;">.*', ''
        $Content = $Content -replace '(?s)<div class="share-section">.*', ''
        $Content = $Content -replace '(?s)  <!-- LINE stamp floating banner -->.*', ''
        $Content = $Content.Replace("</body>", "").Replace("</html>", "").Trim()
        
        # 2. Append standard footer
        $Footer = @"

        <div class="share-section">
            <p class="share-title">$ShareTitle</p>
            <a href="https://twitter.com/intent/tweet?text=$ShareText&url=$Url" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
            </a>
        </div>
        <a href="../index.html" class="rediagnosis-button">$RediagText</a>
        <div class="bottom-nav-wrapper">
            <a href="../index.html" class="bottom-nav-button primary">$BackText</a>
        </div>
    </div>
    
  <!-- LINE stamp floating banner -->
  <a id="line-stamp-fab"
     href="https://store.line.me/stickershop/product/33138149/ja?utm_source=gnsh_stickerDetail"
     target="_blank" rel="noopener"
     onclick="typeof gtag==='function'&&gtag('event','line_stamp_click',{event_category:'engagement',event_label:'floating_banner'})">
      <span class="fab-badge">NEW</span>
      <div class="fab-inner">
          <span class="fab-icon">&#127867;</span>
          <span class="fab-label-main">LINEスタンプ<br>発売中！</span>
      </div>
  </a>

</body>
</html>
"@
        $NewContent = $Content + $Footer
        
        [System.IO.File]::WriteAllText($FilePath, $NewContent, $Utf8NoBom)
        Write-Host "Repaired: $($FilePath)"
    } catch {
        Write-Host "Error: $($FilePath) - $($_.Exception.Message)"
    }
}

# --- Batch Execution ---
$Types = Get-ChildItem -Path (Join-Path $BaseDir "types") -Filter "*.html"
foreach ($T in $Types) { Repair-ResultPage $T.FullName $false }

$EnTypes = Get-ChildItem -Path (Join-Path $BaseDir "en\types") -Filter "*.html"
foreach ($T in $EnTypes) { Repair-ResultPage $T.FullName $true }

Write-Host "Full Result Repair Operation Complete."
