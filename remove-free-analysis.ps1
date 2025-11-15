# Script to remove Free Analysis button from navigation

$files = @(
    "pricing.html",
    "contact.html",
    "faq.html",
    "ai seo.html",
    "blog.html",
    "projects.html",
    "single-projects.html",
    "single-blog.html",
    "services.html",
    "seo sri lanka.html"
)

foreach ($fileName in $files) {
    if (Test-Path $fileName) {
        $content = Get-Content $fileName -Raw -Encoding UTF8
        
        # Remove the Free Analysis button div
        $content = $content -replace '(?s)\s*<div class="others-options[^>]*>\s*<a[^>]*>\s*Free Analysis\s*</a>\s*</div>', ''
        
        [System.IO.File]::WriteAllText($fileName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Removed Free Analysis button from: $fileName" -ForegroundColor Green
    }
}

Write-Host "`nFree Analysis button removed from all pages!" -ForegroundColor Cyan
