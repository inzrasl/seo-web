# Removes modern navbar component, CSS link, and JS script from all HTML files
Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content $path -Raw
  $original = $content
  # Remove nav block
  $content = [regex]::Replace($content, '(?is)<nav[^>]*id="main-navbar"[\s\S]*?</nav>\s*', '')
  # Remove custom navbar CSS link
  $content = $content -replace '(?is)<link[^>]*custom-navbar\.css[^>]*>\s*',''
  # Remove navbar JS script tag
  $content = $content -replace '(?is)<script[^>]*navbar\.js[^>]*></script>\s*',''
  if($content -ne $original){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Cleaned: $($_.Name)"
  } else {
    Write-Host "No change: $($_.Name)"
  }
}
Write-Host "Modern navbar removal complete."