const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');

function processFile(filePath) {
    if (!filePath.endsWith('.html')) return;
    
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // Check if it's already added to avoid duplicates
    if (content.includes('games/index.html')) {
        // We already added it maybe? Except the games files themselves which might have it manually.
        // Let's only skip if it's a non-games file that has it in the nav.
        // Actually, the regex approach will only match if we haven't already inserted it between those specific elements.
    }

    const isEng = filePath.includes('\\en\\') || filePath.includes('/en/');
    const linkText = isEng ? "🍺 Party Games" : "🍺 飲み会ツール";

    // 1. Desktop Nav Bar
    // We look for <a href="PREFIX_list.html">TEXT</a>
    const headerDesktopRegex = /(<div class="header-nav">[\s\S]*?<a href=")([^"]*)(list\.html">.*?<\/a>)/gi;
    content = content.replace(headerDesktopRegex, (match, p1, p2, p3) => {
        // If it already has games, skip
        if (match.includes('games/index.html')) return match;
        const prefix = p2; // e.g. "./" or "../" or "../../en/"
        // If it's english, list.html might be in the current directory or prefix
        // Wait, for Japanese root, it's ./list.html -> games = ./games/index.html
        // For Japanese types/lrut.html, it's ../list.html -> games = ../games/index.html
        // For English root en/index.html, list is ./list.html -> games = ../games/index.html
        // Wait. prefix is `../en/` from types/en/lrut.html ? NO, list.html is in `en/list.html`.
        // So prefix for list.html from `en/index.html` is `./`. Then games should be `../games/index.html`.
        
        // Safer way: calculate depth directly from filePath!
        return match; // We will use a reliable depth approach below!
    });
    
    // Calculate depth relative to alctype16 folder
    const relPath = path.relative(targetDir, filePath);
    // e.g. "index.html" -> depth 0
    // "types/lrut.html" -> depth 1
    // "en/types/lrut.html" -> depth 2
    const depth = relPath.split(path.sep).length - 1;
    let upDir = "";
    for(let i=0; i<depth; i++) upDir += "../";
    if (depth === 0) upDir = "./";
    
    const gamesPath = upDir + "games/index.html";

    // Regex to add to Header Nav: Append after list.html or 16タイプ一覧 or 16 Types
    const desktopNavMatch = /(<div class="header-nav">[\s\S]*?list\.html[^>]*>.*?<\/a>)/i;
    if (desktopNavMatch.test(content)) {
        content = content.replace(desktopNavMatch, (match) => {
            if (match.includes('games/index.html')) return match; // Already there
            return match + `\n            <a href="${gamesPath}" style="color:var(--brand-purple); font-weight:bold;">${linkText}</a>`;
        });
    }

    // Regex to add to Mobile Menu: Append after list.html or 16タイプ一覧 or 16 Types
    const mobileNavMatch = /(<div class="mobile-menu"[^>]*>[\s\S]*?list\.html[^>]*>.*?<\/a>)/i;
    if (mobileNavMatch.test(content)) {
        content = content.replace(mobileNavMatch, (match) => {
            if (match.includes('games/index.html')) return match; // Already there
            return match + `\n        <a href="${gamesPath}" style="color:var(--brand-purple); font-weight:bold;">${linkText}</a>`;
        });
    }

    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Added games to nav: ${filePath}`);
    }
}

function traverseDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            if(fullPath.endsWith('games')) continue; // Skip games dir itself as I manually hand-coded its nav
            traverseDir(fullPath);
        } else {
            processFile(fullPath);
        }
    }
}

traverseDir(targetDir);
console.log('Nav injection complete!');
