# Replace internal anchor/form links ending with .html to extensionless
# Examples: href="about.html" -> href="about"; href="/seo-sri-lanka.html#top" -> href="/seo-sri-lanka#top"

$files = Get-ChildItem -File -Filter *.html

foreach($f in $files){
  $path = $f.FullName
  $content = Get-Content -Raw -Path $path
  $orig = $content

  # Update href attributes (double or single quotes), maintain leading slash and hash
  $content = [regex]::Replace($content, '(?i)(href\s*=\s*["])(\/?[A-Za-z0-9 _\-/]+?)\.html(#[^"]*)?(\")', {
    param($m)
    $prefix = $m.Groups[1].Value
    $p = $m.Groups[2].Value
    $hash = $m.Groups[3].Value
    $suffix = '"'
    return $prefix + $p + ($hash) + $suffix
  })
  $content = [regex]::Replace($content, "(?i)(href\s*=\s*[\'])(\/?[A-Za-z0-9 _\-/]+?)\.html(#[^\']*)?([\'])", {
    param($m)
    $prefix = $m.Groups[1].Value
    $p = $m.Groups[2].Value
    $hash = $m.Groups[3].Value
    $suffix = "'"
    return $prefix + $p + ($hash) + $suffix
  })

  # Update form action attributes similarly
  $content = [regex]::Replace($content, '(?i)(action\s*=\s*["])(\/?[A-Za-z0-9 _\-/]+?)\.html(#[^"]*)?(\")', {
    param($m)
    $prefix = $m.Groups[1].Value
    $p = $m.Groups[2].Value
    $hash = $m.Groups[3].Value
    $suffix = '"'
    return $prefix + $p + ($hash) + $suffix
  })
  $content = [regex]::Replace($content, "(?i)(action\s*=\s*[\'])(\/?[A-Za-z0-9 _\-/]+?)\.html(#[^\']*)?([\'])", {
    param($m)
    $prefix = $m.Groups[1].Value
    $p = $m.Groups[2].Value
    $hash = $m.Groups[3].Value
    $suffix = "'"
    return $prefix + $p + ($hash) + $suffix
  })

  if($content -ne $orig){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Updated links: $($f.Name)"
  } else {
    Write-Host "No changes: $($f.Name)"
  }
}

Write-Host "Internal link cleanup complete."