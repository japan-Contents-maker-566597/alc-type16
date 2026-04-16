const fs = require('fs');
const path = require('path');
const puppeteer = require('puppeteer');

// Paths (project root)
const TEMPLATE_PATH = path.join(__dirname, 'ogp_template.html');
const RES_PATH = path.join(__dirname, 'parsed_results.json');
const IMG_DIR = path.join(__dirname, 'collegetype16', 'img');
const OGP_DIR = path.join(__dirname, 'collegetype16', 'ogp');

if (!fs.existsSync(OGP_DIR)) {
  fs.mkdirSync(OGP_DIR, { recursive: true });
}

const results = JSON.parse(fs.readFileSync(RES_PATH, 'utf-8'));

/**
 * Convert local image to base64 string
 */
function getBase64Image(filePath) {
  if (!fs.existsSync(filePath)) return null;
  const ext = path.extname(filePath).toLowerCase();
  const mimeType = ext === '.jpg' || ext === '.jpeg' ? 'image/jpeg' : 'image/png';
  const buffer = fs.readFileSync(filePath);
  return `data:${mimeType};base64,${buffer.toString('base64')}`;
}

(async () => {
  console.log('Starting OGP generation...');
  const browser = await puppeteer.launch({
    headless: "new",
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--allow-file-access-from-files']
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1200, height: 630 });

  const template = fs.readFileSync(TEMPLATE_PATH, 'utf-8');
  const files = fs.readdirSync(IMG_DIR);

  for (const typeCode of Object.keys(results)) {
    const data = results[typeCode];
    const cleanName = data.name.replace(/[A-Z]{4}|（.*?）|\\(.*?\\)/g, '').trim();
    const catchPhrase = data.catchphrase.replace(/[A-Z]{4}|（.*?）|\\(.*?\\)/g, '').trim();

    const overrides = {
      'OFMH': 'ハイスペ最強キャプテン_イラスト.png',
      'IFAH': '話聞くダケ_イラスト.png',
      'ONMH': '語彙無しウェイウェイ.png',
      'ONMP': '普通の大学生_イラスト.png'
    };
    
    const catchphraseOverrides = {
      'ONMP': '平均点をたたき出すプロフェッショナル'
    };
    
    // Final Catchphrase
    const finalCatchphrase = catchphraseOverrides[typeCode] || catchPhrase;

    // Determine character image file
    let imgFile = data.image;
    if (!imgFile || overrides[typeCode]) {
      if (overrides[typeCode]) {
        imgFile = overrides[typeCode];
      } else {
        const searchName = data.name.split('（')[0].split('(')[0].trim();
        imgFile = files.find(f => f.includes(searchName)) || `${typeCode}.png`;
      }
    }

    const imgPath = path.join(IMG_DIR, imgFile);
    const base64Img = getBase64Image(imgPath);

    if (!base64Img) {
      console.warn(`Warning: Image not found for ${typeCode} (${cleanName}) at ${imgPath}`);
    }

    // Replace placeholders
    const html = template
      .replace('{CATCHPHRASE}', finalCatchphrase)
      .replace('{TYPE_NAME}', cleanName)
      .replace('{CHAR_IMG}', base64Img || '');

    const tempPath = path.join(__dirname, `temp_${typeCode}.html`);
    fs.writeFileSync(tempPath, html);

    // Using data URL or file URL with wait
    await page.goto('file://' + tempPath.replace(/\\/g, '/'), { waitUntil: 'networkidle0' });
    
    const outPath = path.join(OGP_DIR, `${typeCode}.png`);
    await page.screenshot({ path: outPath, type: 'png' });
    console.log(`Generated ${typeCode}.png`);
    
    fs.unlinkSync(tempPath);
  }

  await browser.close();
  console.log('OGP generation complete.');
})();
