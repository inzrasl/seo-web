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

$sitemapPath = "c:\Users\inzra\OneDrive\Documents\GitHub\seo\sitemap.xml"

[xml]$sitemap = Get-Content $sitemapPath

foreach ($city in $cities) {
    $parts = $city -split '\|'
    $cityName = $parts[0]
    $slug = $parts[1]
    
    $url = $sitemap.CreateElement("url")
    
    $loc = $sitemap.CreateElement("loc")
    $loc.InnerText = "https://seoconsultantsrilanka.com/seo-consultant-$slug.html"
    $url.AppendChild($loc)
    
    $lastmod = $sitemap.CreateElement("lastmod")
    $lastmod.InnerText = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
    $url.AppendChild($lastmod)
    
    $priority = $sitemap.CreateElement("priority")
    $priority.InnerText = "0.80"
    $url.AppendChild($priority)
    
    $sitemap.urlset.AppendChild($url)
}

$sitemap.Save($sitemapPath)

Write-Host "Sitemap updated with 33 new city pages!"
