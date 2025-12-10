# PowerShell Script to Optimize City-Specific SEO Content for All 33 Sri Lankan Cities
# This script generates unique, location-optimized content while maintaining consistent HTML structure

# Array of all 33 cities with location-specific data
$cities = @(
    @{Name = "Colombo"; File = "seo-consultant-colombo.html"; Region = "Western"; Province = "Western Province"; Lat = 6.9271; Lon = 80.6369; Industry = "commerce and finance"; Keywords = "seo consultant colombo"; Population = "Capital City"; Benefits = @("Access to major tech companies and digital agencies", "High concentration of businesses seeking online growth", "Leading metro hub for SEO expertise and digital marketing", "Strong demand for professional SEO services", "Easy access to multinational corporation headquarters") },
    @{Name = "Kandy"; File = "seo-consultant-kandy.html"; Region = "Central"; Province = "Central Province"; Lat = 7.2906; Lon = 80.6337; Industry = "tourism and heritage"; Keywords = "seo consultant kandy"; Population = "Cultural Capital"; Benefits = @("Dominant tourism sector requiring strong online presence", "Heritage industry growth driving digital demand", "Second-largest city with expanding business opportunities", "Tourism-focused businesses needing local SEO", "Cultural attractions requiring digital marketing expertise") },
    @{Name = "Galle"; File = "seo-consultant-galle.html"; Region = "Southern"; Province = "Southern Province"; Lat = 6.0535; Lon = 80.2210; Industry = "tourism and fishing"; Keywords = "seo consultant galle"; Population = "Historical Port City"; Benefits = @("Growing tourism sector with global reach", "Fishing industry modernization driving digital adoption", "Coastal business boom requiring online visibility", "Increasing foreign investment in local businesses", "Heritage fort attraction bringing tourism opportunities") },
    @{Name = "Jaffna"; File = "seo-consultant-jaffna.html"; Region = "Northern"; Province = "Northern Province"; Lat = 9.6615; Lon = 80.7855; Industry = "agriculture and commerce"; Keywords = "seo consultant jaffna"; Population = "Northern Hub"; Benefits = @("Growing agricultural sector needing market access", "Post-development business growth opportunities", "Emerging e-commerce opportunities in Northern region", "Increasing mobile and internet adoption", "Agricultural products gaining online export visibility") },
    @{Name = "Trincomalee"; File = "seo-consultant-trincomalee.html"; Region = "Eastern"; Province = "Eastern Province"; Lat = 8.5711; Lon = 81.2348; Industry = "port and tourism"; Keywords = "seo consultant trincomalee"; Population = "Strategic Port City"; Benefits = @("Major port operations driving shipping and logistics growth", "Emerging tourism destination with global appeal", "Business expansion opportunities in Eastern Province", "Port-related industries requiring online solutions", "Beach and heritage tourism creating service opportunities") },
    @{Name = "Kurunegala"; File = "seo-consultant-kurunegala.html"; Region = "North Western"; Province = "North Western Province"; Lat = 6.8271; Lon = 80.6355; Industry = "agriculture and commerce"; Keywords = "seo consultant kurunegala"; Population = "District Hub"; Benefits = @("Agricultural business growth with online marketing needs", "Rubber and coconut industry digitalization", "Rural to urban business transition", "Manufacturing sector expansion in NW Province", "District capital with growing digital awareness") },
    @{Name = "Anuradhapura"; File = "seo-consultant-anuradhapura.html"; Region = "North Central"; Province = "North Central Province"; Lat = 8.3163; Lon = 80.7355; Industry = "agriculture and heritage"; Keywords = "seo consultant anuradhapura"; Population = "Ancient Capital"; Benefits = @("Sacred city tourism driving accommodation and services", "Agricultural zone modernization and market expansion", "Heritage site management requiring online coordination", "Religious tourism creating business opportunities", "Ancient capital attracting heritage tourism investments") },
    @{Name = "Badulla"; File = "seo-consultant-badulla.html"; Region = "Uva"; Province = "Uva Province"; Lat = 6.9972; Lon = 81.0670; Industry = "tea and tourism"; Keywords = "seo consultant badulla"; Population = "Hill Country Hub"; Benefits = @("Tea plantation industry needing direct sales channels", "High-altitude tourism and adventure sports growth", "Gem mining operations expanding online", "Spice business modernization and export", "Hill station tourism attracting international visitors") },
    @{Name = "Ratnapura"; File = "seo-consultant-ratnapura.html"; Region = "Sabaragamuwa"; Province = "Sabaragamuwa Province"; Lat = 6.7271; Lon = 80.7919; Industry = "gemstones and rubber"; Keywords = "seo consultant ratnapura"; Population = "Gem City"; Benefits = @("World-renowned gemstone market requiring online exposure", "International gem traders seeking digital solutions", "Rubber plantation modernization and digital sales", "Mining operations needing supply chain management tools", "Global gem market access through SEO optimization") },
    @{Name = "Sri Jayawardenepura Kotte"; File = "seo-consultant-sri-jayawardenepura-kotte.html"; Region = "Western"; Province = "Western Province"; Lat = 6.8964; Lon = 80.7759; Industry = "government and administration"; Keywords = "seo consultant sri jayawardenepura kotte"; Population = "Administrative Capital"; Benefits = @("Government sector IT initiatives driving digital adoption", "Administrative hub attracting service businesses", "Close proximity to Colombo's tech ecosystem", "Growing government digitalization projects", "Administrative services modernization opportunities") },
    @{Name = "Matale"; File = "seo-consultant-matale.html"; Region = "Central"; Province = "Central Province"; Lat = 7.7674; Lon = 80.7854; Industry = "agriculture and spices"; Keywords = "seo consultant matale"; Population = "Spice District"; Benefits = @("Spice cultivation and processing industry growth", "Global spice export market requiring online visibility", "Agro-business modernization and direct sales", "Tourism for spice gardens and cultural experiences", "Agricultural products gaining e-commerce channels") },
    @{Name = "Nuwara Eliya"; File = "seo-consultant-nuwara-eliya.html"; Region = "Central"; Province = "Central Province"; Lat = 6.9497; Lon = 80.7891; Industry = "tourism and agriculture"; Keywords = "seo consultant nuwara eliya"; Population = "Hill Station"; Benefits = @("Premium tourism destination with international appeal", "High-altitude agricultural products (vegetables, tea)", "Resort and hospitality industry growth", "Tourist services requiring online booking systems", "Cool climate agriculture attracting investment") },
    @{Name = "Matara"; File = "seo-consultant-matara.html"; Region = "Southern"; Province = "Southern Province"; Lat = 5.9497; Lon = 80.5353; Industry = "tourism and fishing"; Keywords = "seo consultant matara"; Population = "Southern Beach Town"; Benefits = @("Coastal tourism and beach resort development", "Fishing industry modernization and export", "Surfing destination attracting international visitors", "Hospitality business requiring online booking", "Southern beach tourism hub with growth potential") },
    @{Name = "Hambantota"; File = "seo-consultant-hambantota.html"; Region = "Southern"; Province = "Southern Province"; Lat = 6.1236; Lon = 81.1241; Industry = "port and tourism"; Keywords = "seo consultant hambantota"; Population = "International Port City"; Benefits = @("Major international port development creating opportunities", "Port-related logistics and shipping growth", "Tourism potential with port city development", "Manufacturing and export zone growth", "Strategic location for South Asian commerce") },
    @{Name = "Tangalle"; File = "seo-consultant-tangalle.html"; Region = "Southern"; Province = "Southern Province"; Lat = 6.2247; Lon = 80.8092; Industry = "tourism and fishing"; Keywords = "seo consultant tangalle"; Population = "Coastal Town"; Benefits = @("Emerging tourism destination with pristine beaches", "Fishing industry modernization and sustainable practices", "Resort and accommodation sector growth", "Water sports and adventure tourism opportunities", "Remote coastal tourism attracting boutique business models") },
    @{Name = "Kilinochchi"; File = "seo-consultant-kilinochchi.html"; Region = "Northern"; Province = "Northern Province"; Lat = 9.2898; Lon = 80.4241; Industry = "agriculture and commerce"; Keywords = "seo consultant kilinochchi"; Population = "Northern District"; Benefits = @("Post-development agricultural modernization", "Business recovery and growth initiatives", "Digital access improving in Northern region", "Agricultural marketing and export opportunities", "Rural economic development through online channels") },
    @{Name = "Mannar"; File = "seo-consultant-mannar.html"; Region = "Northern"; Province = "Northern Province"; Lat = 8.9795; Lon = 80.1854; Industry = "fishing and agriculture"; Keywords = "seo consultant mannar"; Population = "Palk Strait Town"; Benefits = @("Fishing industry expansion and modernization", "Cross-strait trade opportunities", "Salt production modernization and export", "Agricultural produce market access", "Strategic location for regional commerce") },
    @{Name = "Vavuniya"; File = "seo-consultant-vavuniya.html"; Region = "Northern"; Province = "Northern Province"; Lat = 8.7530; Lon = 80.8247; Industry = "commerce and agriculture"; Keywords = "seo consultant vavuniya"; Population = "Junction Town"; Benefits = @("Road transport hub requiring logistics solutions", "Agricultural produce consolidation and export", "Post-development investment opportunities", "Trade gateway for Northern Province", "Business growth in central Northern location") },
    @{Name = "Mullaitivu"; File = "seo-consultant-mullaitivu.html"; Region = "Northern"; Province = "Northern Province"; Lat = 8.3059; Lon = 81.8993; Industry = "fishing and agriculture"; Keywords = "seo consultant mullaitivu"; Population = "Eastern Northern Town"; Benefits = @("Fishing industry modernization and export", "Lagoon-based aquaculture development", "Post-development business opportunities", "Agricultural growth in remote area", "Coastal resource management opportunities") },
    @{Name = "Batticaloa"; File = "seo-consultant-batticaloa.html"; Region = "Eastern"; Province = "Eastern Province"; Lat = 7.7102; Lon = 81.6924; Industry = "fishing and commerce"; Keywords = "seo consultant batticaloa"; Population = "Eastern Port Town"; Benefits = @("Fishing industry modernization and processing", "Lagoon-based economic development", "Tourism potential with coastal location", "Spice and agricultural trade", "Regional commerce hub for Eastern Province") },
    @{Name = "Ampara"; File = "seo-consultant-ampara.html"; Region = "Eastern"; Province = "Eastern Province"; Lat = 7.2947; Lon = 81.6771; Industry = "agriculture and tourism"; Keywords = "seo consultant ampara"; Population = "Eastern District"; Benefits = @("Emerging tourism destination with beaches", "Agricultural zone serving Eastern Province", "Post-development growth opportunities", "Business expansion in Eastern region", "Costal tourism development potential") },
    @{Name = "Kalmunai"; File = "seo-consultant-kalmunai.html"; Region = "Eastern"; Province = "Eastern Province"; Lat = 7.4174; Lon = 81.8241; Industry = "fishing and commerce"; Keywords = "seo consultant kalmunai"; Population = "Eastern Coastal Hub"; Benefits = @("Fishing community modernization and export", "Spice and coconut trade hub", "Post-development economic growth", "Coastal resource commercialization", "Regional business opportunities in Eastern zone") },
    @{Name = "Puttalam"; File = "seo-consultant-puttalam.html"; Region = "North Western"; Province = "North Western Province"; Lat = 8.0282; Lon = 79.8409; Industry = "salt and fishing"; Keywords = "seo consultant puttalam"; Population = "Salt Production Zone"; Benefits = @("Salt production modernization and export", "Fishing industry with lagoon resources", "Coastal tourism development potential", "Agricultural zone for NW Province", "Strategic lagoon-based economic opportunities") },
    @{Name = "Chilaw"; File = "seo-consultant-chilaw.html"; Region = "North Western"; Province = "North Western Province"; Lat = 7.5671; Lon = 79.7935; Industry = "fishing and agriculture"; Keywords = "seo consultant chilaw"; Population = "West Coast Town"; Benefits = @("Fishing community modernization and export", "Coconut and agricultural processing", "Beach tourism development potential", "Coral mining and sustainable practices", "Coastal commerce and trade hub") },
    @{Name = "Polonnaruwa"; File = "seo-consultant-polonnaruwa.html"; Region = "North Central"; Province = "North Central Province"; Lat = 7.9373; Lon = 81.0032; Industry = "heritage and agriculture"; Keywords = "seo consultant polonnaruwa"; Population = "Ancient Heritage City"; Benefits = @("Heritage tourism with ancient ruins and sites", "Agricultural modernization in NC Province", "Irrigation-based farming expansion", "Archaeological tourism creating opportunities", "Cultural heritage attracting international visitors") },
    @{Name = "Bandarawela"; File = "seo-consultant-bandarawela.html"; Region = "Uva"; Province = "Uva Province"; Lat = 6.8347; Lon = 81.0545; Industry = "tourism and agriculture"; Keywords = "seo consultant bandarawela"; Population = "Hill Town"; Benefits = @("Tea plantation tourism and direct sales", "High-altitude vegetable production", "Cool climate agriculture modernization", "Tourist resort and hospitality growth", "Hill station destination attracting visitors") },
    @{Name = "Monaragala"; File = "seo-consultant-monaragala.html"; Region = "Uva"; Province = "Uva Province"; Lat = 6.8155; Lon = 81.3521; Industry = "agriculture and forestry"; Keywords = "seo consultant monaragala"; Population = "Uva District"; Benefits = @("Agricultural produce modernization", "Forest product commercialization", "Rural economic development", "Agricultural export channel expansion", "Sustainable resource management business") },
    @{Name = "Kegalle"; File = "seo-consultant-kegalle.html"; Region = "Sabaragamuwa"; Province = "Sabaragamuwa Province"; Lat = 7.2618; Lon = 80.6545; Industry = "agriculture and rubber"; Keywords = "seo consultant kegalle"; Population = "Central Highland Town"; Benefits = @("Rubber plantation modernization and direct sales", "Coconut and spice cultivation expansion", "Gem and mineral resources development", "Agricultural processing industry growth", "Rural business modernization opportunities") }
)

