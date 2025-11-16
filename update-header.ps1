# Re-inject updated header component
$component = Get-Content "header-component.html" -Raw
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File | Where-Object { $_.Name -notlike "*component*" }

Write-Host "Updating header in all HTML files..." -ForegroundColor Cyan

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace header component (between opening <header and closing </header>)
    if ($content -match '(?s)<header[^>]*>.*?</header>') {
        $content = $content -replace '(?s)<header[^>]*>.*?</header>', $component.Trim()
        
        # Save with UTF-8 encoding without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Header update complete!" -ForegroundColor Cyan
