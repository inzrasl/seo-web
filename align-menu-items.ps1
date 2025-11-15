# PowerShell script to add right alignment CSS for menu items to all HTML files

$cssToAdd = @'
            
            /* Align menu items to right with proper spacing */
            .navbar-nav.ml-auto {
                margin-left: auto !important;
            }
            
            .navbar-nav .nav-item {
                margin-left: 20px !important;
            }
            
            .navbar-collapse {
                justify-content: flex-end !important;
            }
'@

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Check if the alignment CSS already exists
    if ($content -match "navbar-nav\.ml-auto") {
        Write-Host "Skipped (already has alignment CSS): $($file.Name)"
        continue
    }
    
    # Find the closing style tag and add CSS before it
    if ($content -match '</style>') {
        $content = $content -replace '(\s*</style>)', "$cssToAdd`$1"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)"
    } else {
        Write-Host "Skipped (no style tag found): $($file.Name)"
    }
}

Write-Host "`nMenu alignment CSS added to all HTML files."
