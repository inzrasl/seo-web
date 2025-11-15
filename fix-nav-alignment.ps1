# Script to fix navigation HTML - remove extra closing </li> tags after </ul>

$files = Get-ChildItem -Path . -Filter "*.html" -File

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Remove extra </li> after </ul> closing tag
    $content = $content -replace '(?s)(</ul>)\s*</li>', '$1'
    
    # Also ensure ml-auto is present (though it should be already)
    $content = $content -replace '<ul class="navbar-nav">', '<ul class="navbar-nav ml-auto">'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Fixed navigation in: $($file.Name)" -ForegroundColor Green
}

Write-Host "`nNavigation HTML cleaned up across all files!" -ForegroundColor Cyan
