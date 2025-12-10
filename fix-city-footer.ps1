$cities = @("kandy", "galle", "jaffna", "trincomalee", "kurunegala", "anuradhapura", "badulla", "ratnapura", "sri-jayawardenepura-kotte", "matale", "nuwara-eliya", "matara", "hambantota", "tangalle", "kilinochchi", "mannar", "vavuniya", "mullaitivu", "batticaloa", "ampara", "kalmunai", "puttalam", "chilaw", "polonnaruwa", "bandarawela", "monaragala", "kegalle", "gampaha", "kalutara", "moratuwa", "negombo", "dehiwala-mount-lavinia")

$basePath = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"

$citiesHtml = '<a href="seo-consultant-colombo.html">Colombo</a>, <a href="seo-consultant-kandy.html">Kandy</a>, <a href="seo-consultant-galle.html">Galle</a>, <a href="seo-consultant-jaffna.html">Jaffna</a>, <a href="seo-consultant-trincomalee.html">Trincomalee</a>, <a href="seo-consultant-kurunegala.html">Kurunegala</a>, <a href="seo-consultant-anuradhapura.html">Anuradhapura</a>, <a href="seo-consultant-badulla.html">Badulla</a>, <a href="seo-consultant-ratnapura.html">Ratnapura</a>, <a href="seo-consultant-matale.html">Matale</a>, <a href="seo-consultant-nuwara-eliya.html">Nuwara Eliya</a>, <a href="seo-consultant-matara.html">Matara</a>, <a href="seo-consultant-hambantota.html">Hambantota</a>, <a href="seo-consultant-tangalle.html">Tangalle</a>, <a href="seo-consultant-kilinochchi.html">Kilinochchi</a>, <a href="seo-consultant-mannar.html">Mannar</a>, <a href="seo-consultant-vavuniya.html">Vavuniya</a>, <a href="seo-consultant-mullaitivu.html">Mullaitivu</a>, <a href="seo-consultant-batticaloa.html">Batticaloa</a>, <a href="seo-consultant-ampara.html">Ampara</a>, <a href="seo-consultant-kalmunai.html">Kalmunai</a>, <a href="seo-consultant-puttalam.html">Puttalam</a>, <a href="seo-consultant-chilaw.html">Chilaw</a>, <a href="seo-consultant-polonnaruwa.html">Polonnaruwa</a>, <a href="seo-consultant-bandarawela.html">Bandarawela</a>, <a href="seo-consultant-monaragala.html">Monaragala</a>, <a href="seo-consultant-kegalle.html">Kegalle</a>, <a href="seo-consultant-gampaha.html">Gampaha</a>, <a href="seo-consultant-kalutara.html">Kalutara</a>, <a href="seo-consultant-moratuwa.html">Moratuwa</a>, <a href="seo-consultant-negombo.html">Negombo</a>, <a href="seo-consultant-dehiwala-mount-lavinia.html">Dehiwala-Mount Lavinia</a>, <a href="seo-consultant-sri-jayawardenepura-kotte.html">Sri Jayawardenepura Kotte</a>'

$updated = 0

foreach ($city in $cities) {
    $file = "$basePath\seo-consultant-$city.html"
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        if ($content -match 'SEO Services Available in:') {
            $titleCase = [System.Globalization.CultureInfo]::new('en-US').TextInfo.ToTitleCase($city.Replace('-', ' '))
            
            $newCopyright = @"
<div class="col-lg-6 col-md-6">
                            <p>– No 1 SEO Consultant in $titleCase | Best SEO Consultant $titleCase. All Rights Reserved by Buddhika S Weerasekara</p>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <ul>
                                <li>
                                    <a href="about.html">Privacy Policy</a>
                                </li>
                                <li>
                                    <a href="about.html">Terms & Conditions</a>
                                </li>
                            </ul>
                        </div>
"@
            
            $content = $content -replace '(?s)<div class="col-lg-12 col-md-12">\s*<p>[^<]*SEO Services Available in:[^<]*</p>\s*</div>', $newCopyright
            
            Set-Content $file -Value $content -Encoding UTF8
            $updated++
            Write-Host "✓ $city"
        }
    }
}

Write-Host "Updated: $updated files"
