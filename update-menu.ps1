# Script to update navigation menu in all HTML files
$files = Get-ChildItem -Path . -Filter "*.html" -File | Where-Object { $_.Name -ne "index.html" }

$count = 0
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Pattern 1: Replace "About" with "About Us"
    $content = $content -replace '<a href="about" class="nav-link">About</a>', '<a href="about" class="nav-link">About Us</a>'
    
    # Pattern 2: Remove complex service dropdown menus and replace with simple link
    $content = $content -replace '(?s)<li class="nav-item">\s*<a href="#" class="nav-link">\s*Services?\s*<i class="fa fa-angle-down"></i>\s*</a>\s*<ul class="dropdown-menu">.*?</ul>\s*</li>', '<li class="nav-item"><a href="services" class="nav-link">Service</a></li>'
    
    # Pattern 3: Reorder menu items if needed (ensure correct order)
    # This is complex, so we'll do manual fixes if needed
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    $count++
    Write-Host "Updated: $($file.Name)" -ForegroundColor Green
}

Write-Host "`nTotal files updated: $count" -ForegroundColor Cyan
