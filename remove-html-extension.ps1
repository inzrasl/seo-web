# Script to remove .html extensions from all internal links
# Pattern list of all HTML pages (without extension)
$pageNames = @(
    "about", "services", "pricing", "faq", "blog", "contact",
    "ai-seo", "what-is-seo", "what-does-seo-stand-for",
    "best-seo-company-sri-lanka", "seo-sri-lanka", "seo-specialist-sri-lanka",
    "seo-specialist-guide-sri-lanka", "seo-service-sri-lanka", "seo-price-in-sri-lanka",
    "seo-expert-sri-lanka", "seo-agency-sri-lanka", "how-long-does-seo-take",
    "how-to-become-seo-specialist", "single-blog"
)

$htmlFiles = Get-ChildItem -Path "c:\Users\inzra\OneDrive\Documents\GitHub\seo" -Filter "*.html" | Where-Object { $_.Name -ne "header-component.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    # Read file content using UTF8 encoding
    [string]$content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $originalContent = $content
    
    # Replace each page name with .html to without .html
    foreach ($pageName in $pageNames) {
        $pattern = "href=`"$pageName\.html`""
        $replacement = "href=`"$pageName`""
        $content = $content -replace $pattern, $replacement
    }
    
    # Write back if changed
    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "  Updated"
    } else {
        Write-Host "  No changes"
    }
}

Write-Host "Done!"
