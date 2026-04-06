const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html') || !(filePath.includes('/types/') || filePath.includes('\\types\\'))) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // Remove 【 】 from inside <span class="key-sentence">...</span>
    content = content.replace(/<span class="key-sentence">【([\s\S]*?)】<\/span>/g, '<span class="key-sentence">$1</span>');

    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Removed brackets from: ${filePath}`);
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
console.log('Bracket removal complete!');
