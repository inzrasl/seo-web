# Script to ADD .html extensions back to links (for local development)
# Use this if you want to test locally without Apache mod_rewrite

$pageNames = @(
    "about", "services", "pricing", "faq", "blog", "contact",
    "ai-seo", "what-is-seo", "what-does-seo-stand-for",
    "best-seo-company-sri-lanka", "seo-sri-lanka", "seo-specialist-sri-lanka",
    "seo-specialist-guide-sri-lanka", "seo-service-sri-lanka", "seo-price-in-sri-lanka",
    "seo-expert-sri-lanka", "seo-agency-sri-lanka", "how-long-does-seo-take",
    "how-to-become-seo-specialist", "single-blog"
)

$htmlFiles = Get-ChildItem -Path "c:\Users\inzra\OneDrive\Documents\GitHub\seo" -Filter "*.html" | Where-Object { $_.Name -ne "header-component.html" }

Write-Host "Adding .html extensions back..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    [string]$content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $originalContent = $content
    
    foreach ($pageName in $pageNames) {
        $pattern = "href=`"$pageName`"(?!\.)"
        $replacement = "href=`"$pageName.html`""
        $content = $content -replace $pattern, $replacement
    }
    
    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "  Reverted"
    }
}

Write-Host "Done!"
