const fs = require('fs');
const path = require('path');

const baseDir = "C:\\Users\\01051992\\Desktop\\NEWalctype16\\alctype16";

function processFile(filepath) {
    const relPath = path.relative(baseDir, filepath);
    const parts = relPath.split(path.sep);
    
    let depth = "./";
    if (parts.length === 2) depth = "../";
    else if (parts.length === 3) depth = "../../";

    let content = fs.readFileSync(filepath, 'utf-8');

    if (content.includes('css/main.css') || content.includes('main.css')) return;

    // Delete <style>...</style>
    content = content.replace(/<style>[\s\S]*?<\/style>/gi, '');

    // Delete font imports
    content = content.replace(/<link rel="preconnect" href="https:\/\/fonts\.googleapis\.com">/g, '');
    content = content.replace(/<link rel="preconnect" href="https:\/\/fonts\.gstatic\.com" crossorigin>/g, '');
    content = content.replace(/<link href="https:\/\/fonts\.googleapis\.com\/css2\?family=M\+PLUS\+Rounded\+1c[^>]*>/g, '');

    // Insert main.css before </head>
    const cssLink = `\n    <link rel="stylesheet" href="${depth}css/main.css">\n</head>`;
    content = content.replace('</head>', cssLink);

    // Clean up extra newlines
    content = content.replace(/\n{3,}/g, '\n\n');

    fs.writeFileSync(filepath, content, 'utf-8');
    console.log(`Processed: ${filepath}`);
}

function processDirectory(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            processDirectory(fullPath);
        } else if (fullPath.endsWith('.html')) {
            processFile(fullPath);
        }
    }
}

processDirectory(baseDir);
