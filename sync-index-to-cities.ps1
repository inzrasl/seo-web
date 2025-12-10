$cities = @(
    "Colombo|colombo",
    "Sri Jayawardenepura Kotte|sri-jayawardenepura-kotte",
    "Dehiwala Mount Lavinia|dehiwala-mount-lavinia",
    "Moratuwa|moratuwa",
    "Negombo|negombo",
    "Gampaha|gampaha",
    "Kalutara|kalutara",
    "Kandy|kandy",
    "Matale|matale",
    "Nuwara Eliya|nuwara-eliya",
    "Galle|galle",
    "Matara|matara",
    "Hambantota|hambantota",
    "Tangalle|tangalle",
    "Jaffna|jaffna",
    "Kilinochchi|kilinochchi",
    "Mannar|mannar",
    "Vavuniya|vavuniya",
    "Mullaitivu|mullaitivu",
    "Trincomalee|trincomalee",
    "Batticaloa|batticaloa",
    "Ampara|ampara",
    "Kalmunai|kalmunai",
    "Kurunegala|kurunegala",
    "Puttalam|puttalam",
    "Chilaw|chilaw",
    "Anuradhapura|anuradhapura",
    "Polonnaruwa|polonnaruwa",
    "Badulla|badulla",
    "Bandarawela|bandarawela",
    "Monaragala|monaragala",
    "Ratnapura|ratnapura",
    "Kegalle|kegalle"
)

$baseDir = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"

# Read index.html as base template
$indexTemplate = Get-Content "$baseDir\index.html" -Raw

foreach ($city in $cities) {
    $parts = $city -split '\|'
    $cityName = $parts[0]
    $slug = $parts[1]
    
    $filename = "seo-consultant-$slug.html"
    
    # Create location-specific content
    $content = $indexTemplate
    
    # Replace title
    $content = $content -replace "SEO Consultant in Sri Lanka \| No.1 SEO Service Provider", "SEO Consultant in $cityName | Best SEO Services"
    
    # Replace description
    $content = $content -replace "Looking for the best SEO Consultant in Sri Lanka\?.*?Get professional SEO services in Sri Lanka today\.", "Professional SEO Consultant in $cityName offering white-hat SEO services, technical optimization, and guaranteed Google rankings in $cityName."
    
    # Replace keywords - add location to keywords
    $content = $content -replace "SEO Consultant in Sri Lanka, SEO Consultant Sri Lanka, SEO Services Sri Lanka, Best SEO Consultant, SEO Expert Sri Lanka, Digital Marketing Sri Lanka", "SEO Consultant $cityName, SEO Services $cityName, Best SEO Consultant $cityName, SEO Expert $cityName, Digital Marketing $cityName"
    
    # Replace canonical URL
    $content = $content -replace '<link rel="canonical" href="https://seoconsultantsrilanka.com/" />', "<link rel=""canonical"" href=""https://seoconsultantsrilanka.com/seo-consultant-$slug.html"" />"
    
    # Replace OG tags
    $content = $content -replace 'content="https://seoconsultantsrilanka.com/"', "content=""https://seoconsultantsrilanka.com/seo-consultant-$slug.html"""
    
    # Replace hero title with location
    $content = $content -replace '<h1[^>]*>.*?Best SEO Consultant in Sri Lanka.*?</h1>', "<h1 class=""hero-title"">SEO Consultant in $cityName</h1>"
    
    # Write file
    [System.IO.File]::WriteAllText("$baseDir\$filename", $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated: $filename"
}

Write-Host "All city pages have been updated with index.html structure!"
