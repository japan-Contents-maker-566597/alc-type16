$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false
$file = Get-ChildItem -Path ".\*\*.xlsx" | Select-Object -First 1
Write-Host "Opening $($file.FullName)"
$workbook = $excel.Workbooks.Open($file.FullName)
$csvPath = Join-Path $pwd "logic.csv"
$workbook.SaveAs($csvPath, 6)
$workbook.Close($false)
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
