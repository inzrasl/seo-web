# Remove stray 'param($m) $m.Value + "`n" + $component' injection artifacts
Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content $path -Raw
  $original = $content
  # Remove the exact line and optional surrounding whitespace/newlines
  $content = $content -replace '(?im)^\s*param\(\$m\) \$m\.Value \+ "`n" \+ \$component\s*$',''
  # Collapse multiple blank lines left behind near <body>
  $content = $content -replace '(?s)(<body[^>]*>)(\r?\n){2,}', '$1`n'
  if($content -ne $original){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Cleaned param line: $($_.Name)"
  }
}
Write-Host "Param line cleanup complete."