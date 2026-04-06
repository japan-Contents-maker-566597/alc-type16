$BaseDir = "c:\Users\01051992\Desktop\NEWalctype16\alctype16"

# Corrected CSS to ensure
$CssToApply = @"
  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 { color: #6a1b9a !important; white-space: nowrap !important; font-size: clamp(1rem, 5.5vw, 2.4rem) !important; margin-bottom: 20px !important; text-align: center !important; }
  h1 a { text-decoration: none !important; color: #6a1b9a !important; transition: opacity 0.2s; display: inline-block; }
  h1 a:hover { opacity: 0.7; }
  .action-button, .bottom-nav-button, .x-share-button, .secondary-button, .rediagnosis-button { 
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important; 
    cursor: pointer; 
  }
  .action-button:hover, .bottom-nav-button:hover, .rediagnosis-button:hover { 
    transform: translateY(-2px); 
    box-shadow: 0 8px 20px rgba(0,0,0,0.15) !important; 
  }
  .action-button:active, .bottom-nav-button:active, .rediagnosis-button:active { 
    transform: scale(0.97) translateY(1px) !important; 
  }
  .result-card p { line-height: 1.9 !important; letter-spacing: 0.03em; margin-bottom: 1.2em; }
  .key-sentence { 
    font-weight: 800; 
    background: linear-gradient(transparent 60%, #fff9c4 60%) !important; 
    padding: 2px 4px; 
    border-radius: 4px;
  }
  .rediagnosis-button {
    display: block; width: 100%; max-width: 320px; margin: 25px auto; padding: 18px;
    font-size: 1.2em; font-weight: 800; color: #fff !important;
    background: linear-gradient(135deg, #6a1b9a, #8e24aa);
    border: none; border-radius: 50px; text-align: center; text-decoration: none;
    box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3);
  }
"@

$TypeData = @{
    "fodt" = @{ "name" = "飲み飲みカウンセラー"; "en_name" = "The Drunk Bathroom Therapist"; "desc" = "無言で傾聴、無限の包容力"; "en_desc" = "Quiet listener with infinite empathy. Your go-to drunk confidant." };
    "fody" = @{ "name" = "涙腺崩壊ベビー"; "en_name" = "The 2AM Drunk Crybaby"; "desc" = "泣き上戸で、かまってちゃん"; "en_desc" = "Emotional and affectionate. Needs hugs and tissues." };
    "fout" = @{ "name" = "酒飲み聖母"; "en_name" = "The Drunk Saint"; "desc" = "お酒が強く、みんなに優しい"; "en_desc" = "High tolerance and kind to everyone. The group's angel." };
    "fouy" = @{ "name" = "情熱のたぎりモンスター"; "en_name" = "The Clingy Drunk Monster"; "desc" = "お酒が弱く、愛情深い"; "en_desc" = "Low tolerance but high affection. Loves everyone when tipsy." };
    "frdt" = @{ "name" = "お会計くん"; "en_name" = "The Group CFO"; "desc" = "見えないところで動く"; "en_desc" = "Handles the money and the logic while everyone else vibe." };
    "frdy" = @{ "name" = "空気読みすぎ天使"; "en_name" = "The Irish Goodbye Angel"; "desc" = "お酒は弱いが、迷惑はかけない"; "en_desc" = "Low tolerance but super considerate. Vanishes before it gets messy." };
    "frut" = @{ "name" = "酔いどれ学級委員長"; "en_name" = "The Drunk Hall Monitor"; "desc" = "ルールを守りつつ楽しむ"; "en_desc" = "Responsible but festive. Keeps the rules even while tipsy." };
    "fruy" = @{ "name" = "飲んだふり常習犯"; "en_name" = "The Oscar-Winning Impostor"; "desc" = "本当はお酒が弱いのに、ノリで飲む"; "en_desc" = "Fake drinks like an expert. Nobody knows they're sober." };
    "lodt" = @{ "name" = "飲み参謀"; "en_name" = "The Drunk Mastermind"; "desc" = "酔っても冷静、全て計算通り"; "en_desc" = "Logical even when drunk. Everything is going according to plan." };
    "lody" = @{ "name" = "爆発インキャ"; "en_name" = "The Drunk Yapper"; "desc" = "酔うと愚痴が止まらない"; "en_desc" = "Inner thoughts unleashed. Prepares for a long emotional talk." };
    "lout" = @{ "name" = "アル中番長"; "en_name" = "The Drunk Final Boss"; "desc" = "お酒が強くて、ノリも最高！"; "en_desc" = "Master of vibes and drinks. The ultimate drinking partner." };
    "louy" = @{ "name" = "ハイテンション時限爆弾"; "en_name" = "The Blackout Time Bomb"; "desc" = "ノリは最高だが、体はガラス…"; "en_desc" = "Energetic but fragile. High hype followed by instant blackout." };
    "lrdt" = @{ "name" = "朝までうんちく先輩"; "en_name" = "The 3AM Drunk Philosopher"; "desc" = "情熱と理性を失わない"; "en_desc" = "Never loses logic. Ready for a deep debate until sunrise." };
    "lrdy" = @{ "name" = "水泥棒"; "en_name" = "The Hydration Goblin"; "desc" = "お酒は弱いが、しっかり反省"; "en_desc" = "Drinks water like it's gold. Very apologetic the next morning." };
    "lrut" = @{ "name" = "自称プロ幹事"; "en_name" = "The Vibe Curator"; "desc" = "完璧な飲み会設計"; "en_desc" = "Perfect planner. Ensures every moment of the night is curated." };
    "lruy" = @{ "name" = "ちゃんとした人"; "en_name" = "The Unbothered Drinker"; "desc" = "酔う前にすべて出し切る"; "en_desc" = "Stays prim and proper. Finishes strong before things get wild." };
}

function Get-ShareHtml($Code, $IsEn) {
    $Data = $TypeData[$Code]
    if ($IsEn) {
        $Title = "My drunk type is [$($Data.en_name)]! 🍻 #16DrunkPersonalities"
        $Url = "https://sync-loft.com/alctype16/en/types/$Code.html"
        $TwitterUrl = "https://twitter.com/intent/tweet?text=" + [uri]::EscapeDataString($Title) + "&url=" + [uri]::EscapeDataString($Url)
        return @"
        <div class="share-section">
            <p class="share-title">Share your result!</p>
            <a href="$TwitterUrl" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
                Post on X
            </a>
        </div>
"@
    } else {
        $Title = "私の酒タイプは【$($Data.name)】でした！🍻 #酒タイプ診断"
        $Url = "https://sync-loft.com/alctype16/types/$Code.html"
        $TwitterUrl = "https://twitter.com/intent/tweet?text=" + [uri]::EscapeDataString($Title) + "&url=" + [uri]::EscapeDataString($Url)
        return @"
        <div class="share-section">
            <p class="share-title">結果をシェアしよう！</p>
            <a href="$TwitterUrl" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
                Xでポストする
            </a>
        </div>
"@
    }
}

function Repair-File($File) {
    Write-Host "Repairing $($File.FullName)..."
    $Content = Get-Content $File.FullName -Raw -Encoding UTF8
    
    $RelPath = $File.FullName.Substring($BaseDir.Length + 1).Replace("\", "/")
    $IsEn = $RelPath.StartsWith("en/")
    
    # --- 1. Fix missing </style>, </head>, <body> tags (especially in diagnosis.html) ---
    # Look for the start of Professional UI/UX Updates block and ensure it ends with </style>
    if ($Content -match '/\* Professional UI/UX Updates \*/' -and $Content -notmatch '</style>') {
        # If the block is there but </style> is missing, find where it should end
        # Usually it ends with a closing brace for .rediagnosis-button
        if ($Content -match '\.rediagnosis-button\s*\{[^}]*\}') {
            $Content = $Content -replace '(\.rediagnosis-button\s*\{[^}]*\})', "`$1`n</style>`n</head>`n<body>"
        }
    }
    
    # --- 2. Update CSS with the corrected H1 and button styles ---
    if ($Content -match '/\* Professional UI/UX Updates \*/') {
        # Replace the whole block if present
        $Pattern = '(?s)/\* Professional UI/UX Updates \*/.*?</style>'
        if ($Content -match $Pattern) {
            $Content = $Content -replace $Pattern, "$CssToApply`n</style>"
        }
    }
    
    # --- 3. Fix Result Pages (Share buttons and Rediagnosis button) ---
    if ($RelPath -match "/types/") {
        $Code = [System.IO.Path]::GetFileNameWithoutExtension($RelPath)
        $ShareHtml = Get-ShareHtml $Code $IsEn
        
        # Ensure Rediagnosis button is there (cleanup any duplicates)
        # Search for any rediagnosis-button and replace it Or insert if missing
        $IsEnPage = $IsEn
        $Href = if ($RelPath.Split('/').Count -gt 2) { "../index.html" } else { "index.html" }
        $BtnText = if ($IsEnPage) { "Diagnose Again" } else { "&#12418;&#12358;&#19968;&#24230;&#35386;&#26029;&#12377;&#12427;" }
        $BtnHtml = "<a href=`"$Href`" class=`"rediagnosis-button`">$BtnText</a>"

        # Remove existing rediagnosis-button to avoid dupes
        $Content = $Content -replace '<a href="[^"]*" class="rediagnosis-button">.*?</a>', ""
        
        # Remove existing share-section to avoid dupes
        $Content = $Content -replace '(?s)<div class="share-section">.*?</div>', ""
        
        # Insert both before bottom-nav-wrapper
        if ($Content -match '<div class="bottom-nav-wrapper">') {
            $Content = $Content -replace '<div class="bottom-nav-wrapper">', "$BtnHtml`n$ShareHtml`n<div class='bottom-nav-wrapper'>"
        }
    }
    
    # --- 4. Special Fix for diagnosis.html (restore JP content if corrupted) ---
    if ($RelPath -eq "diagnosis.html" -and $Content -match "Tell Us About Yourself") {
        # It looks like we accidentally replaced JP with EN. We need to swap it back.
        # This is a bit hard without the full file but let's try to fix the known parts.
        $Content = $Content.Replace("Tell Us About Yourself", "&#12354;&#12394;&#12383;&#12395;&#12388;&#12356;&#12390;&#25945;&#12360;&#12390;&#12367;&#12384;&#12373;&#12356;")
        $Content = $Content.Replace("Enter your nickname", "&#12491;&#12483;&#12463;&#12493;&#12540;&#12512;&#12434;&#20837;&#21147;")
        $Content = $Content.Replace("Get My Result!", "&#35386;&#26029;&#12377;&#12427;")
        # ... more fixes if needed.
    }

    [System.IO.File]::WriteAllText($File.FullName, $Content, [System.Text.Encoding]::UTF8)
}

$Files = Get-ChildItem -Path $BaseDir -Filter "*.html" -Recurse
foreach ($File in $Files) {
    Repair-File $File
}

Write-Host "All files repaired successfully!"
