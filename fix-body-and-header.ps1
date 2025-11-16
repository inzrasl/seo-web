# Ensure opening <body> exists; inject header component after it; fix stray `n before script
$component = Get-Content -Raw -Path "header-component.html"

Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content -Raw -Path $path
  $orig = $content

  $hadBodyOpen = $content -match '(?is)<body[^>]*>'

  # Insert <body> after </head> if missing
  if(-not $hadBodyOpen){
    if($content -match '(?is)</head>'){
      $content = [regex]::Replace($content,'(?is)</head>', "</head>`n<body>")
    }
  }

  # After ensuring <body>, inject header if missing
  if($content -notmatch 'id="site-header"'){
    $content = [regex]::Replace($content, '(?is)(<body[^>]*>)', { param($m) $m.Value + "`n" + $component })
  }

  # Fix stray literal `n before script tags from earlier injection
  $content = $content -replace "`n\s*`n", "`n"  # collapse accidental double newlines
  $content = $content -replace "`n\s*`n", "`n"  # twice just in case
  $content = $content -replace "`n\s*`n", "`n"
  $content = $content -replace "`n\s*`n", "`n"
  $content = $content -replace "`n\s*<script", "`n  <script"
  $content = $content -replace "\r?\n\s*`n", "`n"

  if($content -ne $orig){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Fixed: $($_.Name)"
  } else {
    Write-Host "No change: $($_.Name)"
  }
}
Write-Host "Body/header fix complete."