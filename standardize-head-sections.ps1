# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" | Where-Object { $_.Name -ne "navbar-component.html" }

Write-Host "Checking CSS links in all HTML files..." -ForegroundColor Cyan

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Check if style.css, dark.css, and responsive.css are present
    $hasStyle = $content -match '<link rel="stylesheet" href="assets/css/style\.css">'
    $hasDark = $content -match '<link rel="stylesheet" href="assets/css/dark\.css">'
    $hasResponsive = $content -match '<link rel="stylesheet" href="assets/css/responsive\.css">'
    
    if (-not $hasStyle -or -not $hasDark -or -not $hasResponsive) {
        Write-Host "Missing CSS in: $($file.Name)" -ForegroundColor Yellow
        Write-Host "  Style.css: $hasStyle | Dark.css: $hasDark | Responsive.css: $hasResponsive"
    } else {
        Write-Host "OK: $($file.Name)" -ForegroundColor Green
    }
}
