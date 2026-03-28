import os

src = r'C:\Users\01051992\Desktop\alc-type16\alctype16\types'
dst = r'C:\Users\01051992\Desktop\NEWalctype16\alctype16\en\types'
os.makedirs(dst, exist_ok=True)

LANG_TOGGLE_STYLE = """
    .lang-toggle{position:fixed;top:16px;right:16px;z-index:9999}
    .lang-toggle a{display:inline-flex;align-items:center;gap:6px;background:rgba(255,255,255,0.9);backdrop-filter:blur(8px);color:#6a1b9a;font-weight:800;font-size:0.85em;padding:8px 14px;border-radius:20px;text-decoration:none;box-shadow:0 2px 10px rgba(0,0,0,.15);border:2px solid #d1c4e9;transition:all 0.2s;font-family:inherit}
    .lang-toggle a:hover{background:#6a1b9a;color:#fff;border-color:#6a1b9a;transform:translateY(-2px)}
"""

files = [f for f in os.listdir(src) if f.endswith('.html')]
count = 0

for fname in files:
    src_path = os.path.join(src, fname)
    dst_path = os.path.join(dst, fname)

    with open(src_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Fix image path: ../../酒タイプ画像/ -> ../../../酒タイプ画像/
    content = content.replace('../../\u9152\u30bf\u30a4\u30d7\u753b\u50cf/', '../../../\u9152\u30bf\u30a4\u30d7\u753b\u50cf/')

    # Fix Back to TOP link: ../index.html -> ../../index.html
    content = content.replace('href="../index.html"', 'href="../../index.html"')

    # Add lang-toggle style before </style>
    content = content.replace('</style>', LANG_TOGGLE_STYLE + '</style>', 1)

    # Insert lang-toggle button before first <div class="container">
    lang_btn = f'<div class="lang-toggle"><a href="../../types/{fname}">\U0001f310 \u65e5\u672c\u8a9e</a></div>\n'
    content = content.replace('<div class="container">', lang_btn + '<div class="container">', 1)

    with open(dst_path, 'w', encoding='utf-8') as f:
        f.write(content)
    count += 1
    print(f'  Wrote: {fname}')

print(f'Done: {count} files processed')
