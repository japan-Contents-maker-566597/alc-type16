# ============================================================
# AdSense移行スクリプト
# 1. 忍者AdMaxを全削除
# 2. 手動広告ユニットをゴールデンゾーンに挿入
# ============================================================

$root = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"

# 手動広告ユニット（<ins>+pushのみ：adsbygoogle.jsはheadに既存）
$adUnit = "<div class=""ad-unit"" style=""text-align:center;margin:28px auto;max-width:100%;overflow:hidden;"">" + [System.Environment]::NewLine
$adUnit += "<!-- Google AdSense -->" + [System.Environment]::NewLine
$adUnit += "<ins class=""adsbygoogle""" + [System.Environment]::NewLine
$adUnit += "     style=""display:block""" + [System.Environment]::NewLine
$adUnit += "     data-ad-client=""ca-pub-3644642136582562""" + [System.Environment]::NewLine
$adUnit += "     data-ad-slot=""1628377322""" + [System.Environment]::NewLine
$adUnit += "     data-ad-format=""auto""" + [System.Environment]::NewLine
$adUnit += "     data-full-width-responsive=""true""></ins>" + [System.Environment]::NewLine
$adUnit += "<script>" + [System.Environment]::NewLine
$adUnit += "     (adsbygoogle = window.adsbygoogle || []).push({});" + [System.Environment]::NewLine
$adUnit += "</script>" + [System.Environment]::NewLine
$adUnit += "<!-- /Google AdSense -->" + [System.Environment]::NewLine
$adUnit += "</div>"

$files = Get-ChildItem -Path $root -Filter "*.html" -Recurse

$count = 0
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content

    # パターンA: <div style="text-align:center;margin:20px auto;"> ... admax ... </div>
    $content = $content -replace '(?s)<div[^>]*style="text-align:\s*center;\s*margin:\s*20px\s*auto;?[^"]*"[^>]*>\s*<!--\s*admax\s*-->\s*<script\s+src="https://adm\.shinobi\.jp/s/[a-f0-9]+"[^>]*>\s*</script>\s*<!--\s*admax\s*-->\s*</div>', $adUnit

    # パターンB: <div class="...text-center...mb-8..." style="min-height:250px;"> ... admax ... </div>
    $content = $content -replace '(?s)<div[^>]*min-height[^>]*>\s*<!--\s*admax\s*-->\s*<script\s+src="https://adm\.shinobi\.jp/s/[a-f0-9]+"[^>]*>\s*</script>\s*<!--\s*admax\s*-->\s*</div>', $adUnit

    # パターンC: <!-- admax --> ... </script> <!-- admax --> (コメント+スクリプトのみ)
    $content = $content -replace '(?s)<!--\s*admax\s*-->\s*<script\s+src="https://adm\.shinobi\.jp/s/[a-f0-9]+"[^>]*>\s*</script>\s*<!--\s*admax\s*-->', $adUnit

    # パターンD: 裸のAdMaxスクリプトが残っていれば削除
    $content = $content -replace '<script\s+src="https://adm\.shinobi\.jp/s/[a-f0-9]+"[^>]*>\s*</script>', ''

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $count++
    }
}

Write-Host ""
Write-Host "=== 完了: $count ファイルを更新しました ===" -ForegroundColor Cyan

# 残留チェック
Write-Host ""
Write-Host "--- AdMax残留チェック ---" -ForegroundColor Yellow
$remaining = Get-ChildItem -Path $root -Filter "*.html" -Recurse | 
    Select-String -Pattern "shinobi\.jp"

if ($remaining.Count -eq 0) {
    Write-Host "残留なし: 完全削除 OK" -ForegroundColor Green
} else {
    Write-Host "残留あり:" -ForegroundColor Red
    $remaining | ForEach-Object { Write-Host "  $($_.Filename) L$($_.LineNumber): $($_.Line.Trim())" }
}
