const QUESTIONS = [
  {
    "id": 1,
    "text": "現在のメインの収入源と、お金の使い方は？",
    "choices": [
      {
        "key": "A",
        "text": "「実家・仕送り・お小遣い」がメインで、生活には困っていない",
        "superBonus": [
          "IFMH",
          "OFAH"
        ],
        "bonus": [
          "IFAP",
          "ONAP"
        ],
        "instantDeath": [
          "IFMP",
          "OFMP",
          "INMH",
          "INAP"
        ]
      },
      {
        "key": "B",
        "text": "「自分の労働（バイトやインターン）」で稼いだお金がメイン",
        "superBonus": [
          "OFMP",
          "OFAP"
        ],
        "bonus": [
          "IFAH",
          "ONMP"
        ],
        "instantDeath": [
          "IFMH"
        ]
      },
      {
        "key": "C",
        "text": "仕送りやバイト代がメインだが、「趣味や遊び」ですぐに消える",
        "superBonus": [
          "INMH",
          "ONMH"
        ],
        "bonus": [
          "ONAH",
          "INAH"
        ],
        "instantDeath": [
          "OFAP",
          "IFMP",
          "IFMH"
        ]
      },
      {
        "key": "D",
        "text": "「お金を使うイベント」をあまりしないため、そこそこ貯まっている",
        "superBonus": [
          "INMP",
          "IFMP"
        ],
        "bonus": [
          "IFAP"
        ],
        "instantDeath": [
          "OFAP",
          "IFMH"
        ]
      }
    ]
  },
  {
    "id": 2,
    "text": "所属している、または一番居心地が良いコミュニティは？",
    "choices": [
      {
        "key": "A",
        "text": "結果や成長が求められる体育会・長期インターン・意識高い系団体",
        "superBonus": [
          "OFMH",
          "OFAP"
        ],
        "bonus": [
          "OFAH"
        ],
        "instantDeath": [
          "INMP",
          "ONMP",
          "INMH",
          "INAH"
        ]
      },
      {
        "key": "B",
        "text": "居心地の良いサークルやバイト先など、仲の良いコミュニティ",
        "superBonus": [
          "ONMH",
          "OFMP",
          "ONMP"
        ],
        "bonus": [
          "ONAH",
          "ONAP"
        ],
        "instantDeath": [
          "IFMP",
          "IFAP"
        ]
      },
      {
        "key": "C",
        "text": "推し活やバンドなど、共通の趣味によって繋がった界隈",
        "superBonus": [
          "INAH",
          "INMP"
        ],
        "bonus": [
          "INMH",
          "IFAH",
          "INAP"
        ],
        "instantDeath": [
          "OFMH",
          "ONAP",
          "ONMP"
        ]
      },
      {
        "key": "D",
        "text": "どこにも所属せず、基本自分一人のための時間を使っている",
        "superBonus": [
          "IFMP",
          "IFAP",
          "INMH"
        ],
        "bonus": [
          "INMP"
        ],
        "instantDeath": [
          "OFAH",
          "OFMH",
          "ONMH"
        ]
      }
    ]
  },
  {
    "id": 3,
    "text": "金曜日の夜、よくある過ごし方は？",
    "choices": [
      {
        "key": "A",
        "text": "居酒屋やクラブで、大人数でワイワイ飲む",
        "superBonus": [
          "ONAH",
          "ONMH",
          "OFMH"
        ],
        "bonus": [
          "ONMP"
        ],
        "instantDeath": [
          "INMP",
          "IFMP",
          "IFAP"
        ]
      },
      {
        "key": "B",
        "text": "オシャレな店や話題のスポットで、食事やカフェを楽しむ",
        "superBonus": [
          "OFAH",
          "IFMH"
        ],
        "bonus": [
          "OFAP",
          "IFAH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "C",
        "text": "自分の部屋で、趣味（推し、ゲーム、ネット）に没頭している",
        "superBonus": [
          "INMP"
        ],
        "bonus": [
          "INAH",
          "IFAP",
          "INAP"
        ],
        "instantDeath": [
          "OFAH",
          "ONMH"
        ]
      },
      {
        "key": "D",
        "text": "いつものメンバーとダラダラ語り明かしたり、通話したりする",
        "superBonus": [
          "ONAP",
          "OFMP",
          "ONMP"
        ],
        "bonus": [
          "INMH"
        ],
        "instantDeath": [
          "OFAP"
        ]
      }
    ]
  },
  {
    "id": 4,
    "text": "大学の授業・成績に対するスタンスは？",
    "choices": [
      {
        "key": "A",
        "text": "就活や将来のために、高成績を目指して真面目に受けている",
        "superBonus": [
          "IFMP",
          "OFAP"
        ],
        "bonus": [
          "OFAH"
        ],
        "instantDeath": [
          "INMH",
          "ONMP",
          "ONMH"
        ]
      },
      {
        "key": "B",
        "text": "成績にこだわりはなく、コスパ良く単位を取ることだけを考えている",
        "superBonus": [
          "IFAP",
          "ONAP"
        ],
        "bonus": [
          "OFMH",
          "IFAH",
          "ONMP"
        ],
        "instantDeath": [
          "IFMP"
        ]
      },
      {
        "key": "C",
        "text": "授業に行けない日も多く、留年が常にチラついている",
        "superBonus": [
          "INMH",
          "INAH",
          "ONMH"
        ],
        "bonus": [
          "ONAH"
        ],
        "instantDeath": [
          "OFAP",
          "IFMP"
        ]
      },
      {
        "key": "D",
        "text": "真面目に授業に出席し、それなりの成績をキープしている",
        "superBonus": [
          "INMP",
          "ONMP"
        ],
        "bonus": [
          "INAP",
          "OFMP",
          "IFMH"
        ],
        "instantDeath": [
          "OFAP"
        ]
      }
    ]
  },
  {
    "id": 5,
    "text": "ファッションや見た目へのこだわりは？",
    "choices": [
      {
        "key": "A",
        "text": "美容やブランドものなどに惜しみなくお金をかける",
        "superBonus": [
          "OFAH",
          "IFMH"
        ],
        "bonus": [
          "ONAH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "B",
        "text": "古着や特定のテイストなど、こだわりや個性を出したい",
        "superBonus": [
          "INAH"
        ],
        "bonus": [
          "INAP",
          "ONAH"
        ],
        "instantDeath": [
          "OFMH",
          "OFAP"
        ]
      },
      {
        "key": "C",
        "text": "動きやすいスウェットや部活着が一番落ち着く",
        "superBonus": [
          "OFMH",
          "ONMH"
        ],
        "bonus": [
          "INMH"
        ],
        "instantDeath": [
          "OFAH",
          "IFMH"
        ]
      },
      {
        "key": "D",
        "text": "特にこだわりはなく、周りから浮かない無難な服を選ぶ",
        "superBonus": [
          "ONMP"
        ],
        "bonus": [
          "INMP",
          "IFMP",
          "OFMP",
          "ONAP"
        ],
        "instantDeath": [
          "INAH",
          "OFAH"
        ]
      }
    ]
  },
  {
    "id": 6,
    "text": "SNS（InstagramやXなど）での発信内容は？",
    "choices": [
      {
        "key": "A",
        "text": "自分の盛れた写真や、美味しいご飯などの充実した日常",
        "superBonus": [
          "OFAH",
          "ONAH"
        ],
        "bonus": [
          "ONMH",
          "IFMH"
        ],
        "instantDeath": [
          "IFMP",
          "INMP",
          "IFAP"
        ]
      },
      {
        "key": "B",
        "text": "ニュースや身の周りの出来事についての意見や考察",
        "superBonus": [
          "IFAP",
          "OFAP"
        ],
        "bonus": [
          "INAH"
        ],
        "instantDeath": [
          "ONMP"
        ]
      },
      {
        "key": "C",
        "text": "趣味や推しについての発信や、情報収集・拡散",
        "superBonus": [
          "INAP",
          "INMP"
        ],
        "bonus": [
          "IFMP",
          "IFAH"
        ],
        "instantDeath": [
          "OFAH"
        ]
      },
      {
        "key": "D",
        "text": "内輪ノリなど、身内向けの投稿や、見る専（ROM）",
        "superBonus": [
          "ONMP",
          "ONAP"
        ],
        "bonus": [
          "OFMP",
          "OFMH"
        ],
        "instantDeath": [
          "IFAP"
        ]
      }
    ]
  },
  {
    "id": 7,
    "text": "自分が一番うれしい瞬間は？",
    "choices": [
      {
        "key": "A",
        "text": "より多くの人に「すごい！」「いいね！」と褒められた時",
        "superBonus": [
          "ONAP",
          "OFAH"
        ],
        "bonus": [
          "OFMH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "B",
        "text": "圧倒的な実績や数字を叩き出し、自分が上のステージに行けた時",
        "superBonus": [
          "OFAP",
          "OFMH",
          "OFAH"
        ],
        "bonus": [
          "IFAH"
        ],
        "instantDeath": [
          "INAP",
          "ONMP"
        ]
      },
      {
        "key": "C",
        "text": "自分のこだわりや趣味を、誰かが深く理解してくれた時",
        "superBonus": [
          "INAH",
          "INAP"
        ],
        "bonus": [
          "ONAH",
          "INMH"
        ],
        "instantDeath": [
          "OFMH"
        ]
      },
      {
        "key": "D",
        "text": "給料日が来た時や連休が来た時など、平穏なご褒美がある時",
        "superBonus": [
          "OFMP",
          "ONMP"
        ],
        "bonus": [
          "IFMP",
          "INMP"
        ],
        "instantDeath": [
          "OFAP",
          "OFAH"
        ]
      }
    ]
  },
  {
    "id": 8,
    "text": "友達から真剣な悩みを相談されたら？",
    "choices": [
      {
        "key": "A",
        "text": "「わかる?」と全力で共感し、自分のことのように寄り添う",
        "superBonus": [
          "IFAH"
        ],
        "bonus": [
          "ONAH",
          "INAH",
          "ONMH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "B",
        "text": "論理的に原因を分析し、「正解」を提示して解決に導こうとする",
        "superBonus": [
          "IFAP",
          "OFAP"
        ],
        "bonus": [
          "OFMH"
        ],
        "instantDeath": [
          "ONMH"
        ]
      },
      {
        "key": "C",
        "text": "「とりあえず酒飲んで忘れようぜ！」とその場を楽しく盛り上げる",
        "superBonus": [
          "ONMH",
          "OFMH"
        ],
        "bonus": [
          "ONAP",
          "OFMP"
        ],
        "instantDeath": [
          "IFAP",
          "INMP"
        ]
      },
      {
        "key": "D",
        "text": "適当に相槌を打って、早く自分の時間に戻りたいと考える",
        "superBonus": [
          "INMH",
          "INMP"
        ],
        "bonus": [
          "IFMH",
          "INAP"
        ],
        "instantDeath": [
          "IFAH",
          "OFAP"
        ]
      }
    ]
  },
  {
    "id": 9,
    "text": "スマホを見ている時、一番開いているアプリは？",
    "choices": [
      {
        "key": "A",
        "text": "LINEやDMなど、他人とのコミュニケーションツール",
        "superBonus": [
          "ONAH",
          "IFAH",
          "ONMH"
        ],
        "bonus": [
          "OFAH",
          "ONAP"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "B",
        "text": "TikTokやショート動画など、脳死で見られるエンタメ",
        "superBonus": [
          "ONMP"
        ],
        "bonus": [
          "INMH",
          "OFMP"
        ],
        "instantDeath": [
          "OFAP"
        ]
      },
      {
        "key": "C",
        "text": "XやDiscord、またはソシャゲなど、趣味の界隈のツール",
        "superBonus": [
          "INMP",
          "IFAP"
        ],
        "bonus": [
          "INAH",
          "INAP"
        ],
        "instantDeath": [
          "OFMH",
          "OFAH"
        ]
      },
      {
        "key": "D",
        "text": "スケジュール管理やニュース、または特に目的なくスマホをいじる",
        "superBonus": [
          "OFAP",
          "IFMP"
        ],
        "bonus": [
          "OFMH"
        ],
        "instantDeath": [
          "ONAH",
          "ONMP"
        ]
      }
    ]
  },
  {
    "id": 10,
    "text": "まとまったお金（10万円）が手に入ったら？",
    "choices": [
      {
        "key": "A",
        "text": "投資、資格勉強、PC新調など自分の将来の価値を高めるために使う",
        "superBonus": [
          "OFAP",
          "IFMP"
        ],
        "bonus": [
          "OFMP"
        ],
        "instantDeath": [
          "INMH",
          "ONMH"
        ]
      },
      {
        "key": "B",
        "text": "推し活やギャンブルなど、自分が一番気持ちよくなれることに全ツッパする",
        "superBonus": [
          "INAP",
          "INMH"
        ],
        "bonus": [
          "ONAH",
          "INAH",
          "ONMH"
        ],
        "instantDeath": [
          "IFMP",
          "OFAP"
        ]
      },
      {
        "key": "C",
        "text": "ブランド物やいいレストランなど、高級感やステータスを味わうために使う",
        "superBonus": [
          "OFAH",
          "IFMH"
        ],
        "bonus": [
          "IFAH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP"
        ]
      },
      {
        "key": "D",
        "text": "とりあえず全額貯金するか、奨学金の返済や生活費の足しにする",
        "superBonus": [
          "OFMP",
          "IFMP"
        ],
        "bonus": [
          "ONMP"
        ],
        "instantDeath": [
          "IFMH"
        ]
      }
    ]
  },
  {
    "id": 11,
    "text": "恋愛に対するスタンスは？",
    "choices": [
      {
        "key": "A",
        "text": "恋愛好きで、出会いの場には積極的に足を運ぶ",
        "superBonus": [
          "ONAH",
          "IFAH",
          "ONMH"
        ],
        "bonus": [
          "INMH"
        ],
        "instantDeath": [
          "INMP",
          "IFMP",
          "IFAP"
        ]
      },
      {
        "key": "B",
        "text": "恋人は欲しいが、自分からガツガツ行くのは少し恥ずかしい",
        "superBonus": [
          "ONAP",
          "OFAH"
        ],
        "bonus": [
          "IFMH",
          "INMP"
        ],
        "instantDeath": [
          "ONAH",
          "IFAH"
        ]
      },
      {
        "key": "C",
        "text": "恋愛よりも、趣味や友達が優先で、そこまで重要視していない",
        "superBonus": [
          "INMP",
          "INAP"
        ],
        "bonus": [
          "IFMP"
        ],
        "instantDeath": [
          "ONAH",
          "IFAH"
        ]
      },
      {
        "key": "D",
        "text": "出会いの場に行かなくても、今のコミュニティで十分満足している/興味がない",
        "superBonus": [
          "OFMH",
          "OFMP",
          "ONMP"
        ],
        "bonus": [
          "INAH"
        ],
        "instantDeath": [
          "INMP"
        ]
      }
    ]
  },
  {
    "id": 12,
    "text": "キャンパスで顔見知りを見つけたら？",
    "choices": [
      {
        "key": "A",
        "text": "手を振って自分から声をかけにいく（たとえそこまで親しくなくても）",
        "superBonus": [
          "OFMH",
          "ONMH"
        ],
        "bonus": [
          "OFMP",
          "ONMP"
        ],
        "instantDeath": [
          "INMP",
          "IFAP",
          "OFAP"
        ]
      },
      {
        "key": "B",
        "text": "気づかないフリをしてスマホを見るか、通り過ぎるのを待つ",
        "superBonus": [
          "ONAP",
          "ONMP"
        ],
        "bonus": [
          "INMH",
          "INAH"
        ],
        "instantDeath": [
          "OFMH"
        ]
      },
      {
        "key": "C",
        "text": "絶対に目を合わせず、歩くルートを変えてでも回避する",
        "superBonus": [
          "INMP",
          "IFAP"
        ],
        "bonus": [
          "INAP",
          "IFMP"
        ],
        "instantDeath": [
          "ONMH",
          "ONAP"
        ]
      },
      {
        "key": "D",
        "text": "自分にとって話すメリットがあれば声をかけるが、それ以外はスルー",
        "superBonus": [
          "OFAP",
          "IFAH"
        ],
        "bonus": [
          "OFAH",
          "IFMH"
        ],
        "instantDeath": [
          "INMP"
        ]
      }
    ]
  },
  {
    "id": 13,
    "text": "恋人や親友に一番求めるものは？",
    "choices": [
      {
        "key": "A",
        "text": "学歴、ルックスなどのステータスや、周りに自慢できるかどうか",
        "superBonus": [
          "OFAH",
          "OFAP",
          "INMP"
        ],
        "bonus": [
          "IFMH",
          "ONAH"
        ],
        "instantDeath": [
          "INMH",
          "ONMH"
        ]
      },
      {
        "key": "B",
        "text": "性格の相性や居心地の良さ、一緒にいて素が出せるかどうか",
        "superBonus": [
          "ONMH",
          "OFMP"
        ],
        "bonus": [
          "OFMH",
          "ONMP"
        ],
        "instantDeath": [
          "IFAP"
        ]
      },
      {
        "key": "C",
        "text": "趣味や好きなことが共通しているか、自分の世界観を否定しないか",
        "superBonus": [
          "INAH"
        ],
        "bonus": [
          "INMP",
          "INAP"
        ],
        "instantDeath": [
          "OFAP"
        ]
      },
      {
        "key": "D",
        "text": "恋愛にあまり興味が無い、または一人の時間が一番大事",
        "superBonus": [
          "IFAP",
          "IFMP"
        ],
        "bonus": [
          "INMH",
          "INMP"
        ],
        "instantDeath": [
          "ONAH"
        ]
      }
    ]
  },
  {
    "id": 14,
    "text": "今、一番の悩みや不安は？",
    "choices": [
      {
        "key": "A",
        "text": "自分が他人からどう見られているかが常に気になってしまう",
        "superBonus": [
          "ONAP",
          "ONAH"
        ],
        "bonus": [
          "OFAH",
          "IFAH"
        ],
        "instantDeath": [
          "OFMH"
        ]
      },
      {
        "key": "B",
        "text": "自分は周りより優秀なのに、正当に評価されていない気がする",
        "superBonus": [
          "IFAP"
        ],
        "bonus": [
          "OFAP",
          "OFAH",
          "INMH",
          "INAH"
        ],
        "instantDeath": [
          "ONMH"
        ]
      },
      {
        "key": "C",
        "text": "自分が熱中できる、心の拠り所が無いと不安になる",
        "superBonus": [
          "INAP"
        ],
        "bonus": [
          "IFMP"
        ],
        "instantDeath": [
          "OFMH",
          "IFMH"
        ]
      },
      {
        "key": "D",
        "text": "日々楽しく過ごしているので、特になにもない/お金がないくらい",
        "superBonus": [
          "OFMH",
          "ONMH",
          "INMH"
        ],
        "bonus": [
          "ONMP"
        ],
        "instantDeath": [
          "IFAP",
          "INAH"
        ]
      }
    ]
  },
  {
    "id": 15,
    "text": "最終的に、どんな人生を送りたい？",
    "choices": [
      {
        "key": "A",
        "text": "より良い将来に繋がるキャリアとステータスを手に入れ、勝ち組になりたい",
        "superBonus": [
          "OFAP",
          "OFAH",
          "IFMP",
          "OFMH"
        ],
        "bonus": [
          "IFMH"
        ],
        "instantDeath": [
          "ONMP",
          "INMH"
        ]
      },
      {
        "key": "B",
        "text": "友人や恋人と、何歳になっても楽しい思い出を共有して生きていきたい",
        "superBonus": [
          "ONMP"
        ],
        "bonus": [
          "OFMH",
          "ONAP",
          "ONMH"
        ],
        "instantDeath": [
          "IFAP",
          "INMP"
        ]
      },
      {
        "key": "C",
        "text": "恋愛、推し活など、ひたすら自分のしたいことをやり尽くす人生にしたい",
        "superBonus": [
          "ONAH",
          "INAP"
        ],
        "bonus": [
          "IFAH",
          "ONMH",
          "INMH",
          "INAH"
        ],
        "instantDeath": [
          "IFMP",
          "OFAP"
        ]
      },
      {
        "key": "D",
        "text": "誰にも邪魔されず、平穏に過ごすことができればそれでいい",
        "superBonus": [
          "INMP",
          "IFAP"
        ],
        "bonus": [
          "ONMP",
          "IFMH"
        ],
        "instantDeath": [
          "OFAH",
          "OFMH"
        ]
      }
    ]
  }
];
const TYPE_MAP = {
  "OFAH": "type01",
  "OFAP": "type02",
  "OFMH": "type03",
  "OFMP": "type04",
  "ONAH": "type05",
  "ONAP": "type06",
  "ONMH": "type07",
  "ONMP": "type08",
  "IFAH": "type09",
  "IFAP": "type10",
  "IFMH": "type11",
  "IFMP": "type12",
  "INAH": "type13",
  "INAP": "type14",
  "INMH": "type15",
  "INMP": "type16"
};

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
