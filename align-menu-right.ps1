# Script to align menu to right and remove extra elements

$files = Get-ChildItem -Path . -Filter "*.html" -File | Where-Object { $_.Name -ne "index.html" }

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Add ml-auto class to navbar-nav for right alignment
    $content = $content -replace '<ul class="navbar-nav">', '<ul class="navbar-nav ml-auto">'
    
    # Remove language selector and other options divs
    $content = $content -replace '(?s)\s*<div class="others-options[^>]*>.*?</div>\s*</div>\s*(?=</div>\s*</nav>)', ''
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated: $($file.Name)" -ForegroundColor Green
}

Write-Host "`nMenu aligned to right and extra elements removed!" -ForegroundColor Cyan
