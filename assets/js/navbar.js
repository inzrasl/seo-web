// Navbar enhancement: active link + mobile toggle
(function(){
  document.addEventListener('DOMContentLoaded', function(){
    var nav = document.getElementById('main-navbar');
    if(!nav) return;
    var menu = nav.querySelector('.nav-menu');
    if(!menu) return;

    // Insert hamburger toggle button (if not already)
    if(!nav.querySelector('.nav-toggle')){
      var toggle = document.createElement('button');
      toggle.className = 'nav-toggle';
      toggle.setAttribute('aria-label','Toggle navigation menu');
      toggle.setAttribute('aria-expanded','false');
      toggle.innerHTML = '<span></span><span></span><span></span>';
      // Place toggle before menu so layout flex works
      nav.querySelector('.nav-inner').insertBefore(toggle, menu);
      toggle.addEventListener('click', function(){
        nav.classList.toggle('menu-open');
        var expanded = nav.classList.contains('menu-open');
        toggle.setAttribute('aria-expanded', expanded ? 'true' : 'false');
      });
    }

    // Active link highlight based on current path
    try {
      var path = window.location.pathname.replace(/\\/+$/,'').replace(/^\\+/,'').toLowerCase();
      if(path === '' || path === '/') path = 'index';
      path = path.replace(/\.html$/,'');

      var links = menu.querySelectorAll('a');
      links.forEach(function(a){
        var href = (a.getAttribute('href') || '').toLowerCase();
        href = href.replace(/\.html$/,'');
        href = href.replace(/\\/+$/,'').replace(/^\\+/,'');
        if(href === '' || href === '/') href = 'index';
        // Normalize potential leading slash differences
        if(path === href){
          a.classList.add('active');
        } else {
          a.classList.remove('active');
        }
      });
    } catch(e){ /* silent */ }
  });
})();
