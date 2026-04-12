$namespaces = @{ w = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main' }
$doc1 = Select-Xml -Path '参考\doc1\word\document.xml' -XPath '//w:t' -Namespace $namespaces
($doc1.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath '参考\大学生タイプ診断説明.txt' -Encoding utf8

$doc2 = Select-Xml -Path '参考\doc2\word\document.xml' -XPath '//w:t' -Namespace $namespaces
($doc2.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath '参考\診断結果.txt' -Encoding utf8

$xlsNamespaces = @{ main = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main' }
$xls1 = Select-Xml -Path '参考\xls1\xl\sharedStrings.xml' -XPath '//main:t' -Namespace $xlsNamespaces
($xls1.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath '参考\大学生タイプ診断_質問_strings.txt' -Encoding utf8
