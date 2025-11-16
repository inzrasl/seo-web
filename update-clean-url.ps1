# Replace url-redirect.js with clean-url.js in all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File | Where-Object { $_.Name -notlike "*component*" }

Write-Host "Updating script references in HTML files..." -ForegroundColor Cyan

$filesUpdated = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # Replace url-redirect.js with clean-url.js
    if ($content -match 'url-redirect\.js') {
        $content = $content -replace 'url-redirect\.js', 'clean-url.js'
        $modified = $true
    }
    # Add clean-url.js if not present
    elseif ($content -notmatch 'clean-url\.js' -and $content -match '<head[^>]*>') {
        $content = $content -replace '(<head[^>]*>)', "`$1`n    <script src=`"assets/js/clean-url.js`"></script>"
        $modified = $true
    }
    
    if ($modified) {
        # Save with UTF-8 encoding without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        
        $filesUpdated++
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "Skipped: $($file.Name) (already correct)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Complete! Updated $filesUpdated files" -ForegroundColor Cyan
