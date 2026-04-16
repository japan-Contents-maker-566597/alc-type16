const fs = require('fs');
const path = require('path');

const baseDir = 'collegetype16';
const jsDir = path.join(baseDir, 'js');
const cssDir = path.join(baseDir, 'css');
const typesDir = path.join(baseDir, 'types');
const imgDir = path.join(baseDir, 'img');

[baseDir, jsDir, cssDir, typesDir, imgDir].forEach(d => {
    if (!fs.existsSync(d)) fs.mkdirSync(d, { recursive: true });
});

// Copy images
const srcImgs = fs.readdirSync('大学生タイプ画像');
srcImgs.forEach(f => {
    fs.copyFileSync(path.join('大学生タイプ画像', f), path.join(imgDir, f));
});

// Write main.css
const cssContent = `:root {
    --primary: #FFB7B2;
    --secondary: #E2F0CB;
    --accent: #FFDAC1;
    --bg: #F9F9F9;
    --text: #333333;
    --card-bg: rgba(255, 255, 255, 0.9);
    --font: 'Nunito', 'M PLUS Rounded 1c', sans-serif;
    --shadow: 0 8px 30px rgba(0,0,0,0.08);
}

* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    font-family: var(--font);
    background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%);
    color: var(--text);
    line-height: 1.6;
}

.container { max-width: 600px; margin: 0 auto; padding: 20px; }
h1, h2, h3 { color: #555; text-align: center; }

/* Header & Nav */
.global-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 12px 20px; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    position: sticky; top: 0; z-index: 1000;
}
.header-logo { text-decoration: none; color: var(--primary); font-weight: 900; font-size: 1rem; display: flex; align-items: center; gap: 5px; flex-shrink: 1; }
.header-nav { display: none; }
.menu-toggle {
    background: #f8f9fa; border: 1px solid #eee; font-size: 1.2rem; cursor: pointer; color: #555; padding: 5px 10px; border-radius: 8px;
}

@media(min-width: 768px) {
    .header-nav { display: flex; gap: 20px; }
    .header-nav a { text-decoration: none; color: #555; font-weight: bold; font-size: 0.9rem; }
    .header-nav a:hover { color: var(--primary); }
    .menu-toggle { display: none; }
    .header-logo { font-size: 1.2rem; }
}

.mobile-menu {
    display: none; flex-direction: column; background: white; padding: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1); position: absolute; top: 60px; left: 0; right: 0;
    z-index: 999;
}
.mobile-menu.active { display: flex; }
.mobile-menu a {
    text-decoration: none; color: #333; font-weight: bold; padding: 12px 0;
    border-bottom: 1px solid #eee;
}

/* Card */
.glass-card {
    background: var(--card-bg); border-radius: 20px; padding: 20px; margin-bottom: 20px;
    box-shadow: var(--shadow); backdrop-filter: blur(10px);
}

.fade-in { animation: fadeIn 0.6s ease-out; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

.section-title { font-size: 1.1rem; border-left: 5px solid var(--primary); padding-left: 10px; margin: 25px 0 12px 0; color: #444; font-weight: bold; clear: both;}

/* Ecology List - FIXED BLOCK LAYOUT */
.ecology-list { list-style: none; padding: 0; margin-bottom: 25px; display: block !important; clear: both !important; }
.ecology-list li { 
    background: #fff; padding: 15px 15px 15px 45px; margin-bottom: 12px; border-radius: 12px; 
    box-shadow: 0 4px 12px rgba(0,0,0,0.03); position: relative; line-height: 1.8; color: #444; 
    text-align: left; display: block !important; clear: both !important; width: 100% !important;
}
.ecology-list li::before { content: "💬"; position: absolute; left: 12px; top: 14px; font-size: 1.2rem; display: block; }

.btn {
    display: block; width: 100%; text-align: center; padding: 15px;
    border-radius: 30px; font-weight: bold; text-decoration: none;
    transition: transform 0.2s, box-shadow 0.2s; border: none; cursor: pointer; font-size: 1.1rem;
}
.btn-primary { background: linear-gradient(135deg, var(--primary), #ff9a9e); color: white; box-shadow: 0 4px 15px rgba(255, 183, 178, 0.4); }
.btn-secondary { background: white; color: #ff8b94; border: 2px solid var(--primary); }

.type-image { width: 100%; max-width: 300px; display: block; margin: 0 auto 20px auto; border-radius: 15px; }
.catchphrase { font-size: 1.2rem; color: var(--primary); font-weight: 800; text-align: center; margin-bottom: 10px;}
.type-name { font-size: 2.2rem; color: #333; font-weight: 900; text-align: center; margin-bottom: 20px; line-height: 1.2;}

/* Diagnosis Inputs */
.name-input {
    width: 100%; padding: 15px 20px; border-radius: 15px; border: 2px solid #eee;
    font-size: 1rem; font-family: var(--font); outline: none; transition: border-color 0.3s;
    background: #fdfdfd; text-align: center; font-weight: bold;
}
.name-input:focus { border-color: var(--primary); background: #fff; }
.select-input {
    width: 100%; padding: 12px; border-radius: 12px; border: 1px solid #ddd;
    font-size: 0.95rem; font-family: var(--font); background: #fff; text-align: center;
}
.select-input-label { display: block; font-size: 0.8rem; color: #888; font-weight: bold; margin-bottom: 8px; text-align: center; }

/* Question UI */
.option-btn {
    display: block; width: 100%; padding: 16px; margin-bottom: 12px;
    background: #fff; border: 2px solid #f0f0f0; border-radius: 15px;
    font-size: 0.95rem; font-weight: 600; color: #555; cursor: pointer;
    transition: all 0.2s; box-shadow: 0 2px 8px rgba(0,0,0,0.02);
    text-align: left; position: relative;
}
.option-btn:hover { background: #fffcfc; border-color: var(--primary); transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
.option-btn.selected { 
    background: #fffafa; border-color: var(--primary); color: #d65c65; 
    box-shadow: 0 4px 15px rgba(255,183,178,0.25);
}
.option-btn.selected::after {
    content: '✨'; position: absolute; right: 15px; top: 50%; transform: translateY(-50%);
}

.ads-box { margin: 20px 0; text-align: center; display: block; clear: both; overflow: hidden; }

.match-box { display: flex; justify-content: space-between; gap: 10px; margin-top: 15px;}
.match-item { flex: 1; background: white; padding: 15px; border-radius: 15px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05);}
.share-btn { display: flex; justify-content: center; align-items: center; background: #000; color: #fff; text-decoration: none; font-weight: bold; padding: 15px; border-radius: 30px; margin-top: 25px;}

.banner { background: #333; text-align: center; padding: 12px; margin-bottom: 20px; border-radius: 12px; text-decoration: none; display: block; color: #fff; font-weight: bold; }

.question-view { display: none; }
.question-view.active { display: block; animation: slideInRight 0.4s ease-out; }
@keyframes slideInRight { from { opacity: 0; transform: translateX(30px); } to { opacity: 1; transform: translateX(0); } }
footer { margin-top:40px; margin-bottom:20px; text-align:center; font-size:0.8rem; color:#aaa; border-top:1px solid #eee; padding-top:20px; }`;
fs.writeFileSync(path.join(cssDir, 'main.css'), cssContent);

