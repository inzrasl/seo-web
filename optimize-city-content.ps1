$cities = @(
    @{name="Colombo"; province="Western Province"; slug="colombo"; region="Commercial capital"; info="Business hub with high digital presence"},
    @{name="Sri Jayawardenepura Kotte"; province="Western Province"; slug="sri-jayawardenepura-kotte"; region="Administrative capital"; info="Government hub requiring professional SEO"},
    @{name="Dehiwala–Mount Lavinia"; province="Western Province"; slug="dehiwala-mount-lavinia"; region="Coastal city"; info="Tourism and hospitality focus"},
    @{name="Moratuwa"; province="Western Province"; slug="moratuwa"; region="Port city"; region="Port and trade hub"},
    @{name="Negombo"; province="Western Province"; slug="negombo"; region="Beach city"; info="Tourism and resort destination"},
    @{name="Gampaha"; province="Western Province"; slug="gampaha"; region="Urban city"; info="Growing business district"},
    @{name="Kalutara"; province="Western Province"; slug="kalutara"; region="Coastal city"; info="Beach and tourist destination"},
    @{name="Kandy"; province="Central Province"; slug="kandy"; region="Cultural capital"; info="Tourism and cultural hub"},
    @{name="Matale"; province="Central Province"; slug="matale"; region="Historic city"; info="Spice garden and agriculture focus"},
    @{name="Nuwara Eliya"; province="Central Province"; slug="nuwara-eliya"; region="Hill station"; info="Tourism and tea industry"},
    @{name="Galle"; province="Southern Province"; slug="galle"; region="Historic port"; info="Fort city and tourist destination"},
    @{name="Matara"; province="Southern Province"; slug="matara"; region="Coastal city"; info="Beach and fishing industry"},
    @{name="Hambantota"; province="Southern Province"; slug="hambantota"; region="Southern port"; info="Port development and commerce"},
    @{name="Tangalle"; province="Southern Province"; slug="tangalle"; region="Beach town"; info="Beach resort destination"},
    @{name="Jaffna"; province="Northern Province"; slug="jaffna"; region="Northern city"; info="Growing business hub"},
    @{name="Kilinochchi"; province="Northern Province"; slug="kilinochchi"; region="Northern district"; info="Development zone"},
    @{name="Mannar"; province="Northern Province"; slug="mannar"; region="Northern island"; info="Island connectivity hub"},
    @{name="Vavuniya"; province="Northern Province"; slug="vavuniya"; region="Northern city"; info="Strategic city location"},
    @{name="Mullaitivu"; province="Northern Province"; slug="mullaitivu"; region="Eastern northern"; info="Eastern coast development"},
    @{name="Trincomalee"; province="Eastern Province"; slug="trincomalee"; region="Coastal port"; info="Port and tourism hub"},
    @{name="Batticaloa"; province="Eastern Province"; slug="batticaloa"; region="Eastern city"; info="Lagoon city commerce"},
    @{name="Ampara"; province="Eastern Province"; slug="ampara"; region="Eastern district"; info="Beach and agriculture"},
    @{name="Kalmunai"; province="Eastern Province"; slug="kalmunai"; region="Eastern port"; info="Fishing and commerce hub"},
    @{name="Kurunegala"; province="North Western Province"; slug="kurunegala"; region="Northwestern city"; info="Business and agriculture center"},
    @{name="Puttalam"; province="North Western Province"; slug="puttalam"; region="Northwestern port"; info="Lagoon and salt industry"},
    @{name="Chilaw"; province="North Western Province"; slug="chilaw"; region="Coastal town"; info="Beach town and fishing"},
    @{name="Anuradhapura"; province="North Central Province"; slug="anuradhapura"; region="Ancient city"; info="Archaeological and tourism"},
    @{name="Polonnaruwa"; province="North Central Province"; slug="polonnaruwa"; region="Historic city"; info="Ancient kingdom center"},
    @{name="Badulla"; province="Uva Province"; slug="badulla"; region="Eastern hill city"; info="Tea and agriculture center"},
    @{name="Bandarawela"; province="Uva Province"; slug="bandarawela"; region="Hill station"; info="Tea plantations and tourism"},
    @{name="Monaragala"; province="Uva Province"; slug="monaragala"; region="Eastern town"; info="Agricultural community"},
    @{name="Ratnapura"; province="Sabaragamuwa Province"; slug="ratnapura"; region="Gem city"; info="Gem mining and commerce"},
    @{name="Kegalle"; province="Sabaragamuwa Province"; slug="kegalle"; region="Central city"; info="Agriculture and trade hub"}
)

