# PowerShell script to remove e-commerce links (shop, cart, checkout) from all HTML files

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Remove shop link and its list item
    $content = $content -replace '(?s)\s*<li class="nav-item">\s*<a href="shop" class="nav-link">Shop</a>\s*</li>', ''
    
    # Remove single-product link and its list item
    $content = $content -replace '(?s)\s*<li class="nav-item">\s*<a href="single-product" class="nav-link">Single Products</a>\s*</li>', ''
    
    # Remove cart link and its list item
    $content = $content -replace '(?s)\s*<li class="nav-item">\s*<a href="cart" class="nav-link">Cart</a>\s*</li>', ''
    
    # Remove checkout link and its list item
    $content = $content -replace '(?s)\s*<li class="nav-item">\s*<a href="checkout" class="nav-link">Checkout</a>\s*</li>', ''
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "`nE-commerce links removed from all HTML files."