// Process mappings
const res = JSON.parse(fs.readFileSync('parsed_results.json'));
const qs = JSON.parse(fs.readFileSync('parsed_questions.json'));

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

// Write Logic JS
let logicJs = `const QUESTIONS = ${JSON.stringify(qs, null, 2)};\n`;
logicJs += `const TYPE_MAP = ${JSON.stringify(shortTypeMap, null, 2)};\n`;
logicJs += `
const TYPES = Object.keys(TYPE_MAP);
const state = { scores: {} };
TYPES.forEach(t => state.scores[t] = 0);

function handleAnswer(qIndex, choiceIndex) {
    const q = QUESTIONS[qIndex];
    const choice = q.choices[choiceIndex];
    // Add logic
    if (choice.superBonus) choice.superBonus.forEach(t => { if(t && state.scores[t]!==undefined) state.scores[t] += 50; });
    if (choice.bonus) choice.bonus.forEach(t => { if(t && state.scores[t]!==undefined) state.scores[t] += 20; });
    if (choice.instantDeath) choice.instantDeath.forEach(t => { if(t && state.scores[t]!==undefined) state.scores[t] -= 100; });
}

function getResult() {
    let max = -999;
    let candidates = [];
    for (let t of Object.keys(state.scores)) {
        if (state.scores[t] > max) {
            max = state.scores[t];
            candidates = [t];
        } else if (state.scores[t] === max) {
            candidates.push(t);
        }
    }
    const winner = candidates[Math.floor(Math.random() * candidates.length)];
    return TYPE_MAP[winner];
}
`;
function formatText(text, useMarkers = true) {
    if (!text) return '';
    const keywords = ['最強', '武器', '大切', '魅力', '自分軸', '周囲', '将来', 'ギャップ', '信頼', '成果', 'バランス', '無双', '圧倒的', '必須', 'ポイント', '意識', 'リアル', '本性'];
    let formatted = text;
    keywords.forEach(kw => {
        formatted = formatted.replace(new RegExp(kw, 'g'), '<b>' + kw + '</b>');
    });
    if (useMarkers) {
        // Wrap everything in 「」 with bold instead of marker to keep it clean
        formatted = formatted.replace(/「(.+?)」/g, '<b>「$1」</b>');
    }
    return formatted;
}

