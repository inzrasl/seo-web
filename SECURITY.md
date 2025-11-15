# Website Security Implementation Guide

## 🔒 Security Features Implemented

### 1. **Server-Side Security (.htaccess / web.config)**
- ✅ SQL Injection Protection
- ✅ XSS (Cross-Site Scripting) Prevention
- ✅ CSRF (Cross-Site Request Forgery) Protection
- ✅ Directory Traversal Attack Prevention
- ✅ File Inclusion Attack Blocking
- ✅ Bad Bot & Scraper Blocking
- ✅ Rate Limiting & DDoS Protection
- ✅ Hotlink Protection (Bandwidth Theft Prevention)

### 2. **Security Headers**
- ✅ X-Frame-Options (Clickjacking Protection)
- ✅ X-XSS-Protection (XSS Filter)
- ✅ X-Content-Type-Options (MIME Sniffing Prevention)
- ✅ Content-Security-Policy (CSP)
- ✅ Strict-Transport-Security (HSTS)
- ✅ Referrer-Policy
- ✅ Permissions-Policy

### 3. **File & Directory Protection**
- ✅ Hidden .htaccess, .env, .git files
- ✅ Backup files (.bak, .backup, .old) blocked
- ✅ Log files (.log) blocked
- ✅ Config files protected
- ✅ Directory listing disabled
- ✅ Server signature hidden

### 4. **Input Validation & Sanitization**
- ✅ Query string validation
- ✅ Cookie validation
- ✅ HTTP referrer validation
- ✅ Request URI validation
- ✅ File upload restrictions

### 5. **SSL/TLS Configuration**
- ✅ Force HTTPS redirect
- ✅ HSTS enabled (1 year)
- ✅ SSL/TLS best practices

### 6. **Performance & Caching**
- ✅ GZIP compression enabled
- ✅ Browser caching configured
- ✅ Keep-Alive enabled
- ✅ Static content caching

## 📋 Additional Security Recommendations

### For PHP Contact Forms (assets/php/)
Add these security measures to your PHP files:

```php
<?php
// Enable error reporting (disable in production)
error_reporting(0);
ini_set('display_errors', 0);

// Session security
ini_set('session.cookie_httponly', 1);
ini_set('session.cookie_secure', 1);
ini_set('session.cookie_samesite', 'Strict');

// Input sanitization
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
    return $data;
}

// CSRF token generation
function generate_csrf_token() {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

// CSRF token validation
function validate_csrf_token($token) {
    return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
}

// Rate limiting
function check_rate_limit($ip, $limit = 5, $timeframe = 60) {
    // Implement rate limiting logic
    // Store attempts in database or session
}
?>
```

### Update PHP Contact Form Files

1. **contact-form-process.php** - Add:
```php
session_start();

// Rate limiting
$ip = $_SERVER['REMOTE_ADDR'];
check_rate_limit($ip);

// CSRF validation
if (!validate_csrf_token($_POST['csrf_token'])) {
    die('Invalid CSRF token');
}

// Input sanitization
$name = sanitize_input($_POST['name']);
$email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
$message = sanitize_input($_POST['message']);

// Email validation
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    die('Invalid email address');
}

// Prevent header injection
$name = str_replace(["\r", "\n"], '', $name);
$email = str_replace(["\r", "\n"], '', $email);
```

2. **Add CSRF tokens to HTML forms**:
```html
<input type="hidden" name="csrf_token" value="<?php echo generate_csrf_token(); ?>">
```

### Database Security (If Using Database)

```php
// Use PDO with prepared statements
try {
    $pdo = new PDO('mysql:host=localhost;dbname=database', 'username', 'password', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    error_log($e->getMessage());
    die('Database connection failed');
}

// Never use mysqli_query() or mysql_* functions
// Always use prepared statements
$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmt->execute([$email]);
```

## 🛡️ Firewall & CDN Protection

### Recommended Services:
1. **Cloudflare** (Free Tier Available)
   - DDoS protection
   - WAF (Web Application Firewall)
   - SSL/TLS certificates
   - CDN (Content Delivery Network)
   - Bot protection

2. **Sucuri**
   - Website firewall
   - Malware scanning
   - DDoS protection

3. **Wordfence** (if using WordPress in future)
   - Real-time threat defense
   - Firewall protection

## 🔍 Security Monitoring

### Regular Checks:
- [ ] Monitor server logs weekly
- [ ] Check for suspicious 403/404 errors
- [ ] Review failed login attempts
- [ ] Scan for malware monthly
- [ ] Update all software regularly
- [ ] Backup website weekly
- [ ] Test security headers: https://securityheaders.com
- [ ] SSL test: https://www.ssllabs.com/ssltest/

### Security Scanning Tools:
- Sucuri SiteCheck: https://sitecheck.sucuri.net/
- Mozilla Observatory: https://observatory.mozilla.org/
- Security Headers: https://securityheaders.com/
- Qualys SSL Labs: https://www.ssllabs.com/

## 📝 Security Checklist

### Initial Setup:
- [x] .htaccess / web.config security rules implemented
- [x] Security headers configured
- [x] SSL/HTTPS forced
- [x] File permissions set correctly
- [x] Sensitive files hidden
- [ ] PHP security measures added
- [ ] CSRF tokens implemented in forms
- [ ] Rate limiting configured
- [ ] Cloudflare or similar CDN/WAF enabled
- [ ] Regular backups scheduled

### Ongoing Maintenance:
- [ ] Monitor logs weekly
- [ ] Update dependencies monthly
- [ ] Security scans monthly
- [ ] Backup verification monthly
- [ ] Review access logs quarterly
- [ ] Penetration testing annually

## 🚨 Incident Response

If you detect a security breach:
1. Immediately take the site offline
2. Change all passwords
3. Review server logs
4. Restore from clean backup
5. Contact hosting provider
6. Report to authorities if necessary
7. Notify affected users

## 📞 Security Contact

For security issues, contact:
- Email: security@seoconsultantsrilanka.com
- Create issue on GitHub (for non-critical issues)

## 📚 Additional Resources

- OWASP Top 10: https://owasp.org/www-project-top-ten/
- Web Security Academy: https://portswigger.net/web-security
- Mozilla Web Security: https://infosec.mozilla.org/guidelines/web_security

---

**Last Updated:** November 16, 2025
**Next Review:** December 16, 2025
