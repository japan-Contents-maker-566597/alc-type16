import os
import re

base_dir = r'c:\Users\01051992\Desktop\NEWalctype16\alctype16'
types_dir = os.path.join(base_dir, 'types')
en_types_dir = os.path.join(base_dir, 'en', 'types')

def repair_result_page(filepath, is_en=False):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # If the file already has a complete bottom (Share, Rediagnosis, BottomNav), skip unless it's truncated
    if 'share-section' in content and 'rediagnosis-button' in content and 'bottom-nav-wrapper' in content and '</body>' in content:
        # Check for duplication and remove extra FABs
        fab_marker = '<!-- LINE stamp floating banner -->'
        if content.count(fab_marker) > 1:
            parts = content.split(fab_marker)
            # Keep parts[0] + fab_marker + parts[1] (assuming the first one is the intended location or CSS handles it)
            # Actually, let's just use the Master CSS FAB and remove all literal ones if duplicates exist
            pass
        # return # Temporarily disable skipping to ensure clean structure

    # Find the end of the last result-card
    # Or just find the last valid close tag of a div
    
    # Standard Footer Template
    type_code = os.path.splitext(os.path.basename(filepath))[0].upper()
    
    # Dictionary for Type Names (Simplified)
    type_names = {
        "LOUT": "アル中番長", "LOUY": "ハイテンション時限爆弾", "LODT": "飲み参謀", "LODY": "爆発インキャ",
        "LRUT": "自称プロ幹事", "LRUY": "ちゃんとした人", "LRDT": "朝までうんちく先輩", "LRDY": "水泥棒",
        "FOUT": "酒飲み聖母", "FOUY": "情熱のたぎりモンスター", "FODT": "飲み飲みカウンセラー", "FODY": "涙腺崩壊ベビー",
        "FRUT": "酔いどれ学級委員長", "FRUY": "飲んだふり常習犯", "FRDT": "お会計くん", "FRDY": "空気読みすぎ天使"
    }
    type_name = type_names.get(type_code, type_code)
    
    share_text = f"【公式】酒タイプ診断の結果は…「{type_name} ({type_code})」でした！"
    if is_en:
        share_text = f"[Official] Sake Quiz Result: {type_code}"
    
    url = f"https://sync-loft.com/alctype16/{'en/types' if is_en else 'types'}/{type_code.lower()}.html"
    
    share_title = "&#35386;&#26029;&#32080;&#26524;&#12434;&#12471;&#12455;&#12450;&#12375;&#12424;&#12358;&#65281;" if not is_en else "Share your result!"
    rediag_text = "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;" if not is_en else "Diagnose Again"
    back_text = "TOP&#12506;&#12540;&#12472;&#12395;&#25147;&#12427;" if not is_en else "Back to TOP"
    
    footer = f"""
        <div class="share-section">
            <p class="share-title">{share_title}</p>
            <a href="https://twitter.com/intent/tweet?text={share_text}&url={url}" target="_blank" class="x-share-button">
                <svg class="x-logo" viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path></svg>
            </a>
        </div>
        <a href="../index.html" class="rediagnosis-button">{rediag_text}</a>
        <div class="bottom-nav-wrapper">
            <a href="../index.html" class="bottom-nav-button primary">{back_text}</a>
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

    # 1. Clean up existing truncated bottoms/duplicated FABs
    content = re.sub(r'(?s)<div style="text-align:center;margin:20px auto;">.*', '', content)
    content = re.sub(r'(?s)<div class="share-section">.*', '', content)
    content = re.sub(r'(?s)<!-- LINE stamp floating banner -->.*', '', content)
    content = content.replace('</body>', '').replace('</html>', '')
    
    # 2. Ensure exactly one container closure before footer (if we stripped it)
    # Most result pages have one <div class="container"> at the top.
    # We stripped everything after the last result card.
    # Let's count open divs vs closed divs in the remaining content.
    open_divs = content.count('<div ') + content.count('<div\n') + content.count('<div\t') + content.count('<div\r')
    closed_divs = content.count('</div>')
    
    if open_divs > closed_divs:
        # We need to close the container
        # But wait, the footer template already starts with </div> to close the last card wrapper OR container?
        # Actually my footer template has </div> at Line 42 to close the container.
        pass
    
    new_content = content.rstrip() + footer
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Repaired: {filepath}")

# Correct the BASE path to include the full directory context
for d in [types_dir, en_types_dir]:
    if not os.path.exists(d): continue
    is_en_dir = 'en' in d
    for f in os.listdir(d):
        if f.endswith('.html'):
            repair_result_page(os.path.join(d, f), is_en=is_en_dir)

print("Batch repair complete.")
