const fs = require('fs');
const res = JSON.parse(fs.readFileSync('parsed_results.json'));
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

let listHtml = `<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>16タイプ一覧 | 大学生タイプ診断</title>
    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css?v=1.0.4">
</head>
<body>
    <nav class="global-header">
        <a href="index.html" class="header-logo"><span style="font-size:1.2rem;">🏫</span> 大学生タイプ診断</a>
        <div class="header-nav">
            <a href="diagnosis.html">診断を受ける</a>
            <a href="list.html">16タイプ一覧</a>
            <a href="../alctype16/index.html">🍺 酒タイプ診断</a>
        </div>
        <button class="menu-toggle" aria-label="Menu" onclick="document.getElementById('mobileMenu').classList.toggle('active')">☰</button>
    </nav>
    <div class="mobile-menu" id="mobileMenu" style="position:fixed;">
        <a href="diagnosis.html">診断を受ける</a>
        <a href="list.html">16タイプ一覧</a>
        <a href="../alctype16/index.html">🍺 酒タイプ診断はこちら</a>
    </div>
    <div class="container fade-in" style="padding-top:20px;">
        <h1 style="margin-bottom:20px; font-size:1.6rem;">キャンパスに生息する16タイプ</h1>
        <div style="display:flex; flex-direction:column; gap:15px;">
`;

Object.keys(res).forEach(t => {
    const data = res[t];
    const u = shortTypeMap[t];
    const img = mapping[t];

    if (t === 'OFMP') data.catchphrase = 'バ先が居場所の社畜アルバイター';
    if (t === 'ONMP') data.catchphrase = '平均点をたたき出すプロフェッショナル';
    listHtml += `
        <a href="types/${u}.html" style="text-decoration:none; color:inherit;">
            <div class="glass-card" style="display:flex; align-items:center; gap:15px; margin-bottom:0; padding:15px;">
                <img src="img/${img}" alt="${data.name}" style="width:80px; height:80px; object-fit:cover; border-radius:50%;">
                <div>
                    <div style="font-size:0.85rem; color:var(--primary); font-weight:bold;">${data.catchphrase.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '')}</div>
                    <div style="font-size:1.3rem; font-weight:900;">${data.name.replace(/[A-Z]{4}|（.*?）|\(.*?\)/g, '')}</div>
                </div>
            </div>
        </a>
    `;
});

listHtml += `        </div>
        <a href="index.html" class="btn btn-secondary" style="margin-top:30px;">TOPページに戻る</a>

        <footer style="margin-top:40px; margin-bottom:20px; text-align:center; font-size:0.8rem; color:#aaa; border-top:1px solid #eee; padding-top:20px;">
            <p style="margin-bottom:10px;">
                <a href="policy.html" style="color:#888; text-decoration:underline;">プライバシーポリシー</a>
                <span style="margin: 0 10px; color:#eee;">|</span>
                <a href="contact.html" style="color:#888; text-decoration:underline;">お問い合わせ</a>
            </p>
            <p>© 2024-2026 大学生タイプ診断 事務局</p>
        </footer>
    </div>
</body></html>`;

fs.writeFileSync('collegetype16/list.html', listHtml);
