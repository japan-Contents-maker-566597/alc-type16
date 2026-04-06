const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html') || !(filePath.includes('/types/') || filePath.includes('\\types\\'))) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    const isEn = filePath.includes('/en/') || filePath.includes('\\en\\');
    const imgDepth = isEn ? '../../../' : '../../'; // Relative path to images from types folder

    // 1. Text Highlighting
    if (isEn) {
        // Find text loosely bounded by space or tags and quotes, replace inside
        // Need to target only <p> contents inside result-card so we don't break meta tags
        content = content.replace(/(<div class="result-card">\s*<h3>[^<]+<\/h3>\s*<p>)([\s\S]*?)(<\/p>\s*<\/div>)/g, (match, p1, innerText, p2) => {
            let handled = innerText.replace(/(^|[\s(>])"([^"]+)"([\s.,!?)<]|$)/g, '$1"<span class="marker-highlight">$2</span>"$3');
            return p1 + handled + p2;
        });
        
    } else {
        // Japanese Quotes Highlight
        content = content.replace(/「([^」]+)」/g, '「<span class="marker-highlight">$1</span>」');
        // also 成長のヒント uses 【静寂力】 or similar
        content = content.replace(/【([^】]+)】/g, '【<span class="marker-highlight">$1</span>】');
        
        // Let's strip out the inner <span> styling from 【】 if it was inside a key-sentence so we don't break key-sentence
        // Actually, key-sentence has its own powerful look now, we shouldn't nest marker-highlight heavily. 
        // We will just let CSS handle it.
    }

    // 2. Avatar Match Layout Transformation
    // Good Matches
    const goodMatchRegexJP = /<div class="result-good">\s*<h4>[・\s]*([A-Z]{4})（([^）]+)）[：:](.*?)<\/h4>\s*<\/div>/g;
    const goodMatchRegexEN = /<div class="result-good">\s*<h4>[・·\-\s]*([A-Z]{4})\s*\(([^\)]+)\)\s*[:：]\s*(.*?)<\/h4>\s*<\/div>/g;
    
    // Bad Matches
    const badMatchRegexJP = /<div class="result-bad">\s*<h4>[・\s]*([A-Z]{4})（([^）]+)）[：:](.*?)<\/h4>\s*<\/div>/g;
    const badMatchRegexEN = /<div class="result-bad">\s*<h4>[・·\-\s]*([A-Z]{4})\s*\(([^\)]+)\)\s*[:：]\s*(.*?)<\/h4>\s*<\/div>/g;

    const goodRegex = isEn ? goodMatchRegexEN : goodMatchRegexJP;
    const badRegex = isEn ? badMatchRegexEN : badMatchRegexJP;

    content = content.replace(goodRegex, (match, id, name, desc) => {
        let titleBlock = isEn ? `${id} (${name})` : `${id}（${name}）`;
        return `<div class="result-good">
                <div class="match-profile good-match">
                    <img src="${imgDepth}酒タイプ画像/${id}.jpg" class="match-avatar" alt="${id}">
                    <div class="match-text">
                        <div class="match-title">${titleBlock}</div>
                        <p class="match-description">${desc}</p>
                    </div>
                </div>
            </div>`;
    });

    content = content.replace(badRegex, (match, id, name, desc) => {
        let titleBlock = isEn ? `${id} (${name})` : `${id}（${name}）`;
        return `<div class="result-bad">
                <div class="match-profile bad-match">
                    <img src="${imgDepth}酒タイプ画像/${id}.jpg" class="match-avatar" alt="${id}">
                    <div class="match-text">
                        <div class="match-title">${titleBlock}</div>
                        <p class="match-description">${desc}</p>
                    </div>
                </div>
            </div>`;
    });


    // Overwrite only if changed
    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated formatting: ${filePath}`);
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
console.log('Result pages layout upgrade complete!');
