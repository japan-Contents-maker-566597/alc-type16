const fs = require('fs');
const path = require('path');
const { createCanvas, loadImage, registerFont } = require('canvas');

// Output directory
const OGP_DIR = path.join(__dirname, 'collegetype16', 'ogp');
if (!fs.existsSync(OGP_DIR)) {
    fs.mkdirSync(OGP_DIR, { recursive: true });
}

// Data sources
const res = JSON.parse(fs.readFileSync('parsed_results.json', 'utf-8'));
const shortTypeMap = {
    'OFAH': 'type01', 'OFAP': 'type02', 'OFMH': 'type03', 'OFMP': 'type04',
    'ONAH': 'type05', 'ONAP': 'type06', 'ONMH': 'type07', 'ONMP': 'type08',
    'IFAH': 'type09', 'IFAP': 'type10', 'IFMH': 'type11', 'IFMP': 'type12',
    'INAH': 'type13', 'INAP': 'type14', 'INMH': 'type15', 'INMP': 'type16',
};
const mapping = {
    'OFAH': 'ミスコン天使_イラスト.png',
    'OFAP': '意識高杉くん_イラスト.png',
    'OFMH': 'ハイスペ最強キャプテン_イラスト.png',
    'OFMP': 'バイト戦士_イラスト.png',
    'ONAH': 'どこでもメロつきウサギ_イラスト.png',
    'ONAP': 'キョロキョロちゃん_イラスト.jpg',
    'ONMH': '語彙無しウェイウェイ.png',
    'ONMP': '普通の大学生_イラスト.png',
    'IFAH': '話聞くダケ_イラスト.png',
    'IFAP': 'しゃにかま星人_イラスト.png',
    'IFMP': 'ガチ勉スライム_イラスト.png',
    'INAP': '狂気の推し活コレクター_イラスト.png',
    'INMH': '留年ヤニカスジジイ.png',
    'INMP': 'いつまでも童貞くん_イラスト.png',
    'IFMH': '親のすねかじり虫_イラスト.png',
    'INAH': '夢見がちバンドマン_イラスト.png'
};

const IMG_BASE_DIR = path.join(__dirname, 'collegetype16', 'img');

// OGP Dimensions
const WIDTH = 1200;
const HEIGHT = 630;

async function generateOgp() {
    console.log('Generating 16 OGP images...');

    for (const typeCode of Object.keys(res)) {
        const shortType = shortTypeMap[typeCode];
        const data = res[typeCode];
        // Remove code like (OFAH) from name
        const cleanName = data.name.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '');
        // Default font for canvas, try to use a sans-serif fallback if custom font is not loaded
        // For robustness, relying on generic sans-serif is safer without providing a font file explicitly.
        
        const canvas = createCanvas(WIDTH, HEIGHT);
        const ctx = canvas.getContext('2d');

        // Background (Gradient)
        const gradient = ctx.createLinearGradient(0, 0, WIDTH, HEIGHT);
        gradient.addColorStop(0, '#FFB7B2'); // Main brand color
        gradient.addColorStop(1, '#ffdfd3'); // Accent color
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, WIDTH, HEIGHT);

        // Add some "glassmorphism" card effect
        ctx.fillStyle = 'rgba(255, 255, 255, 0.8)';
        ctx.beginPath();
        ctx.roundRect(80, 80, WIDTH - 160, HEIGHT - 160, 40); // Need node 18+ for roundRect, using modern feature. If not, polyfill needed. Let's write manual arc to be safe.
        ctx.fill();

        // Draw card manually for broad compatibility
        ctx.fillStyle = 'rgba(255, 255, 255, 0.85)';
        const r = 40; const x = 80; const y = 80; const w = WIDTH - 160; const h = HEIGHT - 160;
        ctx.beginPath();
        ctx.moveTo(x + r, y);
        ctx.lineTo(x + w - r, y);
        ctx.arcTo(x + w, y, x + w, y + r, r);
        ctx.lineTo(x + w, y + h - r);
        ctx.arcTo(x + w, y + h, x + w - r, y + h, r);
        ctx.lineTo(x + r, y + h);
        ctx.arcTo(x, y + h, x, y + h - r, r);
        ctx.lineTo(x, y + r);
        ctx.arcTo(x, y, x + r, y, r);
        ctx.fill();
        ctx.shadowColor = 'rgba(0, 0, 0, 0.1)';
        ctx.shadowBlur = 20;
        ctx.shadowOffsetX = 0;
        ctx.shadowOffsetY = 10;
        ctx.fill();
        
        // Reset shadow
        ctx.shadowColor = 'transparent';

        // Load and draw the character image
        let imgObj;
        const imagePath = path.join(IMG_BASE_DIR, mapping[typeCode]);
        const tempPath = path.join(IMG_BASE_DIR, `temp_${shortType}.png`);
        try {
            // Workaround for canvas node module failing with Japanese paths on Windows:
            // copy to an ASCII temp file, read it, then delete it.
            fs.copyFileSync(imagePath, tempPath);
            imgObj = await loadImage(tempPath);
            fs.unlinkSync(tempPath);

            const imgSize = 350;
            const imgX = x + 80;
            const imgY = y + (h - imgSize) / 2;
            
            // Draw image inside circle
            ctx.save();
            ctx.beginPath();
            ctx.arc(imgX + imgSize/2, imgY + imgSize/2, imgSize/2, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.clip();
            // Draw background for transparency issues
            ctx.fillStyle = '#fff';
            ctx.fill();
            // draw Image
            ctx.drawImage(imgObj, imgX, imgY, imgSize, imgSize);
            ctx.restore();

            // Image border
            ctx.lineWidth = 10;
            ctx.strokeStyle = '#fff';
            ctx.beginPath();
            ctx.arc(imgX + imgSize/2, imgY + imgSize/2, imgSize/2, 0, Math.PI * 2, true);
            ctx.stroke();

        } catch (e) {
            console.error(`Failed to load image ${imagePath}`);
            console.error(e);
            if(fs.existsSync(tempPath)) fs.unlinkSync(tempPath);
        }

        // Add text
        ctx.fillStyle = '#555';
        ctx.textAlign = 'left';
        
        // Catchphrase
        ctx.font = 'bold 32px sans-serif';
        const catchText = data.catchphrase.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '');
        ctx.fillText(catchText, 520, 240);

        // Type Name
        ctx.fillStyle = '#333';
        ctx.font = 'bold 64px sans-serif';
        ctx.fillText(cleanName, 520, 330);

        // Site Name
        ctx.fillStyle = '#FF9A9E';
        ctx.font = 'bold 40px sans-serif';
        ctx.fillText('🏫 大学生タイプ診断', 520, 440);

        // Save
        const outPath = path.join(OGP_DIR, `${shortType}.png`);
        const buffer = canvas.toBuffer('image/png');
        fs.writeFileSync(outPath, buffer);
        console.log(`Generated ${outPath}`);
    }
}

generateOgp().catch(console.error);
