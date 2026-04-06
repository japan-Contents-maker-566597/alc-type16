const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html')) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // 1. Fix English Header translation
    content = content.replace(/>🍺<\/span>\s*Sake Type Diagnosis\s*<\/a>\s*<div class="header-nav">/g, '>🍺</span>16 Drunk Personalities</a>\n        <div class="header-nav">');

    // Overwrite only if changed
    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated EN Header translation: ${filePath}`);
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
console.log('Update script complete!');
