import os
import sys

base_dir = r'c:\Users\01051992\Desktop\NEWalctype16\alctype16'

def repair(path, is_en=False):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        file_id = os.path.splitext(os.path.basename(path))[0].upper()
        
        # 1. Strip suspicious chunks (cleanup from previous failed attempts)
        # We look for the last valid result-card or good match card.
        # Most files look like: ...</div></div> (end of cards)
        # Let's find the last '</div>' and assume everything after is junk if the file is broken.
        
        # Actually, let's keep it safe. If '</body>' is missing, it's definitely broken.
        if '</body>' not in content:
            print(f"Broken file found: {file_id}")
            # Find the last closing div of a card
            # In fody.html, it ends at Line 229: ...</div></div>
            last_div = content.rfind('</div>')
            if last_div != -1:
                content = content[:last_div+6] # Keep up to the last </div>
        else:
            # If it has </body> but maybe missing buttons?
            if 'share-section' not in content:
                print(f"Buttons missing in: {file_id}")
                # Strip from the first cleanup marker
                if '<div style="text-align:center;' in content:
                    content = content.split('<div style="text-align:center;')[0]
                elif '<!-- LINE stamp floating banner -->' in content:
                    content = content.split('<!-- LINE stamp floating banner -->')[0]
                else:
                    content = content.split('</body>')[0]
            else:
                return # Already fixed

        # Standard Footer Construction
        type_names = {
            "LOUT": "アル中番長", "LOUY": "ハイテンション時限爆弾", "LODT": "飲み参謀", "LODY": "爆発インキャ",
            "LRUT": "自称プロ幹事", "LRUY": "ちゃんとした人", "LRDT": "朝までうんちく先輩", "LRDY": "水泥棒",
            "FOUT": "酒飲み聖母", "FOUY": "情熱のたぎりモンスター", "FODT": "飲み飲みカウンセラー", "FODY": "涙腺崩壊ベビー",
            "FRUT": "酔いどれ学級委員長", "FRUY": "飲んだふり常習犯", "FRDT": "お会計くん", "FRDY": "空気読みすぎ天使"
        }
        name = type_names.get(file_id, file_id)
        
        share_title = "Share your result!" if is_en else "&#35386;&#26029;&#32080;&#26524;&#12434;&#12471;&#12455;&#12450;&#12375;&#12424;&#12358;&#65281;"
        rediag = "Diagnose Again" if is_en else "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;"
        back_top = "Back to TOP" if is_en else "TOP&#12506;&#12540;&#12472;&#12395;&#25147;&#12427;"
        
        share_msg = f"[Official] Sake Quiz Result: {file_id}" if is_en else f"【公式】酒タイプ診断の結果は…「{name} ({file_id})」でした！"
        url = f"https://sync-loft.com/alctype16/{'en/types' if is_en else 'types'}/{file_id.lower()}.html"
        
        footer = f"""
        <div class="share-section">
            <p class="share-title">{share_title}</p>
            <a href="https://twitter.com/intent/tweet?text={share_msg}&url={url}" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
            </a>
        </div>
        <a href="../index.html" class="rediagnosis-button">{rediag}</a>
        <div class="bottom-nav-wrapper">
            <a href="../index.html" class="bottom-nav-button primary">{back_top}</a>
        </div>
    </div>
    
  <!-- LINE stamp floating banner -->
  <a id="line-stamp-fab"
     href="https://store.line.me/stickershop/product/33138149/ja?utm_source=gnsh_stickerDetail"
     target="_blank" rel="noopener"
     onclick="typeof gtag==='function'&&gtag('event','line_stamp_click',{{event_category:'engagement',event_label:'floating_banner'}})">
      <span class="fab-badge">NEW</span>
      <div class="fab-inner">
          <span class="fab-icon">&#127867;</span>
          <span class="fab-label-main">LINEスタンプ<br>発売中！</span>
      </div>
  </a>
</body>
</html>
"""
        new_content = content.rstrip() + footer
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Fixed: {file_id}")

    except Exception as e:
        print(f"Error fixing {path}: {str(e)}")

# Process JP
d_jp = os.path.join(base_dir, 'types')
for f in os.listdir(d_jp):
    if f.endswith('.html'): repair(os.path.join(d_jp, f), False)

# Process EN
d_en = os.path.join(base_dir, 'en', 'types')
for f in os.listdir(d_en):
    if f.endswith('.html'): repair(os.path.join(d_en, f), True)

print("Repair completed.")
