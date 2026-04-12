$doc1 = [xml](Get-Content "参考\doc1\word\document.xml" -Raw -Encoding UTF8)
$doc1Text = ($doc1.SelectNodes("//*[local-name()='t']") | ForEach-Object { $_.InnerText }) -join "`n"
$doc1Text | Out-File "参考\大学生タイプ診断説明.txt" -Encoding UTF8

$doc2 = [xml](Get-Content "参考\doc2\word\document.xml" -Raw -Encoding UTF8)
$doc2Text = ($doc2.SelectNodes("//*[local-name()='t']") | ForEach-Object { $_.InnerText }) -join "`n"
$doc2Text | Out-File "参考\診断結果.txt" -Encoding UTF8

$xls1Text = ""
if (Test-Path "参考\xls1\xl\sharedStrings.xml") {
    $xls1 = [xml](Get-Content "参考\xls1\xl\sharedStrings.xml" -Raw -Encoding UTF8)
    $xls1Text = ($xls1.SelectNodes("//*[local-name()='t']") | ForEach-Object { $_.InnerText }) -join "`n"
}
$xls1Text | Out-File "参考\大学生タイプ診断_質問_strings.txt" -Encoding UTF8
