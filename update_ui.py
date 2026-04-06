import os
import re

base_dir = r"C:\Users\01051992\Desktop\NEWalctype16\alctype16"
logo_entity = "&#12304;&#20844;&#24335;&#12305;&#37202;&#12479;&#12452;&#12503;&#35386;&#26029;"
retry_entity = "&#12418;&#12358;&#19968;&#24230;&#35386;&#26029;&#12377;&#12427;"

common_css = """
  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 a, h2 a { text-decoration: none; color: inherit; transition: opacity 0.2s; display: inline-block; }
  h1 a:hover, h2 a:hover { opacity: 0.7; }
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
    font-size: 1.2em; font-weight: 800; color: #fff;
    background: linear-gradient(135deg, #6a1b9a, #8e24aa);
    border: none; border-radius: 50px; text-align: center; text-decoration: none;
    box-shadow: 0 4px 15px rgba(106, 27, 154, 0.3);
  }
"""

def process_file(path):
    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    # 1. Fix Mojibake
    content = content.replace("縲仙・蠑上€鷹・繧ｿ繧､繝苓ｨｺ譁ｭ", logo_entity)
    content = content.replace("繧ゅ≧荳€蠎ｦ險ｺ譁ｭ縺吶ｋ", retry_entity)

    # 2. Add Link to h1
    rel_path = "index.html"
    if "types" in path.lower():
        rel_path = "../index.html"
    
    if '<h1>' in content and '<h1><a' not in content:
        content = re.sub(r'<h1>(.*?)</h1>', f'<h1><a href="{rel_path}">\\1</a></h1>', content)

    # 3. Add CSS
    if "/* Professional UI/UX Updates */" not in content and "</style>" in content:
        content = content.replace("</style>", common_css + "\n</style>")

    # 4. Meta theme-color
    if 'name="theme-color"' not in content and '<head>' in content:
        content = content.replace('<head>', '<head><meta name="theme-color" content="#6a1b9a">')

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

for root, dirs, files in os.walk(base_dir):
    for name in files:
        if name.endswith(".html"):
            process_file(os.path.join(root, name))
            print(f"Processed: {name}")
