const fs = require('fs');

const csv = fs.readFileSync('logic_utf8.csv', 'utf-8');
const lines = csv.split('\n').map(l => l.trim()).filter(l => l.length > 0);

// Types Mapping
const typeNameMap = {
    'ミスコン天使': 'OFAH',
    '意識高杉くん': 'OFAP',
    '意識高杉': 'OFAP', // alias in doc2
    'ハイスペ最強キャプテン': 'OFMH',
    'ハイスぺ最強キャプテン': 'OFMH', // alias
    'バイト戦士': 'OFMP',
    'さわやかバイト戦士': 'OFMP', // alias in CSV
    'どこでもメロつきウサギ': 'ONAH',
    'キョロキョロちゃん': 'ONAP',
    '語彙なしウェイウェイ': 'ONMH',
    'ふつうの大学生': 'ONMP',
    '話キクダケ': 'IFAH',
    '話聞くダケ': 'IFAH', // alias
    'しゃにかま星人': 'IFAP',
    '親のすねかじり虫': 'IFMH',
    'ガチ勉スライム': 'IFMP',
    '夢見がちバンドマン': 'INAH',
    '狂気の推し活コレクター': 'INAP',
    '留年ヤニカスジジイ': 'INMH',
    'いつまでも童貞くん': 'INMP',
};

const shortTypeMap = {
    'OFAH': 'type01',
    'OFAP': 'type02',
    'OFMH': 'type03',
    'OFMP': 'type04',
    'ONAH': 'type05',
    'ONAP': 'type06',
    'ONMH': 'type07',
    'ONMP': 'type08',
    'IFAH': 'type09',
    'IFAP': 'type10',
    'IFMH': 'type11',
    'IFMP': 'type12',
    'INAH': 'type13',
    'INAP': 'type14',
    'INMH': 'type15',
    'INMP': 'type16',
};

// Parse Questions
const questions = [];
let currentQ = null;

// skip header
for (let i = 2; i < lines.length; i++) {
    const line = lines[i];
    // manual csv split handling quotes
    const cols = [];
    let cur = '';
    let inQuote = false;
    for (let c of line) {
        if (c === '"') inQuote = !inQuote;
        else if (c === ',' && !inQuote) {
            cols.push(cur.trim());
            cur = '';
        } else cur += c;
    }
    cols.push(cur.trim());

    if (cols.length < 5) continue;

    const qNum = cols[0];
    const qText = cols[1];
    const choiceKey = cols[2];
    const choiceText = cols[3];
    const superBonusStr = cols[4];
    const bonusStr = cols[5];
    const deathStr = cols[6];

    if (qNum && qNum.startsWith('Q')) {
        currentQ = {
            id: parseInt(qNum.replace('Q','')),
            text: qText,
            choices: []
        };
        questions.push(currentQ);
    }

    if (currentQ && choiceKey) {
        const getCodes = str => {
            if(!str) return [];
            return str.replace(/"/g, '').split(/[,、]/).map(s=>s.trim()).filter(s=>s).map(s=> {
                let s2 = s.replace(/^[、,]+|[、,]+$/g, '').trim(); 
                return typeNameMap[s2] || null;
            }).filter(s=>s);
        };
        
        let superB = getCodes(superBonusStr);
        let bonus = getCodes(bonusStr);
        let death = getCodes(deathStr);

        currentQ.choices.push({
            key: choiceKey,
            text: choiceText,
            superBonus: superB,
            bonus: bonus,
            instantDeath: death
        });
    }
}

fs.writeFileSync('parsed_questions.json', JSON.stringify(questions, null, 2), 'utf-8');
console.log("Parsed Questions:", questions.length);

// Parse Results Text
const docText = fs.readFileSync('doc3_texts.txt', 'utf-8');
const docLines = docText.split('\n');
const results = {};
let curType = null;
let curSection = null;

for (let line of docLines) {
    line = line.trim();
    if (!line) continue;
    
    // Check type header e.g. "OFAH（ミスコン天使）"
    const mType = line.match(/^([OINFAHMP]{4})[（\(](.+?)[）\)]/);
    if (mType) {
        curType = mType[1];
        results[curType] = { code: curType, name: mType[2], catchphrase: '', desc: '', ecology: [], trajectory: '', future: '', spots: '', items: '', role: '', goodMatch: '', badMatch: '', advice: '' };
        curSection = null;
        continue;
    }

    if (!curType) continue;

    if (line.includes('1. 称号')) {
        curSection = 'title';
        const titleM = line.match(/称号【(.*?)】/);
        if (titleM) results[curType].catchphrase = titleM[1];
        else if (line.includes('【')) results[curType].catchphrase = line.split('【')[1].replace('】','');
        continue;
    }
    if (line.includes('▼タイプ説明')) { curSection = 'desc'; continue; }
    if (line.includes('2. 生態あるある')) { curSection = 'ecology'; continue; }
    
    if (line.includes('3. 大学') || line.includes('4年間の過ごし方')) { curSection = 'univ_prep'; continue; }
    if (line.includes('4. 装備')) { curSection = 'equip'; continue; }
    if (line.includes('出没スポット')) { results[curType].spots = line.replace(/.*出没スポット[：:]/, '').trim(); continue; }
    if (line.includes('必須アイテム')) { results[curType].items = line.replace(/.*必須アイテム[：:]/, '').trim(); continue; }
    if (line.includes('飲み会での役職') || line.includes('飲み会での立ち振る舞い')) { 
        curSection = 'role'; 
        results[curType].role = line.replace(/.*飲み会での役職[：:]/, '').replace(/.*飲み会での立ち振る舞い[：:]/, '').trim(); 
        continue; 
    }
    if (line.includes('5. 界隈') || line.includes('5. 他タイプとの相性')) { curSection = 'match'; continue; }
    if (line.includes('迷えるあなたへ')) { curSection = 'advice'; continue; }

    if (line.includes('【大学生活】')) {
        results[curType].trajectory += line.replace(/.*【大学生活】/, '').trim() + ' ';
        curSection = 'univ';
    } else if (line.includes('【卒業後の姿】') || line.includes('【卒業後】')) {
        results[curType].future += line.replace(/.*【卒業後の?姿?】/, '').trim() + ' ';
        curSection = 'future';
    } else if (line.includes('【最高に相性が良い】')) {
        curSection = 'good';
        results[curType].goodMatch = line.replace(/^\*\s*/, '').trim();
    } else if (line.includes('【相性が悪い】') || line.includes('【相性が悪い（天敵）】')) {
        curSection = 'bad';
        results[curType].badMatch = line.replace(/^\*\s*/, '').trim();
    } else {
        const clean = (s) => s.replace(/\*/g, '').replace(/_+/g, '').trim();
        // Appending flowing text
        if (curSection === 'desc') { results[curType].desc += clean(line) + ' '; }
        if (curSection === 'ecology') { if (line.includes('🗣️')) results[curType].ecology.push(clean(line.replace(/.*🗣️\s*/,''))); }
        if (curSection === 'univ') { results[curType].trajectory += clean(line) + ' '; }
        if (curSection === 'future') { results[curType].future += clean(line) + ' '; }
        if (curSection === 'role') { results[curType].role += '<br>' + clean(line); }
        if (curSection === 'good') { results[curType].goodMatch += '<br>' + clean(line); }
        if (curSection === 'bad') { results[curType].badMatch += '<br>' + clean(line); }
        if (curSection === 'advice') { results[curType].advice += clean(line) + ' '; }
    }
}

fs.writeFileSync('parsed_results.json', JSON.stringify(results, null, 2), 'utf-8');
console.log("Parsed Results:", Object.keys(results).length);
