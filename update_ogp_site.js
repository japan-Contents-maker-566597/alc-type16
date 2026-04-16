const fs = require('fs');
const path = require('path');

const OGP_DIR = path.join(__dirname, 'collegetype16', 'ogp');
const TYPES_DIR = path.join(__dirname, 'collegetype16', 'types');

const mapping = [
    { num: '01', code: 'OFAH' },
    { num: '02', code: 'OFAP' },
    { num: '03', code: 'OFMH' },
    { num: '04', code: 'OFMP' },
    { num: '05', code: 'ONAH' },
    { num: '06', code: 'ONAP' },
    { num: '07', code: 'ONMH' },
    { num: '08', code: 'ONMP' },
    { num: '09', code: 'IFAH' },
    { num: '10', code: 'IFAP' },
    { num: '11', code: 'IFMH' },
    { num: '12', code: 'IFMP' },
    { num: '13', code: 'INAH' },
    { num: '14', code: 'INAP' },
    { num: '15', code: 'INMH' },
    { num: '16', code: 'INMP' }
];

console.log('--- Step 1: Matching OGP images ---');
mapping.forEach(item => {
    const src = path.join(OGP_DIR, `${item.code}.png`);
    const dst = path.join(OGP_DIR, `type${item.num}.png`);
    
    if (fs.existsSync(src)) {
        fs.copyFileSync(src, dst);
        console.log(`Copied ${item.code}.png -> type${item.num}.png`);
    } else {
        console.warn(`Warning: Source ${src} not found.`);
    }
});

console.log('\n--- Step 2: Updating HTML Metadata ---');
mapping.forEach(item => {
    const htmlPath = path.join(TYPES_DIR, `type${item.num}.html`);
    if (fs.existsSync(htmlPath)) {
        let content = fs.readFileSync(htmlPath, 'utf-8');
        
        // Update og:image
        content = content.replace(/<meta property="og:image" content=".*?" \/>/, 
            `<meta property="og:image" content="https://sync-loft.com/collegetype16/ogp/type${item.num}.png" />`);
        
        // Update or add twitter:image
        if (content.includes('name="twitter:image"')) {
            content = content.replace(/<meta name="twitter:image" content=".*?" \/>/, 
                `<meta name="twitter:image" content="https://sync-loft.com/collegetype16/ogp/type${item.num}.png" />`);
        } else {
            // Add after og:image or twitter:card
            content = content.replace(/meta name="twitter:card" content="summary_large_image" \/>/, 
                `meta name="twitter:card" content="summary_large_image" />\n    <meta name="twitter:image" content="https://sync-loft.com/collegetype16/ogp/type${item.num}.png" />`);
        }
        
        fs.writeFileSync(htmlPath, content);
        console.log(`Updated metadata for type${item.num}.html`);
    } else {
        console.warn(`Warning: HTML ${htmlPath} not found.`);
    }
});

console.log('\nDone.');
