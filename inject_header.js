const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html')) return;

    let content = fs.readFileSync(filePath, 'utf8');

    // Skip if already has global-header
    if (content.includes('class="global-header"')) {
        console.log(`Skipping already processed file: ${filePath}`);
        return;
    }

    // Determine root path based on directory depth
    const relativePath = path.relative(targetDir, filePath);
    const depth = relativePath.split(path.sep).length - 1;
    const rootPath = depth === 0 ? './' : '../'.repeat(depth);

    // Is this an English page?
    const isEn = filePath.includes(path.sep + 'en' + path.sep) || filePath.includes('/en/');
    
    // Header HTML Strings
    const headerHtml = `
    <!-- Global Header -->
    <nav class="global-header">
        <a href="${rootPath}${isEn ? 'en/' : ''}index.html" class="header-logo">
            <span style="font-size:1.4rem;">🍺</span>${isEn ? 'Sake Type Diagnosis' : '【公式】酒タイプ診断'}
        </a>
        <div class="header-nav">
            <a href="${rootPath}${isEn ? 'en/' : ''}diagnosis.html">${isEn ? 'Take Test' : '診断を受ける'}</a>
            <a href="${rootPath}${isEn ? 'en/' : ''}index.html#types">${isEn ? '16 Types' : '16タイプ一覧'}</a>
            <a href="${rootPath}${isEn ? 'en/' : ''}supplement/index.html">${isEn ? 'Articles' : '特集記事'}</a>
            <a href="${rootPath}${isEn ? '' : 'en/'}index.html">${isEn ? '日本語' : 'English'}</a>
        </div>
        <button class="menu-toggle" aria-label="Menu" onclick="document.getElementById('mobileMenu').classList.toggle('active')">☰</button>
    </nav>
    <div class="mobile-menu" id="mobileMenu">
        <a href="${rootPath}${isEn ? 'en/' : ''}diagnosis.html">${isEn ? 'Take Test' : '診断を受ける'}</a>
        <a href="${rootPath}${isEn ? 'en/' : ''}index.html#types">${isEn ? '16 Types' : '16タイプ一覧'}</a>
        <a href="${rootPath}${isEn ? 'en/' : ''}supplement/index.html">${isEn ? 'Articles' : '特集記事'}</a>
        <a href="${rootPath}${isEn ? '' : 'en/'}index.html">${isEn ? '日本語' : 'English'}</a>
    </div>
`;

    // Inject right after <body>
    const bodyIndex = content.indexOf('<body>');
    if (bodyIndex !== -1) {
        let inserted = content.substring(0, bodyIndex + 6) + '\n' + headerHtml + content.substring(bodyIndex + 6);
        fs.writeFileSync(filePath, inserted, 'utf8');
        console.log(`Injected header: ${filePath}`);
    }
}

function traverseDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            traverseDir(fullPath);
        } else {
            processFile(fullPath);
        }
    }
}

traverseDir(targetDir);
console.log('Global header injection complete!');
