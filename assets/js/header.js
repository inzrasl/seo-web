// Header interactions: mobile toggle + active link
(function(){
  document.addEventListener('DOMContentLoaded', function(){
    var header = document.getElementById('site-header');
    if(!header) return;

    var toggle = header.querySelector('.nav-toggle');
    var mobileMenu = header.querySelector('.mobile-menu');

    if(toggle){
      toggle.addEventListener('click', function(){
        var isOpen = header.classList.toggle('open');
        toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        if(mobileMenu){
          if(isOpen){ mobileMenu.removeAttribute('hidden'); }
          else { mobileMenu.setAttribute('hidden',''); }
        }
      });
    }

    // Active link detection (strip .html and leading/trailing slashes)
    var path = (window.location.pathname || '/').toLowerCase();
    path = path.replace(/\\/g,'/');
    path = path.replace(/\/+$/,'');
    path = path.replace(/^\/+/, '');
    if(path === '' || path === '/') path = 'index';
    path = path.replace(/\.html$/, '');

    function normalize(href){
      var h = (href || '').toLowerCase();
      h = h.replace(/\\/g,'/');
      h = h.replace(/\.html$/, '');
      h = h.replace(/\/+$/,'');
      h = h.replace(/^\/+/, '');
      if(h === '' || h === '/') h = 'index';
      return h;
    }

    var links = header.querySelectorAll('.menu a, .mobile-menu a');
    links.forEach(function(a){
      var href = normalize(a.getAttribute('href'));
      if(href === path){ a.classList.add('active'); }
      else { a.classList.remove('active'); }
      if(a.closest('.mobile-menu')){
        a.addEventListener('click', function(){
          if(header.classList.contains('open')){
            header.classList.remove('open');
            toggle && toggle.setAttribute('aria-expanded','false');
            mobileMenu && mobileMenu.setAttribute('hidden','');
          }
        });
      }
    });
  });
})();
