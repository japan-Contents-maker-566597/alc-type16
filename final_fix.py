import os
import re

base_dir = r"c:\Users\01051992\Desktop\NEWalctype16\alctype16"

final_css = """  /* Professional UI/UX Updates */
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  body { animation: fadeIn 0.6s ease-out; padding-bottom: env(safe-area-inset-bottom, 100px) !important; }
  h1 { 
    color: #6a1b9a !important; 
    white-space: nowrap !important; 
    font-size: clamp(1.2rem, 5.5vw, 2.8rem) !important; 
    margin-bottom: 20px !important; 
    text-align: center !important; 
    overflow: hidden;
    text-overflow: ellipsis;
  }
  h1 a { 
    text-decoration: none !important; 
    color: #6a1b9a !important; 
    transition: opacity 0.2s; 
    display: inline-block; 
  }
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
  }"""

def fix_file(file_path):
    rel_path = os.path.relpath(file_path, base_dir).replace("\\", "/")
    is_en = "en/" in rel_path
    is_type_page = "/types/" in rel_path and "list.html" not in rel_path
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except UnicodeDecodeError:
        # If UTF-8 fails, try shift-jis or something, but we expect UTF-8
        with open(file_path, 'r', encoding='shift-jis') as f:
            content = f.read()

    # 1. CSS Injection/Update
    if "/* Professional UI/UX Updates */" in content:
        pattern = r"/\* Professional UI/UX Updates \*/.*?</style>"
        content = re.sub(pattern, final_css + "\n  </style>", content, flags=re.DOTALL)
    
    # 2. Rediagnosis Button (Fix Mojibake and ensure presence)
    if is_type_page:
        btn_text = "Diagnose Again" if is_en else "もう一度診断する"
        btn_html = f'<a href="../index.html" class="rediagnosis-button">{btn_text}</a>'
        
        # Remove any existing (possibly mojibake) buttons
        content = re.sub(r'<a href="\.\./index\.html" class="rediagnosis-button">.*?</a>', "", content)
        # Add it back properly
        if '<div class="bottom-nav-wrapper">' in content:
            content = content.replace('<div class="bottom-nav-wrapper">', btn_html + "\n        " + '<div class="bottom-nav-wrapper">')

    # 3. Clean up duplicate H1 links or broken links
    # Ensure H1 a href points to the right place
    depth = rel_path.count("/")
    index_href = "../" * depth + "index.html"
    if is_en and depth == 1: # en/index.html
        index_href = "index.html"
    elif is_en and depth > 1: # en/types/*.html
        index_href = "../" * (depth - 1) + "index.html"
    
    # We'll just leave H1 as is if it's already there and correct, but fix duplicate tags
    h1_matches = re.findall(r'<h1>.*?</h1>', content, re.DOTALL)
    if len(h1_matches) > 1:
        # Keep only the first one
        content = content.replace(h1_matches[0], "TEMP_H1_MARKER", 1)
        for m in h1_matches:
            content = content.replace(m, "")
        content = content.replace("TEMP_H1_MARKER", h1_matches[0])

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".html"):
            fix_file(os.path.join(root, file))

print("Python Final Fix Complete.")
