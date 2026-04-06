$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$FooterJp = Get-Content 'c:\Users\01051992\Desktop\NEWalctype16\footer_jp.txt' -Raw
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$TypeNames = @{
    "LOUT"="アル中番長"; "LOUY"="ハイテンション時限爆弾"; "LODT"="飲み参謀"; "LODY"="爆発インキャ";
    "LRUT"="自称プロ幹事"; "LRUY"="ちゃんとした人"; "LRDT"="朝までうんちく先輩"; "LRDY"="水泥棒";
    "FOUT"="酒飲み聖母"; "FOUY"="情熱のたぎりモンスター"; "FODT"="飲み飲みカウンセラー"; "FODY"="涙腺崩壊ベビー";
    "FRUT"="酔いど学級委員長"; "FRUY"="飲んだふり常習犯"; "FRDT"="お会計くん"; "FRDY"="空気読みすぎ天使"
}

$JpFiles = Get-ChildItem -Path (Join-Path $BaseDir "types") -Filter "*.html"
foreach ($F in $JpFiles) {
    $Name = $F.BaseName.ToUpper()
    $Content = [System.IO.File]::ReadAllText($F.FullName)
    
    # Only fix if </body> is missing or buttons missing
    if (($Content -notmatch "</body>") -or ($Content -notmatch "share-section")) {
        Write-Host "Repairing JP: $($F.Name)"
        
        # Strip corrupted tail
        $Content = $Content -replace '(?s)<div style="text-align:\s*center;\s*margin:\s*20px\s*auto;">.*', ''
        $Content = $Content -replace '(?s)<div class="share-section">.*', ''
        $Content = $Content -replace '(?s)  <!-- LINE stamp floating banner -->.*', ''
        $Content = $Content.Replace("</body>", "").Replace("</html>", "").Trim()
        
        # Prepare customized footer
        $TypeName = if ($TypeNames.ContainsKey($Name)) { $TypeNames[$Name] } else { $Name }
        $CustomFooter = $FooterJp.Replace("[TYPE_NAME]", "$TypeName ($Name)").Replace("[TYPE_CODE]", $Name.ToLower())
        
        [System.IO.File]::WriteAllText($F.FullName, $Content + $CustomFooter, $Utf8NoBom)
    }
}
Write-Host "Batch Repair Complete."
