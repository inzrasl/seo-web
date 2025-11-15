# Sitemap Auto-Update Instructions

## How to Use

Whenever you add new HTML pages to your website, simply run:

```powershell
.\update-sitemap.ps1
```

This will automatically:
- Scan all `.html` files in the current directory
- Generate a fresh `sitemap.xml` in the `assets` folder
- Set appropriate priority values (Home = 1.00, Main pages = 0.80, Other pages = 0.64)
- Update last modification dates based on file timestamps
- Remove `.html` extensions from URLs (clean URLs)

## Priority Levels

The script automatically assigns priorities:
- **1.00** - Homepage (index.html)
- **0.80** - Important pages (about, contact, services, pricing, faq, blog)
- **0.64** - Content pages (blog posts, SEO guides, etc.)

## After Running

1. The sitemap is saved to: `assets/sitemap.xml`
2. Commit and push changes to GitHub
3. Submit the sitemap to Google Search Console: https://seoconsultantsrilanka.com/assets/sitemap.xml

## Example

```powershell
# Add new HTML page
# Run the script
.\update-sitemap.ps1

# Commit changes
git add assets/sitemap.xml
git commit -m "Update sitemap - added new pages"
git push origin main
```

## Sitemap Location

Your sitemap URL: `https://seoconsultantsrilanka.com/assets/sitemap.xml`

Make sure this is referenced in your `robots.txt` file.
