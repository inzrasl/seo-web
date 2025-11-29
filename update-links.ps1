$htmlFiles = Get-ChildItem -Path "c:\Users\inzra\OneDrive\Documents\GitHub\seo\" -Filter "*.html" -Exclude "*.backup", "*.navremoved.backup"

$replacements = @{
  'href="about"' = 'href="about.html"'
  'href="services"' = 'href="services.html"'
  'href="pricing"' = 'href="pricing.html"'
  'href="blog"' = 'href="blog.html"'
  'href="contact"' = 'href="contact.html"'
  'href="faq"' = 'href="faq.html"'
  'href="ai-seo"' = 'href="ai-seo.html"'
  'href="seo-sri-lanka"' = 'href="seo-sri-lanka.html"'
  'href="how-long-does-seo-take"' = 'href="how-long-does-seo-take.html"'
  'href="how-to-become-seo-specialist"' = 'href="how-to-become-seo-specialist.html"'
  'href="what-is-seo"' = 'href="what-is-seo.html"'
  'href="what-does-seo-stand-for"' = 'href="what-does-seo-stand-for.html"'
  'href="best-seo-company-sri-lanka"' = 'href="best-seo-company-sri-lanka.html"'
  'href="seo-expert-sri-lanka"' = 'href="seo-expert-sri-lanka.html"'
  'href="seo-specialist-sri-lanka"' = 'href="seo-specialist-sri-lanka.html"'
  'href="seo-agency-sri-lanka"' = 'href="seo-agency-sri-lanka.html"'
  'href="seo-price-in-sri-lanka"' = 'href="seo-price-in-sri-lanka.html"'
  'href="seo-service-sri-lanka"' = 'href="seo-service-sri-lanka.html"'
  'href="seo-specialist-guide-sri-lanka"' = 'href="seo-specialist-guide-sri-lanka.html"'
  'href="single-blog"' = 'href="single-blog.html"'
}

foreach($file in $htmlFiles) {
  Write-Host "Processing: $($file.Name)"
  $content = Get-Content -Path $file.FullName -Raw
  
  foreach($old in $replacements.Keys) {
    $new = $replacements[$old]
    $content = $content -replace [regex]::Escape($old), $new
  }
  
  Set-Content -Path $file.FullName -Value $content -Encoding UTF8
  Write-Host "Updated: $($file.Name)"
}

Write-Host "All files updated successfully!"
