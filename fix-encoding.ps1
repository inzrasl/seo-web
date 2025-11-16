# Fix character encoding corruption (replacement character)
# Replaces corrupted character with proper en-dash

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File

Write-Host "Fixing encoding issues in HTML files..." -ForegroundColor Cyan
Write-Host "Total files to process: $($htmlFiles.Count)" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Replace corrupted character with proper en-dash
    $content = $content -replace [char]0xFFFD, [char]0x2013
    
    if ($content -ne $originalContent) {
        # Save with UTF-8 encoding without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        
        $replacements = ([regex]::Matches($originalContent, [char]0xFFFD)).Count
        $totalReplacements += $replacements
        
        Write-Host "Fixed $($file.Name) - $replacements replacements" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Encoding fix complete!" -ForegroundColor Green
Write-Host "Total replacements made: $totalReplacements" -ForegroundColor Cyan
