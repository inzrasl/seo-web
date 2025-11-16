# Website Speed Optimization Script
# This script optimizes all HTML files for faster page load times

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -File

foreach ($file in $htmlFiles) {
    Write-Host "Optimizing: $($file.Name)" -ForegroundColor Cyan
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Remove obsolete clean-url.js reference
    $content = $content -replace '<script src="assets/js/clean-url\.js"></script>\s*\r?\n', ''
    
    # 2. Add preconnect for faster DNS resolution (add after charset meta tag)
    if ($content -notmatch '<link rel="preconnect"') {
        $content = $content -replace '(<meta charset="utf-8">)', "`$1`r`n        <!-- Preconnect for performance -->`r`n        <link rel=`"dns-prefetch`" href=`"//fonts.googleapis.com`">"
    }
    
    # 3. Defer non-critical JavaScript (keep jQuery and bootstrap first, defer others)
    # Add defer to all scripts except jQuery, bootstrap, and main.js
    $content = $content -replace '<script src="assets/js/(jquery\.meanmenu|jquery\.appear\.min|odometer\.min|owl\.carousel\.min|jquery\.magnific-popup\.min|jquery\.nice-select\.min|wow\.min|form-validator\.min|jquery\.ajaxchimp\.min|contact-form-script|particles\.min|progressbar\.min|parallax\.min)\.js"></script>', '<script src="assets/js/$1.js" defer></script>'
    
    # 4. Add loading="lazy" to all img tags that don't already have it
    $content = $content -replace '<img\s+(?![^>]*loading=)([^>]*)>', '<img loading="lazy" $1>'
    
    # 5. Add fetchpriority="high" to logo and hero images
    $content = $content -replace '<img\s+([^>]*class="brand-logo"[^>]*)loading="lazy"', '<img $1fetchpriority="high"'
    $content = $content -replace '<img\s+loading="lazy"\s+([^>]*class="brand-logo"[^>]*)', '<img fetchpriority="high" $1'
    
    # 6. Optimize CSS loading - add media="print" onload trick for non-critical CSS
    $content = $content -replace '<link rel="stylesheet" href="assets/css/(animate\.min|flaticon|flaticon-two|flaticon-three|magnific-popup\.min|owl\.carousel\.min)\.css">', '<link rel="stylesheet" href="assets/css/$1.css" media="print" onload="this.media=''all''">'
    
    # Save the optimized content
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
    
    Write-Host "  OK Completed" -ForegroundColor Green
}

Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "Speed Optimization Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "`nOptimizations applied:" -ForegroundColor White
Write-Host "- Removed obsolete clean-url.js references" -ForegroundColor Green
Write-Host "- Added DNS prefetch for external resources" -ForegroundColor Green
Write-Host "- Deferred non-critical JavaScript" -ForegroundColor Green
Write-Host "- Added lazy loading to images" -ForegroundColor Green
Write-Host "- Prioritized logo/hero images" -ForegroundColor Green
Write-Host "- Optimized CSS loading" -ForegroundColor Green
Write-Host "`nExpected improvements:" -ForegroundColor Cyan
Write-Host "- Faster initial page load (FCP)" -ForegroundColor White
Write-Host "- Reduced blocking resources" -ForegroundColor White
Write-Host "- Better Lighthouse scores" -ForegroundColor White
Write-Host "- Improved Time to Interactive (TTI)" -ForegroundColor White
