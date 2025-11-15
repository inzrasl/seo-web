# Script: remove-all-navbars.ps1
# Purpose: Remove navbar markup and inline navbar-related styles from all HTML pages.
# It creates a backup (.navremoved.backup) for each processed file if not already present.

$files = Get-ChildItem -Path . -Filter *.html | Where-Object { $_.Name -notmatch '\.backup$' }
Write-Host "Processing $($files.Count) HTML files..." -ForegroundColor Cyan

$removedCount = 0

foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw -Encoding UTF8
    $original = $content

    # Backup once
    $backupPath = "$($f.FullName).navremoved.backup"
    if (-not (Test-Path $backupPath)) {
        Copy-Item $f.FullName $backupPath
    }

    # Remove navbar block between Start/End markers
    $content = [regex]::Replace($content, '(?s)<!-- Start Navbar Area -->.*?<!-- End Navbar Area -->', '<!-- Navbar removed -->')

    # Remove stray duplicated nav markup if markers missing (defensive)
    $content = [regex]::Replace($content, '(?s)<div class="navbar-area">.*?</div>\s*<!-- End Navbar Area -->', '<!-- Navbar removed (unmarked) -->')

    # Remove inline style rules referencing navbar classes inside <style> tags
    # Pattern targets lines with key navbar selectors.
    $content = [regex]::Replace($content, '(?s)<style>.*?</style>', {
        param($m)
        $styleBlock = $m.Value
        $lines = $styleBlock -split "\r?\n"
        $filtered = $lines | Where-Object { $_ -notmatch '(navbar-area|exto-nav|exto-responsive-nav|navbar-light|navbar-nav|mean-menu|navbar-brand|sidebar-menu)' }
        # Reconstruct keeping <style> wrapper
        $reconstructed = ($filtered -join "`n")
        return $reconstructed
    })

    if ($content -ne $original) {
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($f.Name)" -ForegroundColor Green
        $removedCount++
    } else {
        Write-Host "No navbar found / unchanged: $($f.Name)" -ForegroundColor Yellow
    }
}

Write-Host "\nNavbars removed/modified in $removedCount file(s)." -ForegroundColor Cyan
