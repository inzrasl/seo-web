// Clean URL handler - removes .html extension from address bar
(function() {
    'use strict';
    
    var path = window.location.pathname;
    
    // If URL ends with .html, redirect to clean version
    if (path.endsWith('.html')) {
        var cleanPath = path.slice(0, -5); // Remove .html
        var newUrl = window.location.origin + cleanPath + window.location.search + window.location.hash;
        window.history.replaceState(null, '', newUrl);
    }
})();
