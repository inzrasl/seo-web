# PowerShell script to add WhatsApp chat button to all HTML files

$whatsappButton = @'

    <!-- WhatsApp Chat Button -->
    <a href="https://wa.me/94778064714" class="whatsapp-float" target="_blank" rel="noopener noreferrer" aria-label="Chat on WhatsApp">
        <i class="fab fa-whatsapp"></i>
    </a>
    <style>
        .whatsapp-float {
            position: fixed;
            width: 60px;
            height: 60px;
            bottom: 30px;
            right: 30px;
            background-color: #25d366;
            color: #FFF;
            border-radius: 50px;
            text-align: center;
            font-size: 32px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.3);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        .whatsapp-float:hover {
            background-color: #128C7E;
            box-shadow: 2px 2px 16px rgba(0, 0, 0, 0.4);
            transform: scale(1.1);
            color: #FFF;
        }
        .whatsapp-float i {
            margin: 0;
            line-height: 60px;
        }
    </style>

'@

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Check if WhatsApp button already exists
    if ($content -match "whatsapp-float") {
        Write-Host "Skipped (already has WhatsApp button): $($file.Name)"
        continue
    }
    
    # Add WhatsApp button before closing body tag
    $content = $content -replace '(\s*</body\s*>)', "$whatsappButton`$1"
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "`nWhatsApp chat button added to all HTML files."
