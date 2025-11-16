# Inject new header component + css + js into all HTML pages
$cssTag = '<link rel="stylesheet" href="assets/css/header.css">'
$jsTag = '<script src="assets/js/header.js" defer></script>'
$component = Get-Content -Raw -Path "header-component.html"

Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content -Raw -Path $path
  $orig = $content

  # Ensure CSS link exists (before </head>)
  if($content -notmatch 'assets/css/header.css'){
    $content = [regex]::Replace($content, '(?is)</head>', "  $cssTag`n</head>")
  }

  # Inject header after <body ...>
  if($content -notmatch 'id="site-header"'){
    $content = [regex]::Replace($content, '(?is)(<body[^>]*>)', { param($m) $m.Value + "`n" + $component })
  }

  # Ensure JS tag before </body>
  if($content -notmatch 'assets/js/header.js'){
    $content = [regex]::Replace($content, '(?is)</body>', "  $jsTag`n</body>")
  }

  if($content -ne $orig){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Updated: $($_.Name)"
  } else {
    Write-Host "No change: $($_.Name)"
  }
}
Write-Host "Header injection complete."