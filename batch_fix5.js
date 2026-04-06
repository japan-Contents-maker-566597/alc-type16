const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'alctype16');
const indexFile = path.join(targetDir, 'index.html');

if (fs.existsSync(indexFile)) {
    let content = fs.readFileSync(indexFile, 'utf8');
    content = content.replace(
        /もっと安全で楽しいお酒の場がつくれるはずです🍻/,
        'もっと楽しいお酒の場がつくれるはずです🍻'
    );
    fs.writeFileSync(indexFile, content, 'utf8');
}
console.log('Fixed safety copy in JP index!');