# Function to generate hero subtitle for each city
function Get-HeroSubtitle {
    param([string]$CityName, [string]$Province)
    
    $subtitles = @{
        "Colombo" = "Ranking Your Colombo Business at the Top of Google"
        "Kandy" = "Kandy's #1 SEO Expert for Tourism & Heritage Businesses"
        "Galle" = "Boost Your Galle Business with Professional SEO Services"
        "Jaffna" = "Jaffna's Trusted SEO Consultant for Growing Businesses"
        "Trincomalee" = "Port City SEO Solutions for Trincomalee Businesses"
        "Kurunegala" = "NW Province SEO Expert - Kurunegala's Top Ranked Consultant"
        "Anuradhapura" = "Ancient Capital, Modern SEO - Anuradhapura's Best Consultant"
        "Badulla" = "Hill Country SEO - Badulla's Premier Digital Marketing Expert"
        "Ratnapura" = "Gem City SEO - Increase Your Online Visibility in Ratnapura"
        "Sri Jayawardenepura Kotte" = "Government Hub SEO - Sri Jayawardenepura Kotte Digital Expert"
        "Matale" = "Spice District SEO - Matale's Professional Digital Marketing"
        "Nuwara Eliya" = "Hill Station SEO Specialist - Nuwara Eliya's Top Consultant"
        "Matara" = "Beach Town SEO - Matara's Best Digital Marketing Expert"
        "Hambantota" = "Port City SEO Solutions - Hambantota's Business Growth Expert"
        "Tangalle" = "Coastal SEO Services - Grow Your Tangalle Business Online"
        "Kilinochchi" = "Northern SEO Expert - Kilinochchi's Trusted Consultant"
        "Mannar" = "Palk Strait SEO - Mannar's Professional Digital Services"
        "Vavuniya" = "Junction Town SEO - Vavuniya's Digital Marketing Expert"
        "Mullaitivu" = "Eastern Northern SEO - Mullaitivu's Professional Consultant"
        "Batticaloa" = "Eastern Port SEO - Batticaloa's Top Digital Marketing Expert"
        "Ampara" = "Eastern District SEO - Ampara's Professional Consultant"
        "Kalmunai" = "Coastal Hub SEO - Kalmunai's Digital Marketing Expert"
        "Puttalam" = "Salt Production SEO - Puttalam's Business Growth Expert"
        "Chilaw" = "West Coast SEO - Chilaw's Professional Digital Consultant"
        "Polonnaruwa" = "Ancient City SEO - Polonnaruwa's Modern Digital Expert"
        "Bandarawela" = "Tea Country SEO - Bandarawela's Digital Marketing Specialist"
        "Monaragala" = "Uva Province SEO - Monaragala's Professional Consultant"
        "Kegalle" = "Highland SEO Expert - Kegalle's Top Digital Marketing Consultant"
    }
    
    if ($subtitles.ContainsKey($CityName)) {
        return $subtitles[$CityName]
    }
    return "Your #1 SEO Consultant in $CityName"
}

