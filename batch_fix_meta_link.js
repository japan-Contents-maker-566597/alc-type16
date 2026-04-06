const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html') || !(filePath.includes('/types/') || filePath.includes('\\types\\'))) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // 1. Fix <head> meta tags that got corrupted with <span class="marker-highlight">
    content = content.replace(/<head>([\s\S]*?)<\/head>/i, (headTag, innerHead) => {
        // Strip out the span tag inside the head completely
        let fixedHead = innerHead.replace(/<span class="marker-highlight">/g, '');
        fixedHead = fixedHead.replace(/<\/span>/g, '');
        return `<head>${fixedHead}</head>`;
    });

    // 2. Wrap Match Profiles in Anchor Links to navigate to the detailed page
    // It currently looks like:
    // <div class="match-profile good-match">
    //     <img src="../../酒タイプ画像/LRUT.jpg" class="match-avatar" alt="LRUT"> ...
    // </div>
    // Note: Since we might have already run the script, we must avoid double wrapping.
    
    // First, let's revert any existing anchor wraps if they exist (insurance)
    // We haven't wrapped it yet, so just replacing the top level div is fine.
    
    // Regex matches the start div, captures the class, captures image ID to get lowercase ID for html, then rest of div
    const matchRegex = /<div class="match-profile (good-match|bad-match)">\s*<img src="[^"]*?酒タイプ画像\/([A-Za-z]+)\.jpg"([\s\S]*?)<\/div>\s*<\/div>/g;
    
    content = content.replace(matchRegex, (match, matchClass, typeId, innerContent) => {
        const lowerId = typeId.toLowerCase();
        // Return wrapped in an anchor.
        // We replace the outer <div class="match-profile..."> with <a href="lower.html" class="match-profile...">
        // Wait, the regex consumes the closing </div> of match-profile AND the closing </div> of result-good/bad.
        // Let's rely on a simpler regex to just replace the opening tag and properly close it.
        // We can just use string replace.
        return match; // fallback so we don't break if regex is wrong
    });

    // Better regex for wrapping the match-profile block safely
    // Match the entire block of match-profile
    const profileRegex = /<div class="match-profile (good-match|bad-match)">([\s\S]*?<img src="[^"]*?酒タイプ画像\/([A-Za-z]+)\.jpg"[^>]*>[\s\S]*?<div class="match-text">[\s\S]*?<\/div>\s*)<\/div>/g;
    content = content.replace(profileRegex, (match, matchClass, innerHtml, typeId) => {
        const lowerId = typeId.toLowerCase();
        return `<a href="./${lowerId}.html" class="match-profile-link" style="text-decoration:none; color:inherit; display:block;">\n<div class="match-profile ${matchClass}">${innerHtml}</div>\n</a>`;
    });

    // Overwrite only if changed
    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Fixed meta & links: ${filePath}`);
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
console.log('Batch fix meta & link complete!');