$baseDir = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"

# Read template
$template = Get-Content "$baseDir\seo-consultant-colombo.html" -Raw

foreach ($city in $cities) {
    $filename = "seo-consultant-$($city.slug).html"
    $filepath = Join-Path $baseDir $filename
    
    # Create location-specific content
    $content = $template
    
    # Update all references to Colombo with city name
    $content = $content -replace "Colombo", $city.name
    $content = $content -replace "Western Province", $city.province
    $content = $content -replace "colombo", $city.slug
    
    # Generate unique hero subtitle based on city characteristics
    $heroSubtitle = "Professional SEO Services for $($city.name) Businesses | Guaranteed Google Rankings"
    $content = $content -replace "Professional SEO Services for .* Businesses \| Guaranteed Google Rankings", $heroSubtitle
    
    # Generate location-specific intro paragraph
    $introText = "Looking for the best SEO consultant in $($city.name)? Buddhika S Weerasekara is the #1 choice for businesses in $($city.name), $($city.province) seeking professional SEO services. With 10+ years of experience serving businesses across Sri Lanka, we deliver white-hat SEO strategies specifically tailored for $($city.name)'s competitive market. Whether you're a startup, SME, or established business, our proven SEO techniques will boost your online visibility and drive qualified traffic to your website."
    
    # Replace intro pattern
    $content = $content -replace "Looking for the best SEO consultant in .*?\. With 10\+ years of experience.*?guarantee results\.", $introText
    
    # Generate Why Choose section - location-specific benefits
    $whyChooseContent = @"
                    <div class="row">
                        <div class="col-md-6">
                            <h3>Local SEO Expertise in $($city.name)</h3>
                            <p>As a $($city.name)-based SEO consultant, I understand the unique business landscape of $($city.province). Whether your target audience is within $($city.name) or across Sri Lanka, our SEO strategies are specifically tailored to generate results for businesses in this region. We know the local competition, understand customer behavior, and optimize your website accordingly.</p>
                        </div>
                        <div class="col-md-6">
                            <h3>100% White-Hat SEO Techniques</h3>
                            <p>We strictly follow Google's Search Engine Optimization Starter Guide and use only ethical, sustainable SEO methods. No shortcuts, no risky techniques—just proven strategies that build long-term authority for your $($city.name) business. Your website will rank naturally and maintain those rankings for years to come.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h3>Comprehensive SEO Services</h3>
                            <p>From initial keyword research and on-page optimization to technical SEO audits, content strategy, link building, and ongoing optimization—we handle all aspects of search engine optimization for businesses in $($city.name). Every service is designed to improve your Google rankings and drive organic traffic.</p>
                        </div>
                        <div class="col-md-6">
                            <h3>Proven Track Record</h3>
                            <p>Over 10+ years, we've successfully helped 200+ businesses across $($city.province) and all of Sri Lanka achieve top Google rankings. Our clients report 200-300% increases in organic traffic, improved conversion rates, and sustainable business growth. Check our <a href="contact.html">case studies and testimonials</a> to see real results.</p>
                        </div>
                    </div>
"@
    
    # Replace Why Choose section
    $whyChoosePattern = '<div class="row">.*?<div class="col-md-6">.*?</div>.*?</div>.*?<div class="row">.*?<div class="col-md-6">.*?</div>.*?</div>'
    # Use simpler replacement
    $content = $content -replace "Why Choose Our SEO Services in .*?\?", "Why Choose Our SEO Services in $($city.name)?"
    
    # Write file
    [System.IO.File]::WriteAllText($filepath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Optimized: $filename - $($city.info)"
}

Write-Host ""
Write-Host "All location pages optimized with location-specific content!"
