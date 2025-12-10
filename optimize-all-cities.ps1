#!/usr/bin/env powershell
# Optimize location-specific content for all 33 city pages

$cities = @(
    "colombo", "kandy", "galle", "jaffna", "trincomalee", 
    "kurunegala", "anuradhapura", "badulla", "ratnapura", 
    "sri-jayawardenepura-kotte", "matale", "nuwara-eliya", 
    "matara", "hambantota", "tangalle", "kilinochchi", 
    "mannar", "vavuniya", "mullaitivu", "batticaloa", 
    "ampara", "kalmunai", "puttalam", "chilaw", 
    "polonnaruwa", "bandarawela", "monaragala", "kegalle"
)

$basePath = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"

foreach ($city in $cities) {
    $file = "$basePath\seo-consultant-$city.html"
    
    if (Test-Path $file) {
        Write-Host "Processing $city..." -ForegroundColor Green
        
        # Read file
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # Convert city slug to proper name
        $cityName = $city -replace "-", " "
        $cityName = (Get-Culture).TextInfo.ToTitleCase($cityName)
        
        # Replace generic Sri Lanka references with city name
        $content = $content -replace "SEO Consultant in Sri Lanka", "SEO Consultant in $cityName"
        $content = $content -replace "SEO Consultant Sri Lanka", "SEO Consultant $cityName"
        
        # Save file
        Set-Content $file -Value $content -Encoding UTF8
    }
    else {
        Write-Host "⚠ Missing: $file" -ForegroundColor Yellow
    }
}

Write-Host "`nDone!" -ForegroundColor Green
