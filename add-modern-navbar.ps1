# Script: add-modern-navbar.ps1
# Adds modern navbar component & CSS link to all HTML pages.

$cssLink = '<link rel="stylesheet" href="assets/css/custom-navbar.css">'
$component = Get-Content -Raw -Path './navbar-component.html'

$files = Get-ChildItem -Filter *.html | Where-Object { $_.Name -notmatch '\.backup$' }
Write-Host "Injecting modern navbar into $($files.Count) files..." -ForegroundColor Cyan
$updated = 0
foreach ($f in $files) {
  $html = Get-Content -Raw -Path $f.FullName -Encoding UTF8
  $orig = $html

  # Ensure CSS link present before </head>
  if ($html -notmatch 'custom-navbar.css') {
    $html = $html -replace '</head>', "  $cssLink`n</head>"
  }

  # Skip if navbar already present
  if ($html -match 'id="main-navbar"') {
    Write-Host "Already has navbar: $($f.Name)" -ForegroundColor Yellow
    continue
  }

  # Insert after opening <body>
  $html = $html -replace '<body[^>]*>', { param($m) $m.Value + "`n" + $component }

  if ($html -ne $orig) {
    Set-Content -Path $f.FullName -Value $html -Encoding UTF8 -NoNewline
    Write-Host "Updated: $($f.Name)" -ForegroundColor Green
    $updated++
  } else {
    Write-Host "No change: $($f.Name)" -ForegroundColor DarkGray
  }
}
Write-Host "\nModern navbar injected into $updated file(s)." -ForegroundColor Cyan
