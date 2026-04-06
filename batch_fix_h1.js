const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html')) return;
    
    // index.html and diagnosis.html have specialized H1s that we want to keep
    const isMainIndex = filePath.endsWith('alctype16\\index.html') || filePath.endsWith('alctype16/index.html') || 
                        filePath.endsWith('en\\index.html') || filePath.endsWith('en/index.html');
                        
    if (isMainIndex) return;

    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // Remove <h1><a href="...index.html">【公式】酒タイプ診断</a></h1> block globally.
    // Also captures 16 Drunk Personalities english translation text.
    const redundantH1Regex = /<h1[^>]*>\s*<a href="[^"]*index\.html"[^>]*>[\s\S]*?<\/a>\s*<\/h1>\s*/gi;
    
    content = content.replace(redundantH1Regex, '');

    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Cleaned up H1 in: ${filePath}`);
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
console.log('H1 duplicate cleanup complete!');
