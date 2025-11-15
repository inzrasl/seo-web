# Comprehensive script to standardize navigation menu across all HTML files

$standardMenu = @'
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a href="/" class="nav-link{ACTIVE_HOME}">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a href="about" class="nav-link{ACTIVE_ABOUT}">About Us</a>
                                </li>
                                <li class="nav-item">
                                    <a href="contact" class="nav-link{ACTIVE_CONTACT}">Contact</a>
                                </li>
                                <li class="nav-item">
                                    <a href="services" class="nav-link{ACTIVE_SERVICE}">Service</a>
                                </li>
                                <li class="nav-item">
                                    <a href="pricing" class="nav-link{ACTIVE_PRICING}">Pricing</a>
                                </li>
                                <li class="nav-item">
                                    <a href="faq" class="nav-link{ACTIVE_FAQ}">FAQ</a>
                                </li>
                                <li class="nav-item">
                                    <a href="blog" class="nav-link{ACTIVE_BLOG}">Blog</a>
                                </li>
                            </ul>
'@

$files = @(
    @{name="index.html"; active="HOME"},
    @{name="about.html"; active="ABOUT"},
    @{name="contact.html"; active="CONTACT"},
    @{name="services.html"; active="SERVICE"},
    @{name="pricing.html"; active="PRICING"},
    @{name="faq.html"; active="FAQ"},
    @{name="blog.html"; active="BLOG"}
)

# Update specific pages with active state
foreach ($fileInfo in $files) {
    if (Test-Path $fileInfo.name) {
        $content = Get-Content $fileInfo.name -Raw -Encoding UTF8
        $menu = $standardMenu
        
        # Set active state
        $menu = $menu -replace '\{ACTIVE_HOME\}', $(if($fileInfo.active -eq "HOME"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_ABOUT\}', $(if($fileInfo.active -eq "ABOUT"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_CONTACT\}', $(if($fileInfo.active -eq "CONTACT"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_SERVICE\}', $(if($fileInfo.active -eq "SERVICE"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_PRICING\}', $(if($fileInfo.active -eq "PRICING"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_FAQ\}', $(if($fileInfo.active -eq "FAQ"){ " active" }else{ "" })
        $menu = $menu -replace '\{ACTIVE_BLOG\}', $(if($fileInfo.active -eq "BLOG"){ " active" }else{ "" })
        
        # Replace navigation menu
        $content = $content -replace '(?s)<ul class="navbar-nav">.*?</ul>', $menu
        
        [System.IO.File]::WriteAllText($fileInfo.name, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $($fileInfo.name)" -ForegroundColor Green
    }
}

# Update all other HTML files (blog posts, etc.) with standard menu (no active state)
$otherFiles = Get-ChildItem -Path . -Filter "*.html" -File | Where-Object { 
    $_.Name -notin @("index.html","about.html","contact.html","services.html","pricing.html","faq.html","blog.html")
}

$defaultMenu = $standardMenu -replace '\{ACTIVE_[A-Z]+\}', ''

foreach ($file in $otherFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $content = $content -replace '(?s)<ul class="navbar-nav">.*?</ul>', $defaultMenu
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated: $($file.Name)" -ForegroundColor Cyan
}

Write-Host "`nNavigation menu standardized across all files!" -ForegroundColor Green
