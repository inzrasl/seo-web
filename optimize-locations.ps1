# PowerShell Script to Optimize City-Specific SEO Content for All 33 Sri Lankan Cities

$cities = @(
    @{Name = "Colombo"; File = "seo-consultant-colombo.html"; Industry = "commerce and finance"; Benefits = "Access to major tech companies, high concentration of businesses seeking online growth, leading metro hub for SEO expertise" },
    @{Name = "Kandy"; File = "seo-consultant-kandy.html"; Industry = "tourism and heritage"; Benefits = "Dominant tourism sector, heritage industry growth, second-largest city with expanding opportunities" },
    @{Name = "Galle"; File = "seo-consultant-galle.html"; Industry = "tourism and fishing"; Benefits = "Growing tourism sector, fishing modernization, coastal business boom" },
    @{Name = "Jaffna"; File = "seo-consultant-jaffna.html"; Industry = "agriculture and commerce"; Benefits = "Growing agricultural sector, post-development growth, emerging e-commerce opportunities" },
    @{Name = "Trincomalee"; File = "seo-consultant-trincomalee.html"; Industry = "port and tourism"; Benefits = "Major port operations, emerging tourism, Eastern Province expansion" },
    @{Name = "Kurunegala"; File = "seo-consultant-kurunegala.html"; Industry = "agriculture and commerce"; Benefits = "Agricultural business growth, rubber and coconut industry, district hub development" },
    @{Name = "Anuradhapura"; File = "seo-consultant-anuradhapura.html"; Industry = "agriculture and heritage"; Benefits = "Sacred city tourism, agricultural modernization, heritage site opportunities" },
    @{Name = "Badulla"; File = "seo-consultant-badulla.html"; Industry = "tea and tourism"; Benefits = "Tea plantation industry, high-altitude tourism, gem mining expansion" },
    @{Name = "Ratnapura"; File = "seo-consultant-ratnapura.html"; Industry = "gemstones and rubber"; Benefits = "World-renowned gemstone market, international traders, rubber modernization" },
    @{Name = "Sri Jayawardenepura Kotte"; File = "seo-consultant-sri-jayawardenepura-kotte.html"; Industry = "government and administration"; Benefits = "Government sector IT, administrative hub, digital adoption growth" },
    @{Name = "Matale"; File = "seo-consultant-matale.html"; Industry = "agriculture and spices"; Benefits = "Spice cultivation growth, global export market, agro-business modernization" },
    @{Name = "Nuwara Eliya"; File = "seo-consultant-nuwara-eliya.html"; Industry = "tourism and agriculture"; Benefits = "Premium tourism destination, high-altitude agriculture, resort development" },
    @{Name = "Matara"; File = "seo-consultant-matara.html"; Industry = "tourism and fishing"; Benefits = "Coastal tourism development, fishing industry modernization, surfing destination" },
    @{Name = "Hambantota"; File = "seo-consultant-hambantota.html"; Industry = "port and tourism"; Benefits = "International port development, logistics growth, strategic South Asian location" },
    @{Name = "Tangalle"; File = "seo-consultant-tangalle.html"; Industry = "tourism and fishing"; Benefits = "Emerging tourism destination, fishing modernization, water sports opportunities" },
    @{Name = "Kilinochchi"; File = "seo-consultant-kilinochchi.html"; Industry = "agriculture and commerce"; Benefits = "Post-development modernization, digital access, agricultural export opportunities" },
    @{Name = "Mannar"; File = "seo-consultant-mannar.html"; Industry = "fishing and agriculture"; Benefits = "Fishing expansion, cross-strait trade, salt production modernization" },
    @{Name = "Vavuniya"; File = "seo-consultant-vavuniya.html"; Industry = "commerce and agriculture"; Benefits = "Transport hub logistics, agricultural consolidation, Northern trade gateway" },
    @{Name = "Mullaitivu"; File = "seo-consultant-mullaitivu.html"; Industry = "fishing and agriculture"; Benefits = "Fishing modernization, lagoon aquaculture, post-development opportunities" },
    @{Name = "Batticaloa"; File = "seo-consultant-batticaloa.html"; Industry = "fishing and commerce"; Benefits = "Fishing industry processing, lagoon economics, Eastern commerce hub" },
    @{Name = "Ampara"; File = "seo-consultant-ampara.html"; Industry = "agriculture and tourism"; Benefits = "Emerging beach tourism, agricultural growth, coastal development potential" },
    @{Name = "Kalmunai"; File = "seo-consultant-kalmunai.html"; Industry = "fishing and commerce"; Benefits = "Fishing community modernization, spice and coconut trade, coastal hub status" },
    @{Name = "Puttalam"; File = "seo-consultant-puttalam.html"; Industry = "salt and fishing"; Benefits = "Salt production modernization, fishing lagoon resources, coastal tourism" },
    @{Name = "Chilaw"; File = "seo-consultant-chilaw.html"; Industry = "fishing and agriculture"; Benefits = "Fishing community expansion, coconut processing, beach tourism development" },
    @{Name = "Polonnaruwa"; File = "seo-consultant-polonnaruwa.html"; Industry = "heritage and agriculture"; Benefits = "Heritage tourism sites, agricultural modernization, irrigation-based farming" },
    @{Name = "Bandarawela"; File = "seo-consultant-bandarawela.html"; Industry = "tourism and agriculture"; Benefits = "Tea plantation tourism, high-altitude agriculture, resort hospitality growth" },
    @{Name = "Monaragala"; File = "seo-consultant-monaragala.html"; Industry = "agriculture and forestry"; Benefits = "Agricultural modernization, forest product commercialization, rural development" },
    @{Name = "Kegalle"; File = "seo-consultant-kegalle.html"; Industry = "agriculture and rubber"; Benefits = "Rubber plantation modernization, coconut and spice cultivation, gem resources" }
)

foreach ($city in $cities) {
    $filePath = Join-Path "c:\Users\inzra\OneDrive\Documents\GitHub\seo" $city.File
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $($city.Name)..." -ForegroundColor Cyan
        $content = Get-Content -Path $filePath -Raw
        
        # Replace Colombo references with city name
        $content = $content -replace "SEO Consultant in Sri Lanka", "SEO Consultant in $($city.Name)"
        $content = $content -replace "SEO Consultant Sri Lanka", "SEO Consultant $($city.Name)"
        $content = $content -replace "as an experienced SEO Consultant Sri Lanka", "as an experienced SEO Consultant $($city.Name)"
        $content = $content -replace "best SEO Consultant Sri Lanka", "best SEO Consultant $($city.Name)"
        $content = $content -replace "leading SEO Consultant in Sri Lanka", "leading SEO Consultant in $($city.Name)"
        
        # Industry-specific replacements
        $content = $content -replace "\$\(Industry\)", $city.Industry
        
        Set-Content -Path $filePath -Value $content -Encoding UTF8
        Write-Host "✓ Updated: $($city.Name)" -ForegroundColor Green
    }
    else {
        Write-Host "✗ File not found: $($city.File)" -ForegroundColor Red
    }
}

Write-Host "`n✓ All cities updated!" -ForegroundColor Green
