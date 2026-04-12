$namespaces = @{ w = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main' }

$doc1Path = (Get-ChildItem -Path . -Recurse -Filter 'document.xml' | Where-Object { $_.FullName -match 'doc1' }).FullName
$doc1 = Select-Xml -Path $doc1Path -XPath '//w:t' -Namespace $namespaces
($doc1.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath 'doc1_texts.txt' -Encoding utf8

$doc2Path = (Get-ChildItem -Path . -Recurse -Filter 'document.xml' | Where-Object { $_.FullName -match 'doc2' }).FullName
$doc2 = Select-Xml -Path $doc2Path -XPath '//w:t' -Namespace $namespaces
($doc2.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath 'doc2_texts.txt' -Encoding utf8

$xlsNamespaces = @{ main = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main' }
$xlsPath = (Get-ChildItem -Path . -Recurse -Filter 'sharedStrings.xml' | Where-Object { $_.FullName -match 'xls1' }).FullName
$xls1 = Select-Xml -Path $xlsPath -XPath '//main:t' -Namespace $xlsNamespaces
($xls1.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath 'xls1_texts.txt' -Encoding utf8

$sheetPaths = Get-ChildItem -Path . -Recurse -Filter 'sheet1.xml' | Where-Object { $_.FullName -match 'xls1' }
foreach ($path in $sheetPaths) {
    if ($path) {
        $sheetXml = Select-Xml -Path $path.FullName -XPath '//main:v' -Namespace $xlsNamespaces
        ($sheetXml.Node | Select-Object -ExpandProperty '#text') -join "`n" | Out-File -FilePath 'xls1_values.txt' -Encoding utf8
    }
}
