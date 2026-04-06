import os
import re

base_dir = r'c:\Users\01051992\Desktop\NEWalctype16\alctype16'

def repair(path, is_en=False):
    try:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 1. Identify Truncation
        # If it's missing </body> or share-section, it needs repair
        if 'share-section' in content and '</body>' in content:
            return

        print(f"Repairing: {path}")

        # 2. Extract Type Name from <h2>
        # Looks like: <h2 class="result-title">アル中番長 (LOUT)</h2>
        match = re.search(r'<h2 class="result-title">(.*?)</h2>', content)
        type_display_name = match.group(1) if match else "Result"
        
        file_id = os.path.splitext(os.path.basename(path))[0].upper()
        
        # 3. Strip corrupted tail (if any)
        if '<div style="text-align:center;' in content:
            content = content.split('<div style="text-align:center;')[0]
        elif '<!-- LINE stamp floating banner -->' in content:
            content = content.split('<!-- LINE stamp floating banner -->')[0]
        else:
            # If it just ended abruptly
            last_div = content.rfind('</div>')
            if last_div != -1:
                content = content[:last_div+6]

        content = content.strip()

        # 4. Construct Footer (Using ASCII and HTML Entities for Safety)
        # Type Name is already extracted (it's in memory as a string)
        # For URL, we need type_code
        type_code = file_id.lower()
        
        # Encoded Message for Twitter
        # We'll just use a generic message if we can't safely encode, 
        # but let's try to keep it simple.
        msg_prefix = "[Official] Sake Quiz Result: " if is_en else "%E3%80%90%E5%85%AC%E5%BC%8F%E3%80%91%E9%85%92%E3%82%BF%E3%82%A4%E3%83%97%E8%A8%BA%E6%96%AD%E3%81%AE%E7%B5%90%E6%9E%9C%E3%81%AF%E2%80%A6"
        url_path = "en/types" if is_en else "types"
        url = f"https://sync-loft.com/alctype16/{url_path}/{type_code}.html"
        
        share_title = "Share your result!" if is_en else "&#35386;&#26029;&#32080;&#26524;&#12434;&#12471;&#12455;&#12450;&#12375;&#12424;&#12358;&#65281;"
        rediag_text = "Diagnose Again" if is_en else "&#12418;&#12358;&#12356;&#12385;&#12393;&#35386;&#26029;&#12377;&#12427;"
        back_text = "Back to TOP" if is_en else "TOP&#12506;&#12540;&#12472;&#12395;&#25147;&#12427;"
        line_label = "LINE STAMP" if is_en else "LINE&#12473;&#12479;&#12531;&#12503;<br>&#30330;&#22770;&#20013;&#65281;"

        footer = f"""
        <div class="share-section">
            <p class="share-title">{share_title}</p>
            <a href="https://twitter.com/intent/tweet?text={msg_prefix}{type_display_name}&url={url}" target="_blank" class="x-share-button">
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
          <span class="fab-label-main">{line_label}</span>
      </div>
  </a>
</body>
</html>
"""
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content + footer)

    except Exception as e:
        print(f"Error in {path}: {str(e)}")

# Batches
for d in [os.path.join(base_dir, 'types'), os.path.join(base_dir, 'en', 'types')]:
    if not os.path.exists(d): continue
    for f in os.listdir(d):
        if f.endswith('.html'):
            repair(os.path.join(d, f), 'en' in d)

print("Final repair done.")
