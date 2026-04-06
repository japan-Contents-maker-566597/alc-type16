$BaseDir = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"

function Add-Rediagnosis-Button($File) {
    $Content = [System.IO.File]::ReadAllText($File.FullName, [System.Text.Encoding]::UTF8)
    
    # Check if results type page
    if ($File.FullName -match "\\types\\" -and $File.Name -ne "list.html") {
        $IsEn = $File.FullName -match "\\en\\"
        $Text = if ($IsEn) { "Diagnose Again" } else { "もう一度診断する" }
        $ButtonHtml = "<a href=`"../index.html`" class=`"rediagnosis-button`">$Text</a>"
        
        # Avoid duplicate
        if ($Content -notmatch 'class="rediagnosis-button"') {
            $Content = $Content.Replace('<div class="bottom-nav-wrapper">', "$ButtonHtml`n        <div class=" + '"bottom-nav-wrapper">')
        }
    }
    
    [System.IO.File]::WriteAllText($File.FullName, $Content, [System.Text.Encoding]::UTF8)
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Add-Rediagnosis-Button $File }
Write-Host "Rediagnosis Button Added."
