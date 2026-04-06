const fs = require('fs');
const path = require('path');

const cssFile = path.join(__dirname, 'alctype16', 'css', 'main.css');

if (fs.existsSync(cssFile)) {
    let cssContent = fs.readFileSync(cssFile, 'utf8');
    
    // Replace .key-sentence
    const keySentenceRegex = /\.key-sentence\s*\{[^}]+\}/;
    const newKeySentence = `.key-sentence { 
  display: inline-block;
  padding: 4px 12px;
  background: var(--brand-purple-light);
  color: var(--brand-purple);
  font-weight: 800;
  border-radius: 6px;
  margin-bottom: 12px;
  border-left: 4px solid var(--brand-purple);
}`;
    cssContent = cssContent.replace(keySentenceRegex, newKeySentence);

    // Append match profile css and marker highlight if not exist
    if (!cssContent.includes('.match-profile')) {
        cssContent += `\n/* Format Adjustments for Result Pages */
.marker-highlight {
  background: linear-gradient(transparent 60%, rgba(255, 213, 79, 0.6) 40%);
  font-weight: 800;
  color: var(--text-main);
  padding: 0 4px;
}

.match-profile {
  display: flex;
  gap: 16px;
  align-items: flex-start;
  margin-top: 10px;
  background: #f8fafc;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
}
.match-profile.good-match { border-left: 4px solid #10b981; }
.match-profile.bad-match { border-left: 4px solid #ef4444; }
.match-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  object-fit: contain;
  background: #fff;
  flex-shrink: 0;
  border: 2px solid #fff;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}
.match-text { flex: 1; }
.match-title {
  font-weight: 800;
  font-size: 1.05rem;
  color: var(--text-main);
  margin-bottom: 6px;
}
.match-description {
  font-size: 0.95rem;
  line-height: 1.6;
  color: var(--text-main);
  margin: 0;
}
`;
    }

    fs.writeFileSync(cssFile, cssContent);
    console.log('Fixed main.css styling.');
}
