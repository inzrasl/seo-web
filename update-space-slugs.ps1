# Replace space-based slugs in href/action with hyphen slugs across all HTML files
$map = @{
  'ai seo' = 'ai-seo'
  'best seo company in sri lanka' = 'best-seo-company-sri-lanka'
  'seo expert in srilanka' = 'seo-expert-sri-lanka'
  'seo specialist sri lanka' = 'seo-specialist-sri-lanka'
  'seo sri lanka' = 'seo-sri-lanka'
}

Get-ChildItem -File -Filter *.html | ForEach-Object {
  $path = $_.FullName
  $content = Get-Content -Raw -Path $path
  $orig = $content

  foreach($k in $map.Keys){
    $v = $map[$k]
    # href with double quotes, optional leading slash, optional hash
    $content = [regex]::Replace($content, '(?i)(href\s*=\s*["])(\/?)('+[regex]::Escape($k)+')(#[^"]*)?(\")', {
      param($m)
      $prefix = $m.Groups[1].Value
      $lead = $m.Groups[2].Value
      $hash = $m.Groups[4].Value
      $suffix = '"'
      return $prefix + $lead + $v + $hash + $suffix
    })
    # href with single quotes
    $content = [regex]::Replace($content, "(?i)(href\s*=\s*[\'])(\/?)("+([regex]::Escape($k))+ ")(#[^\']*)?([\'])", {
      param($m)
      $prefix = $m.Groups[1].Value
      $lead = $m.Groups[2].Value
      $hash = $m.Groups[4].Value
      $suffix = "'"
      return $prefix + $lead + $v + $hash + $suffix
    })
    # action with double quotes
    $content = [regex]::Replace($content, '(?i)(action\s*=\s*["])(\/?)('+[regex]::Escape($k)+')(#[^"]*)?(\")', {
      param($m)
      $prefix = $m.Groups[1].Value
      $lead = $m.Groups[2].Value
      $hash = $m.Groups[4].Value
      $suffix = '"'
      return $prefix + $lead + $v + $hash + $suffix
    })
    # action with single quotes
    $content = [regex]::Replace($content, "(?i)(action\s*=\s*[\'])(\/?)("+([regex]::Escape($k))+ ")(#[^\']*)?([\'])", {
      param($m)
      $prefix = $m.Groups[1].Value
      $lead = $m.Groups[2].Value
      $hash = $m.Groups[4].Value
      $suffix = "'"
      return $prefix + $lead + $v + $hash + $suffix
    })
  }

  if($content -ne $orig){
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Updated slugs: $($_.Name)"
  } else {
    Write-Host "No changes: $($_.Name)"
  }
}
Write-Host "Slug update complete."