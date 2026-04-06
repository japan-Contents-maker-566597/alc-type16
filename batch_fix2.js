const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html')) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // 1. Update Global Header Logo Text to Text Logo logic
    // JP Header
    content = content.replace(
        /<a href="([^"]+index\.html)" class="header-logo">\s*<span style="font-size:1\.4rem;">🍺<\/span>【公式】酒タイプ診断\s*<\/a>/g,
        '<a href="$1" class="header-logo">\n            <span style="font-size:1.4rem;">🍺</span><span class="text-logo">酒タイプ診断</span>\n        </a>'
    );
    // EN Header
    content = content.replace(
        /<a href="([^"]+index\.html)" class="header-logo">\s*<span style="font-size:1\.4rem;">🍺<\/span>16 Drunk Personalities\s*<\/a>/g,
        '<a href="$1" class="header-logo">\n            <span style="font-size:1.4rem;">🍺</span><span class="text-logo">16 Drunk Personalities</span>\n        </a>'
    );

    // 2. Remove redundant <h1> header from result pages
    if (filePath.includes(`${path.sep}types${path.sep}`) || filePath.includes('/types/')) {
        content = content.replace(/<div class="container">\s*<h1><a href="\.\.\/index\.html">[^<]+<\/a><\/h1>/g, '<div class="container">');
        content = content.replace(/<div class="container">\s*<h1><a href="\.\.\/\.\.\/index\.html">[^<]+<\/a><\/h1>/g, '<div class="container">'); // For en/types/ if depth is 2
    }

    // Overwrite only if changed
    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated file: ${filePath}`);
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
console.log('Batch fix 2 complete!');