# Function to generate location-specific intro paragraph
function Get-LocationIntro {
    param([string]$CityName, [string]$Industry, [string]$Province)
    
    return "As the leading SEO Consultant in $CityName, I specialize in helping $Industry businesses rank higher on Google and AI search engines. Whether you're in the heart of $CityName or serving customers across $Province, my white-hat SEO techniques and deep local market knowledge help your business grow online. As your trusted SEO Consultant $CityName, I combine technical expertise with local market insights to deliver measurable results."
}

# Function to generate benefits paragraph
function Get-BenefitsText {
    param([PSObject]$CityData)
    
    $benefits = $CityData.Benefits -join ", "
    return "As your dedicated SEO Consultant in $($CityData.Name), I understand the unique opportunities and challenges facing $($CityData.Industry) businesses in $($CityData.Province). My services include: $benefits - all tailored specifically to help businesses like yours succeed online. With deep local expertise and understanding of the $($CityData.Name) market, I create customized SEO strategies that drive real growth."
}

# Function to generate why choose section
function Get-WhyChooseSection {
    param([string]$CityName, [string]$Industry, [string]$Province)
    
    return "As the most trusted SEO Consultant in $CityName, I offer more than just SEO services. I provide a strategic partnership focused on your business growth. My approach as an experienced SEO Consultant $CityName combines technical excellence with deep local market knowledge. Whether you're a $Industry business in $CityName or serving customers across $Province, I deliver transparent results with proven ROI."
}

