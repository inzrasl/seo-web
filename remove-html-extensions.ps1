# PowerShell Script to Remove .html Extensions from All Links
# This script processes all HTML files and removes .html from internal links

$rootPath = $PSScriptRoot
Write-Host "Starting to remove .html extensions from all HTML files in: $rootPath" -ForegroundColor Green

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" -File

$totalFiles = $htmlFiles.Count
$processedFiles = 0

foreach ($file in $htmlFiles) {
    $processedFiles++
    Write-Host "[$processedFiles/$totalFiles] Processing: $($file.Name)" -ForegroundColor Cyan
    
    try {
        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Store original content for comparison
        $originalContent = $content
        
        # Replace patterns for href and src attributes
        # Pattern 1: href="filename.html" -> href="filename"
        $content = $content -replace 'href="([^"]+?)\.html"', 'href="$1"'
        
        # Pattern 2: href='filename.html' -> href='filename'
        $content = $content -replace "href='([^']+?)\.html'", 'href=''$1'''
        
        # Pattern 3: Handle URLs with .html in structured data (JSON-LD, meta tags)
        $content = $content -replace '(["|''])([^"'']+?)\.html(["|''])', '$1$2$3'
        
        # Check if content was modified
        if ($content -ne $originalContent) {
            # Backup original file
            $backupPath = "$($file.FullName).backup"
            Copy-Item -Path $file.FullName -Destination $backupPath -Force
            
            # Write modified content
            [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
            
            Write-Host "  Updated: $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "  No changes needed: $($file.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nProcessing complete!" -ForegroundColor Green
Write-Host "Total files processed: $processedFiles" -ForegroundColor Green
Write-Host "`nBackup files created with .backup extension" -ForegroundColor Yellow
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Test your website locally" -ForegroundColor White
Write-Host "2. Upload .htaccess (for Apache) or web.config (for IIS) to your server" -ForegroundColor White
Write-Host "3. If everything works you can delete backup files" -ForegroundColor White
