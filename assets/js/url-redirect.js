// Automatically redirect .html URLs to clean URLs
(function() {
    'use strict';
    
    // Check if current URL has .html extension
    if (window.location.pathname.endsWith('.html')) {
        // Remove .html from the URL
        var cleanUrl = window.location.pathname.replace(/\.html$/, '');
        var newUrl = window.location.origin + cleanUrl + window.location.search + window.location.hash;
        
        // Replace the current URL (so back button works correctly)
        window.location.replace(newUrl);
    }
})();