fs.writeFileSync(path.join(jsDir, 'logic.js'), logicJs);

// Generate Result Pages
Object.keys(res).forEach(t => {
    const data = res[t];
    const shortT = shortTypeMap[t];
    const imgName = mapping[t];

    if (t === 'OFMP') data.catchphrase = 'バ先が居場所の社畜アルバイター';
    if (t === 'ONMP') data.catchphrase = '平均点をたたき出すプロフェッショナル';
    
    let html = `<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>【公式】${data.name} | 大学生タイプ診断</title>

    <!-- SEO / OGP -->
    <meta property="og:url" content="https://sync-loft.com/collegetype16/types/${shortT}.html" />
    <meta property="og:type" content="article" />
    <meta property="og:title" content="【公式】大学生タイプ診断 - 結果は「${data.name}」" />
    <meta property="og:description" content="キャンパスに潜む16タイプの生態系！私の診断結果は【${data.name}】でした✨" />
    <meta property="og:site_name" content="大学生タイプ診断" />
    <meta property="og:image" content="https://sync-loft.com/collegetype16/ogp/${shortT}.png" />
    <meta name="twitter:card" content="summary_large_image" />

    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/main.css?v=1.0.4">
    <!-- Google AdSense -->
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3644642136582562" crossorigin="anonymous"></script>

    <!-- Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-1YJFPXNF0M"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-1YJFPXNF0M');
    </script>
</head>
<body>
    <nav class="global-header">
        <a href="../index.html" class="header-logo"><span style="font-size:1.2rem;">🏫</span> 大学生タイプ診断</a>
        <div class="header-nav">
            <a href="../diagnosis.html">診断を受ける</a>
            <a href="../list.html">16タイプ一覧</a>
            <a href="../../alctype16/index.html">🍺 酒タイプ診断</a>
        </div>
        <button class="menu-toggle" aria-label="Menu" onclick="document.getElementById('mobileMenu').classList.toggle('active')">☰</button>
    </nav>
    <div class="mobile-menu" id="mobileMenu" style="position:fixed;">
        <a href="../diagnosis.html">診断を受ける</a>
        <a href="../list.html">16タイプ一覧</a>
        <a href="../../alctype16/index.html">🍺 酒タイプ診断はこちら</a>
    </div>

    <div class="container fade-in" style="padding-top:20px;">
        <div class="glass-card" style="text-align: center;">
            <p id="userNameDisplay" style="font-weight:bold; color:#888;">あなたの診断結果は...</p>
            <div class="catchphrase">${data.catchphrase.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '')}</div>
            <h1 class="type-name">${data.name.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '')}</h1>
            <img src="../img/${imgName}" alt="${data.name}" class="type-image">
            <div style="text-align:left; font-size:0.95rem; line-height: 1.8;">
                ${formatText(data.desc.replace(/。/g, '。<br><br>'))}
            </div>
        </div>

        <a href="../../alctype16/index.html" class="banner" style="background: linear-gradient(135deg, #4a148c, #6a1b9a); border:none; color:#fff;">🍺 【元祖】酒タイプ診断はこちら！</a>

        <div class="glass-card">
            <h2 class="section-title">生態あるある</h2>
            <ul class="ecology-list">
                ${data.ecology.map(e => '<li>' + formatText(e) + '</li>').join('')}
            </ul>

            <h2 class="section-title">4年間の軌跡と卒業後</h2>
            <p><strong>【大学生活】</strong> ${formatText(data.trajectory.replace('【大学生活】', ''))}</p>
            <p><strong>【卒業後の姿】</strong> ${formatText(data.future.replace('【卒業後の姿】', ''))}</p>

            <h2 class="section-title">装備と立ち回り</h2>
            <p>📍 <strong>出没スポット：</strong> ${data.spots}</p>
            <p>🎒 <strong>必須アイテム：</strong> ${data.items}</p>
            <p>🍻 <strong>飲み会での立ち振る舞い：</strong><br>${formatText(data.role.replace(/^(<br>|\n)+/, ''))}</p>
            
            <h2 class="section-title">他タイプとの相性</h2>
            <div style="display:flex; flex-direction:column; gap:15px; margin-top:10px;">
                <div style="background:#f4ffe8; padding:15px; border-radius:15px; box-shadow:0 2px 8px rgba(0,0,0,0.03); border:1px solid #dcedc8;">
                    <span style="font-weight:bold; color:#558b2f; font-size:0.9rem; display:block; margin-bottom:5px;">🤝 最高に相性が良い</span>
                    <strong style="font-size:1.1rem; display:block; margin-bottom:5px;">
                        ${(() => {
                            const m = (data.goodMatch || '').split('<br>')[0].match(/[A-Z]{4}[（\(](.+?)[）\)]/);
                            return m ? m[1] : (data.goodMatch || '').split('<br>')[0].replace(/🤝|💡|💀|【.*?】|[*]/g, '').trim();
                        })()}
                    </strong>
                    <div style="font-size:0.9rem; color:#444; line-height:1.6;">${data.goodMatch ? data.goodMatch.split('<br>').slice(1).join('<br>').replace(/理由：/g, '<strong style="color:#558b2f;">理由：</strong>') : ''}</div>
                </div>
                <div style="background:#fff0f0; padding:15px; border-radius:15px; box-shadow:0 2px 8px rgba(0,0,0,0.03); border:1px solid #ffcdd2;">
                    <span style="font-weight:bold; color:#c62828; font-size:0.9rem; display:block; margin-bottom:5px;">💀 相性が悪い（天敵）</span>
                    <strong style="font-size:1.1rem; display:block; margin-bottom:5px;">
                        ${(() => {
                            const m = (data.badMatch || '').split('<br>')[0].match(/[A-Z]{4}[（\(](.+?)[）\)]/);
                            return m ? m[1] : (data.badMatch || '').split('<br>')[0].replace(/🤝|💡|💀|【.*?】|[*]/g, '').trim();
                        })()}
                    </strong>
                    <div style="font-size:0.9rem; color:#444; line-height:1.6;">${data.badMatch ? data.badMatch.split('<br>').slice(1).join('<br>').replace(/理由：/g, '<strong style="color:#c62828;">理由：</strong>') : ''}</div>
                </div>
            </div>
            
            <h2 class="section-title">迷えるあなたへのアドバイス</h2>
            <div style="background:#fffafa; padding:15px; border-radius:10px; color:#555; line-height:1.7;">
                ${(() => {
                    let adv = data.advice.replace(/\*/g, '');
                    const strongKeywords = ['最強', '大切', '武器', '自分軸', '魅力', '将来', '信頼', '無双', '圧倒的', '必須', 'ポイント', '必要', '大切'];
                    const normalKeywords = ['成果', 'バランス', '意識', 'リアル', '本性', 'ポイント', 'メリット', '親友'];
                    
                    normalKeywords.forEach(kw => { adv = adv.replace(new RegExp(kw, 'g'), `<b>${kw}</b>`); });
                    strongKeywords.forEach(kw => { adv = adv.replace(new RegExp(kw, 'g'), `<span class="bold-marker">${kw}</span>`); });
                    
                    // Specific quotes in advice get bold, not marker
                    adv = adv.replace(/「(.+?)」/g, '<b>「$1」</b>');
                    return adv;
                })()}
            </div>
            
            <a href="https://twitter.com/intent/tweet?text=${encodeURIComponent(`私の大学生タイプは【${data.name.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '')}】でした！\n\n#大学生タイプ診断\n\n診断してみる👇\nhttps://sync-loft.com/collegetype16/types/${shortT}.html`)}" class="share-btn" target="_blank" rel="noopener" style="margin-top:30px;">X (Twitter) でシェア</a>
            
            <!-- Ad unit in result -->
            <div class="ads-box">
                <ins class="adsbygoogle"
                     style="display:block"
                     data-ad-client="ca-pub-3644642136582562"
                     data-ad-slot="1628377322"
                     data-ad-format="auto"
                     data-full-width-responsive="true"></ins>
                <script>(adsbygoogle = window.adsbygoogle || []).push({});</script>
            </div>
        </div>

        <a href="../index.html" class="btn btn-primary" style="margin-top:20px;">もう一度診断する</a>
        <a href="../list.html" class="btn btn-secondary" style="margin-top:10px;">16タイプ一覧を見る</a>

        <footer style="margin-top:40px; margin-bottom:20px; text-align:center; font-size:0.8rem; color:#aaa; border-top:1px solid #eee; padding-top:20px;">
            <p style="margin-bottom:10px;">
                <a href="../policy.html" style="color:#888; text-decoration:underline;">プライバシーポリシー</a>
                <span style="margin: 0 10px; color:#eee;">|</span>
                <a href="../contact.html" style="color:#888; text-decoration:underline;">お問い合わせ</a>
            </p>
            <p>© 2024-2026 大学生タイプ診断 事務局</p>
        </footer>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const name = localStorage.getItem('college_user_name');
            if (name && name !== 'ゲスト') {
                document.getElementById('userNameDisplay').textContent = name + ' さんの診断結果は...';
            }
        });
    </script>
</body>
</html>`;
    fs.writeFileSync(path.join(typesDir, shortT + '.html'), html);
});

console.log("Built 16 result pages.");
