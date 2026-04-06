const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');
const indexFile = path.join(targetDir, 'index.html');
const indexEnFile = path.join(targetDir, 'en', 'index.html');

// 1. Process index.html
if (fs.existsSync(indexFile)) {
    let content = fs.readFileSync(indexFile, 'utf8');

    // Collage Swap
    content = content.replace(
        /<div class="hero-char char-odd"><img src="\.\.\/酒タイプ画像\/LOUT\.jpg" alt="アル中番長"><\/div>\s*<div class="hero-char char-center"><img src="\.\.\/酒タイプ画像\/FRDY\.jpg" alt="天使"><\/div>/,
        '<div class="hero-char char-odd"><img src="../酒タイプ画像/FRDY.jpg" alt="天使"></div>\n                <div class="hero-char char-center"><img src="../酒タイプ画像/LOUT.jpg" alt="アル中番長"></div>'
    );

    // Counter Label
    content = content.replace(
        /<div class="proof-counter-label">＼ SNS等で大好評！ ／<\/div>/,
        '<div class="proof-counter-label">＼ 大好評御礼！ ／</div>'
    );

    // Description text
    content = content.replace(
        /どんなシーンでも自分の「酒タイプ」を知っていれば、さらに安全で楽しいお酒の場が待っています🍻/,
        '自分や友達の「酒タイプ」を知ることで、飲み会の話題が広がったり、もっと安全で楽しいお酒の場がつくれるはずです🍻'
    );

    // Disclaimer
    content = content.replace(
        /（※実際の反響を元に一部脚色・構成したイメージを含みます）/,
        '（※お客様の声を一部編集して掲載しています）'
    );

    fs.writeFileSync(indexFile, content, 'utf8');
}

// 2. Process en/index.html
if (fs.existsSync(indexEnFile)) {
    let content = fs.readFileSync(indexEnFile, 'utf8');

    // Collage Swap
    content = content.replace(
        /<div class="hero-char char-odd"><img src="\.\.\/\.\.\/酒タイプ画像\/LOUT\.jpg" alt="Party Monster"><\/div>\s*<div class="hero-char char-center"><img src="\.\.\/\.\.\/酒タイプ画像\/FRDY\.jpg" alt="Angel"><\/div>/,
        '<div class="hero-char char-odd"><img src="../../酒タイプ画像/FRDY.jpg" alt="Angel"></div>\n                <div class="hero-char char-center"><img src="../../酒タイプ画像/LOUT.jpg" alt="Party Monster"></div>'
    );

    // English concept text update aligned with Japanese tweak
    content = content.replace(
        /Whether you're at a welcome party or having a cozy drink with close friends—understanding your "Drunk Personality" allows you to drink safely and beautifully! 🍻/,
        "Knowing your own and your friends' \"Drunk Personality\" will spark great conversations and help you create a safer, more fun drinking environment! 🍻"
    );

    fs.writeFileSync(indexEnFile, content, 'utf8');
}

console.log('Batch fix 4 complete!');
