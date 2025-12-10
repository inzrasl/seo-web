# Generate location pages for Sri Lankan cities
# This script creates city-specific SEO pages with proper geo-targeting

$cities = @(
    "Colombo|Western Province|colombo|6.9271|80.6369|LK-WP",
    "Sri Jayawardenepura Kotte|Western Province|sri-jayawardenepura-kotte|6.8879|80.7744|LK-WP",
    "Dehiwala Mount Lavinia|Western Province|dehiwala-mount-lavinia|6.8310|80.7743|LK-WP",
    "Moratuwa|Western Province|moratuwa|6.8089|80.7933|LK-WP",
    "Negombo|Western Province|negombo|7.2064|79.8581|LK-WP",
    "Gampaha|Western Province|gampaha|7.0920|80.1342|LK-WP",
    "Kalutara|Western Province|kalutara|6.5882|80.0729|LK-WP",
    "Kandy|Central Province|kandy|7.2906|80.6337|LK-CP",
    "Matale|Central Province|matale|7.7731|80.7306|LK-CP",
    "Nuwara Eliya|Central Province|nuwara-eliya|6.9497|80.7725|LK-CP",
    "Galle|Southern Province|galle|6.0535|80.2162|LK-SP",
    "Matara|Southern Province|matara|5.7800|80.5489|LK-SP",
    "Hambantota|Southern Province|hambantota|6.1236|81.1177|LK-SP",
    "Tangalle|Southern Province|tangalle|5.9146|80.8131|LK-SP",
    "Jaffna|Northern Province|jaffna|9.6615|80.0255|LK-NP",
    "Kilinochchi|Northern Province|kilinochchi|9.3842|80.4162|LK-NP",
    "Mannar|Northern Province|mannar|8.9667|79.9167|LK-NP",
    "Vavuniya|Northern Province|vavuniya|8.7542|80.8006|LK-NP",
    "Mullaitivu|Northern Province|mullaitivu|8.6833|81.3500|LK-NP",
    "Trincomalee|Eastern Province|trincomalee|8.5874|81.2359|LK-EP",
    "Batticaloa|Eastern Province|batticaloa|7.7131|81.7046|LK-EP",
    "Ampara|Eastern Province|ampara|7.2972|81.6831|LK-EP",
    "Kalmunai|Eastern Province|kalmunai|7.4065|81.8238|LK-EP",
    "Kurunegala|North Western Province|kurunegala|7.4833|80.6333|LK-NWP",
    "Puttalam|North Western Province|puttalam|8.0279|79.8279|LK-NWP",
    "Chilaw|North Western Province|chilaw|7.5644|79.7928|LK-NWP",
    "Anuradhapura|North Central Province|anuradhapura|8.3381|80.4050|LK-NCP",
    "Polonnaruwa|North Central Province|polonnaruwa|7.9381|80.9763|LK-NCP",
    "Badulla|Uva Province|badulla|6.9936|81.2708|LK-UP",
    "Bandarawela|Uva Province|bandarawela|6.8308|81.0564|LK-UP",
    "Monaragala|Uva Province|monaragala|6.8219|81.3472|LK-UP",
    "Ratnapura|Sabaragamuwa Province|ratnapura|6.6995|80.3918|LK-SAB",
    "Kegalle|Sabaragamuwa Province|kegalle|7.2558|80.6415|LK-SAB"
)

$baseDir = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"
$count = 0

Write-Host "Generating location pages..." -ForegroundColor Green

foreach ($cityData in $cities) {
    $parts = $cityData -split '\|'
    $cityName = $parts[0]
    $province = $parts[1]
    $slug = $parts[2]
    $lat = $parts[3]
    $lon = $parts[4]
    $region = $parts[5]
    
    $filename = "seo-consultant-$slug.html"
    $filepath = Join-Path $baseDir $filename
    
    # Read the Colombo page as template
    $template = Get-Content "$baseDir\seo-consultant-colombo.html" -Raw
    
    # Replace with city-specific content
    $content = $template -replace "Colombo", $cityName
    $content = $content -replace "6.9271", $lat
    $content = $content -replace "80.6369", $lon
    $content = $content -replace "LK-WP", $region
    $content = $content -replace "colombo", $slug
    $content = $content -replace "Western Province", $province
    
    # Write file
    [System.IO.File]::WriteAllText($filepath, $content, [System.Text.Encoding]::UTF8)
    $count++
    Write-Host "✓ $filename"
}

Write-Host ""
Write-Host "Done creating pages!"
