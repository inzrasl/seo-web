# Adds navbar.js script tag before closing body on all root HTML files if missing
Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content $path -Raw
  if($content -notmatch 'assets/js/navbar.js'){
    $updated = $content -replace '</body>','    <script src="assets/js/navbar.js"></script>`n</body>'
    Set-Content -Path $path -Value $updated -Encoding UTF8
    Write-Host "Updated: $($_.Name)"
  } else {
    Write-Host "Skipped: $($_.Name)"
  }
}
Write-Host "Navbar JS injection complete."