const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

// 1. Update main.css
const cssFile = path.join(targetDir, 'css', 'main.css');
if (fs.existsSync(cssFile)) {
    let cssContent = fs.readFileSync(cssFile, 'utf8');
    
    // Replace old .hero-logo and .hero-logo-img CSS
    const heroCssRegex = /\.hero-logo \{([^}]*)\}\s*\.hero-logo-img \{([^}]*)\}/;
    const newHeroCss = `.hero-logo { display:flex; align-items:center; justify-content:center; gap:8px; margin-bottom: 20px; }
.hero-logo-icon { font-size: clamp(2rem, 8vw, 3.5rem); -webkit-text-fill-color: initial; }
.hero-logo .text-logo { font-size: clamp(2rem, 8vw, 3.5rem); letter-spacing: -0.05em; line-height: 1.2; }

/* Pure CSS 1-line typography logo */
.text-logo {
  font-family: var(--font-title);
  font-weight: 900;
  display: inline-block;
  background: linear-gradient(135deg, var(--brand-purple), var(--brand-gold));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  padding: 5px 0;
}
.header-logo .text-logo { font-size: 1.25rem; }`;
    cssContent = cssContent.replace(heroCssRegex, newHeroCss);

    // Replace header-logo CSS to remove explicit font styles since .text-logo handles it
    const headerLogoRegex = /\.header-logo \{ font-size[^}]* \}/;
    cssContent = cssContent.replace(headerLogoRegex, '.header-logo { text-decoration: none; display: flex; align-items: center; gap: 8px; }');
    
    fs.writeFileSync(cssFile, cssContent);
    console.log('Fixed main.css');
}

// 2. Update index.html
const indexFile = path.join(targetDir, 'index.html');
if (fs.existsSync(indexFile)) {
    let content = fs.readFileSync(indexFile, 'utf8');
    content = content.replace(/<img src="\.\/logo\.png"[^>]+>/, '<h1 class="hero-logo"><span class="hero-logo-icon">🍺</span><span class="text-logo">酒タイプ診断</span></h1>');
    content = content.replace(/<section class="glass-card">\s*<h2 class="section-title">16の酒タイプ図鑑<\/h2>/, '<section class="glass-card" id="types">\n            <h2 class="section-title">16の酒タイプ図鑑</h2>');
    fs.writeFileSync(indexFile, content);
    console.log('Fixed index.html');
}

// 3. Update en/index.html
const indexEnFile = path.join(targetDir, 'en', 'index.html');
if (fs.existsSync(indexEnFile)) {
    let content = fs.readFileSync(indexEnFile, 'utf8');
    content = content.replace(/<img src="\.\.\/logo\.png"[^>]+>/, '<h1 class="hero-logo"><span class="hero-logo-icon">🍺</span><span class="text-logo">16 Drunk Personalities</span></h1>');
    content = content.replace(/<section class="glass-card">\s*<h2 class="section-title">16 Type Encyclopedia<\/h2>/, '<section class="glass-card" id="types">\n            <h2 class="section-title">16 Type Encyclopedia</h2>');
    fs.writeFileSync(indexEnFile, content);
    console.log('Fixed en/index.html');
}

// 4. Update diagnosis.html
const diagnosisFile = path.join(targetDir, 'diagnosis.html');
if (fs.existsSync(diagnosisFile)) {
    let content = fs.readFileSync(diagnosisFile, 'utf8');
    content = content.replace(/<h1 class="hero-logo" style="font-size: clamp\(1\.5rem, 5vw, 2\.2rem\);">あなたのことを教えてください<\/h1>/, '<h1 class="hero-logo" style="font-size: clamp(1.5rem, 5vw, 2.2rem); word-break: keep-all;">あなたのことを教えてください</h1>');
    fs.writeFileSync(diagnosisFile, content);
    console.log('Fixed diagnosis.html');
}

console.log('Batch fix 3 complete!');