# Process each city
foreach ($city in $cities) {
    $filePath = Join-Path "c:\Users\inzra\OneDrive\Documents\GitHub\seo" $city.File
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $($city.Name)..." -ForegroundColor Cyan
        
        # Read the file
        $content = Get-Content -Path $filePath -Raw
        
        # Get location-specific content
        $heroSubtitle = Get-HeroSubtitle -CityName $city.Name -Province $city.Province
        $locationIntro = Get-LocationIntro -CityName $city.Name -Industry $city.Industry -Province $city.Province
        $benefitsText = Get-BenefitsText -CityData $city
        $whyChoose = Get-WhyChooseSection -CityName $city.Name -Industry $city.Industry -Province $city.Province
        
        # Replace hero subtitle
        $content = $content -replace `
            '<p class="hero-subtitle">[\s\S]*?Search කරද්දී[\s\S]*?</p>', `
            "<p class=`"hero-subtitle`">$heroSubtitle</p>"
        
        # Replace hero description (main intro text)
        $content = $content -replace `
            '<p class="hero-description">[\s\S]*?As the leading SEO Consultant.*?</p>', `
            "<p class=`"hero-description`">$locationIntro</p>"
        
        # Replace solutions title description
        $solutionsHtml = "<div class=`"solutions-title`">`r`n                    <span>What I Offer as Your SEO Consultant in $($city.Name)</span>`r`n                    <h2>Complete SEO & GEO Solutions from the Best SEO Consultant $($city.Name)</h2>`r`n                    <p>$benefitsText</p>"
        $content = $content -replace `
            '<div class="solutions-title">[\s\S]*?<p>As a professional SEO Consultant in Sri Lanka.*?</p>', `
            $solutionsHtml
        
        # Replace about content
        $content = $content -replace `
            '<h2>Why Choose Me as Your SEO Consultant in Sri Lanka\?</h2>[\s\S]*?<p>As a qualified engineer.*?</p>', `
            "<h2>Why Choose Me as Your SEO Consultant in $($city.Name)?</h2>`r`n                            <p>$whyChoose</p>"
        
        # Replace co-operative titles with city name
        $content = $content -replace `
            '<h2>What Makes This SEO Consultant Sri Lanka Different\?</h2>', `
            "<h2>What Makes This SEO Consultant $($city.Name) Different?</h2>"
        
        # Replace counter area city name
        $content = $content -replace `
            '<h2>Proven SEO Strategies from Your SEO Consultant in Sri Lanka</h2>[\s\S]*?<p>As a trusted SEO Consultant in Sri Lanka.*?</p>', `
            "<h2>Proven SEO Strategies from Your SEO Consultant in $($city.Name)</h2>`r`n                            <p>As a trusted SEO Consultant in $($city.Name), I provide comprehensive SEO solutions that combine technical expertise with strategic optimization. My approach as an experienced SEO Consultant $($city.Name) focuses on sustainable, long-term results rather than quick fixes. Every strategy is tailored to your specific business goals, industry competition, and target audience in $($city.Province).</p>"
        
        # Replace develop section title
        $content = $content -replace `
            '<h2>Complete SEO Solutions from Your Expert SEO Consultant Sri Lanka</h2>', `
            "<h2>Complete SEO Solutions from Your Expert SEO Consultant $($city.Name)</h2>"
        
        # Replace job opportunities section
        $content = $content -replace `
            '<h2>Get Your Website Ranking on Google with Expert SEO Consultant Sri Lanka</h2>[\s\S]*?<p>Don.*?</p>', `
            "<h2>Get Your Website Ranking on Google with Expert SEO Consultant $($city.Name)</h2>`r`n                    <p>Don't let your competitors dominate search results. Partner with the leading SEO Consultant in $($city.Name) for professional SEO services tailored to your business. As the best SEO Consultant $($city.Name), I offer transparent pricing and proven results. Contact me for a free consultation specific to your $($city.Industry) business in $($city.Province).</p>"
        
        # Save the updated file
        Set-Content -Path $filePath -Value $content -Encoding UTF8
        Write-Host "✓ Updated: $($city.Name)" -ForegroundColor Green
    }
    else {
        Write-Host "✗ File not found: $($city.File)" -ForegroundColor Red
    }
}

Write-Host "`n✓ Content optimization complete for all 33 cities!" -ForegroundColor Green
Write-Host "Next step: Verify content on local server and submit sitemap to Google Search Console" -ForegroundColor Yellow
