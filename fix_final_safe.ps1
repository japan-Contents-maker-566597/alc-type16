$BaseDir = 'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# "もう一度診断する" in HTML Entities (ASCII-safe)
$CorrectEntity = "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;"

function Fix-File-Safe($File) {
    try {
        $RawBytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($RawBytes)
        
        # We search for the pattern of the button with ANY text inside and replace it with the correct entity version
        $Pattern = '<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>'
        $NewBtn = "<a href=""../index.html"" class=""rediagnosis-button"">$CorrectEntity</a>"
        
        if ($Content -match $Pattern) {
            $Content = [regex]::Replace($Content, $Pattern, $NewBtn, [System.Text.RegularExpressions.RegexOptions]::Singleline)
            [System.IO.File]::WriteAllText($File.FullName, $Content, $Utf8NoBom)
            Write-Host "Fixed: $($File.Name)"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) { Fix-File-Safe $File }
