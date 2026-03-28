// Roulette JS Logic
(function() {
    const typeData = {
        LOUT:{name:"アル中番長",catch:"お酒が強くて、ノリも最高！"},
        LOUY:{name:"ハイテンション時限爆弾",catch:"ノリは最高だが、体はガラス…"},
        LODT:{name:"飲み参謀",catch:"酔っても冷静、全て計算通り"},
        LODY:{name:"爆発インキャ",catch:"酔うと愚痴が止まらない"},
        LRUT:{name:"自称プロ幹事",catch:"完璧な飲み会設計"},
        LRUY:{name:"ちゃんとした人",catch:"酔う前にすべて出し切る"},
        LRDT:{name:"朝までうんちく先輩",catch:"情熱と理性を失わない"},
        LRDY:{name:"水泥棒",catch:"お酒は弱いが、しっかり反省"},
        FOUT:{name:"酒飲み聖母",catch:"お酒が強く、みんなに優しい"},
        FOUY:{name:"情熱のたぎりモンスター",catch:"お酒が弱く、愛情深い"},
        FODT:{name:"飲み飲みカウンセラー",catch:"無言で傾聴、無限の包容力"},
        FODY:{name:"涙腺崩壊ベビー",catch:"泣き上戸で、かまってちゃん"},
        FRUT:{name:"酔いどれ学級委員長",catch:"ルールを守りつつ楽しむ"},
        FRUY:{name:"飲んだふり常習犯",catch:"本当はお酒が弱いのに、ノリで飲む"},
        FRDT:{name:"お会計くん",catch:"見えないところで動く"},
        FRDY:{name:"空気読みすぎ天使",catch:"お酒は弱いが、迷惑はかけない"}
    };
    const typeMessages = {
        LOUT:"流石我らが番長！景気よくグイっと1杯いっちゃってください！",
        LOUY:"爆発寸前！時限爆弾が止まる前に、最後の一杯を流し込め！",
        LODT:"参謀의計算が狂った！？今日は理性を捨てて、ガツンと飲みましょう！",
        LODY:"心のダムが決壊寸前！本音を肴に、熱い一杯をどうぞ！",
        LRUT:"プロ幹事へのご褒美タイム！段取りを忘れて、主役として飲むべし！",
        LRUY:"ちゃんとした人の限界突破！明日への不安は飲み干して忘れよう！",
        LRDT:"うんちくのキレが増す一杯！喉を潤して、次なる講義の準備を！",
        LRDY:"お冷の前にビールを泥棒！翌朝の謝罪メールのネタができましたね！",
        FOUT:"聖母の愛でみんなを癒す一杯！笑顔で全肯定しながら乾杯！",
        FOUY:"たぎる情熱、抱きついてしまう愛！千鳥足でみんなに愛を振りまこう！",
        FODT:"聞き疲れた喉に潤いを！深夜の懺悔室、これにて一杯開店です！",
        FODY:"涙腺崩壊の着火剤！感動の波に乗って、エモく飲み干しましょう！",
        FRUT:"学級委員長の羽目を外す時！規律を忘れて、無礼講の始まりだ！",
        FRUY:"偽装工作失敗！バレたからには、漢気を見せて飲むしかない！",
        FRDT:"お会計の前にガソリン補給！数字を忘れて、どんぶり勘定で飲もう！",
        FRDY:"天使に舞い降りた一杯！空気読みの疲れを、この一杯で浄化せよ！"
    };
    const colors = ["#ffcdd2","#c8e6c9","#bbdefb","#fff9c4","#f8bbd0","#d1c4e9","#b2dfdb","#ffccbc"];
    let rouletteTypes = [], currentRotation = 0, isSpinning = false;

    document.addEventListener('DOMContentLoaded', function() {
        // Elements check
        const setupOverlay = document.getElementById('roulette-setup-overlay');
        const spinOverlay = document.getElementById('roulette-overlay');
        const resultOverlay = document.getElementById('roulette-result-overlay');
        const canvas = document.getElementById('roulette-canvas');
        if(!setupOverlay || !canvas) return; // Prevent errors on non-TOP pages
        
        const ctx = canvas.getContext('2d');

        // Render member list
        document.getElementById('roulette-member-list').innerHTML = Object.keys(typeData).map(code => {
            return `<div class="member-item"><img src="./酒タイプ画像/${code}.jpg" alt="${typeData[code].name}"><label for="mb-${code}">${typeData[code].name} (${code})</label><input type="checkbox" id="mb-${code}" value="${code}" checked></div>`;
        }).join('');

        // Provide window function for external FABs
        window.openRouletteSetup = function() {
            setupOverlay.classList.add('visible');
        };

        document.getElementById('close-roulette-setup-btn').addEventListener('click', function() { setupOverlay.classList.remove('visible'); });
        document.getElementById('roulette-select-all').addEventListener('click', function() { document.querySelectorAll('#roulette-member-list input').forEach(c=>c.checked=true); });
        document.getElementById('roulette-deselect-all').addEventListener('click', function() { document.querySelectorAll('#roulette-member-list input').forEach(c=>c.checked=false); });

        document.getElementById('create-roulette-btn').addEventListener('click', function() {
            rouletteTypes = Array.from(document.querySelectorAll('#roulette-member-list input:checked')).map(c=>c.value);
            if(rouletteTypes.length < 2) { alert('2つ以上のタイプを選んでください。'); return; }
            drawWheel(rouletteTypes);
            setupOverlay.classList.remove('visible');
            spinOverlay.classList.add('visible');
        });

        spinOverlay.addEventListener('click', function(e) { if(e.target === spinOverlay && !isSpinning) { spinOverlay.classList.remove('visible'); } });
        document.getElementById('spin-btn').addEventListener('click', spin);
        document.getElementById('spin-again-btn').addEventListener('click', function() { resultOverlay.classList.remove('visible'); document.getElementById('spin-btn').disabled=false; });
        document.getElementById('close-result-btn').addEventListener('click', function() { resultOverlay.classList.remove('visible'); spinOverlay.classList.remove('visible'); document.getElementById('spin-btn').disabled=false; });

        function drawWheel(types) {
            const n = types.length, arc = 2*Math.PI/n, sz = 500;
            canvas.width = sz; canvas.height = sz;
            ctx.clearRect(0,0,sz,sz);
            ctx.strokeStyle='white'; ctx.lineWidth=2;
            ctx.font = `bold ${n>10?'14':'18'}px 'M PLUS Rounded 1c', sans-serif`;
            for(let i=0;i<n;i++) {
                const a = i*arc;
                ctx.fillStyle=colors[i%colors.length];
                ctx.beginPath(); ctx.arc(sz/2,sz/2,sz/2-2,a,a+arc,false); ctx.arc(sz/2,sz/2,50,a+arc,a,true); ctx.stroke(); ctx.fill();
                ctx.save(); ctx.fillStyle="#333";
                ctx.translate(sz/2+Math.cos(a+arc/2)*150, sz/2+Math.sin(a+arc/2)*150); ctx.rotate(a+arc/2+Math.PI/2);
                ctx.fillText(types[i], -ctx.measureText(types[i]).width/2, 0); ctx.restore();
            }
            ctx.fillStyle='#ff4136'; ctx.beginPath(); ctx.arc(sz/2,sz/2,45,0,2*Math.PI); ctx.fill();
            ctx.fillStyle='white'; ctx.font='bold 18px "M PLUS Rounded 1c", sans-serif';
            ctx.fillText('乾杯!', sz/2-ctx.measureText('乾杯!').width/2, sz/2+6);
        }

        function spin() {
            if(isSpinning) return;
            isSpinning=true; document.getElementById('spin-btn').disabled=true;
            const totalRot = Math.random()*5+8, stopAngle=Math.random()*2*Math.PI;
            const target = currentRotation + totalRot*2*Math.PI + stopAngle;
            const dur = Math.random()*4000+7000;
            canvas.style.transition=`transform ${dur/1000}s cubic-bezier(.15,.75,.5,1)`;
            canvas.style.transform=`rotate(${target}rad)`;
            currentRotation=target;
            setTimeout(function() {
                isSpinning=false;
                canvas.style.transition='none';
                const final = target%(2*Math.PI);
                canvas.style.transform=`rotate(${final}rad)`;
                const arcSize=2*Math.PI/rouletteTypes.length;
                const rel=(2*Math.PI-final+3*Math.PI/2)%(2*Math.PI);
                const winner = rouletteTypes[Math.floor(rel/arcSize)];
                showWinner(winner);
            }, dur);
        }

        function showWinner(code) {
            document.getElementById('roulette-result-image').src=`./酒タイプ画像/${code}.jpg`;
            document.getElementById('roulette-result-title').textContent=`${typeData[code].name} (${code})`;
            document.getElementById('roulette-result-message').textContent=typeMessages[code]||'';
            resultOverlay.classList.add('visible');
        }
    });
})();
