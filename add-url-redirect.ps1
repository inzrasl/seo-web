# Add URL redirect script to all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File | Where-Object { $_.Name -notlike "*component*" }

$scriptTag = '<script src="assets/js/url-redirect.js"></script>'

Write-Host "Adding URL redirect script to HTML files..." -ForegroundColor Cyan

$filesUpdated = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check if script is already added
    if ($content -notmatch 'url-redirect\.js') {
        # Add script right after <head> tag
        $content = $content -replace '(<head[^>]*>)', "`$1`n    $scriptTag"
        
        # Save with UTF-8 encoding without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        
        $filesUpdated++
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "Skipped: $($file.Name) (already has script)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Complete! Updated $filesUpdated files" -ForegroundColor Cyan
