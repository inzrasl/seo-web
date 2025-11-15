# PowerShell script to update navigation menus across all HTML files

$newNavMenu = @'
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a href="index.html" class="nav-link">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a href="about.html" class="nav-link">About</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">
                                        Services 
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li class="nav-item">
                                            <a href="services.html" class="nav-link">Service</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="single-services.html" class="nav-link">Service Details</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="blog.html" class="nav-link">Blog</a>
                                </li>
                                <li class="nav-item">
                                    <a href="contact.html" class="nav-link">Contact</a>
                                </li>
                            </ul>
'@

# Files to process (excluding already processed ones and files without these menus)
$files = @(
    "blog.html",
    "pricing.html",
    "services.html",
    "projects.html",
    "single-blog.html",
    "single-projects.html",
    "seo specialist sri lanka.html",
    "seo expert in srilanka.html",
    "best seo company in sri lanka.html",
    "seo sri lanka.html",
    "ai seo.html",
    "what-is-seo.html",
    "what-does-seo-stand-for.html",
    "how-to-become-seo-specialist.html",
    "how-long-does-seo-take.html",
    "seo-sri-lanka.html",
    "seo-service-sri-lanka.html",
    "seo-agency-sri-lanka.html",
    "seo-price-in-sri-lanka.html",
    "seo-specialist-sri-lanka.html",
    "seo-specialist-guide-sri-lanka.html",
    "seo-expert-sri-lanka.html",
    "best-seo-company-sri-lanka.html",
    "ai-seo.html"
)

$processed = 0
$skipped = 0

foreach ($file in $files) {
    $filePath = Join-Path $PSScriptRoot $file
    
    if (-not (Test-Path $filePath)) {
        Write-Host "File not found: $file" -ForegroundColor Yellow
        $skipped++
        continue
    }
    
    try {
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        # Check if file has the old navigation structure (Projects menu)
        if ($content -match 'Projects\s*<i class="fa fa-angle-down">') {
            # Pattern to match the entire navbar-nav section with all dropdown menus
            $pattern = '(?s)<ul class="navbar-nav">.*?</ul>\s*\n\s*\n\s*<div class="others-options'
            
            if ($content -match $pattern) {
                $replacement = $newNavMenu + "`n`n                            <div class=`"others-options"
                $content = $content -replace $pattern, $replacement
                
                # Save the file
                $content | Out-File -FilePath $filePath -Encoding UTF8 -NoNewline
                Write-Host "✓ Processed: $file" -ForegroundColor Green
                $processed++
            } else {
                Write-Host "× Pattern not matched in: $file" -ForegroundColor Red
                $skipped++
            }
        } else {
            Write-Host "- Already clean or different structure: $file" -ForegroundColor Cyan
            $skipped++
        }
    }
    catch {
        Write-Host "ERROR processing $file : $_" -ForegroundColor Red
        $skipped++
    }
}

Write-Host "`n========================================" -ForegroundColor White
Write-Host "Summary:" -ForegroundColor White
Write-Host "Processed: $processed files" -ForegroundColor Green
Write-Host "Skipped: $skipped files" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor White
