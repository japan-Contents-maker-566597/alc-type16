import os
import re

def process_file(filepath):
    # Determine the depth to css/main.css based on directory structure
    rel_path = os.path.relpath(filepath, start=r"C:\Users\01051992\Desktop\NEWalctype16\alctype16")
    parts = rel_path.split(os.sep)
    
    # We want to properly calculate depth. 
    # if it's in alctype16/, depth is ./
    # if it's in alctype16/types/ or alctype16/en/, depth is ../
    # if it's in alctype16/en/types/, depth is ../../
    depth = "./"
    if len(parts) == 2:
        depth = "../"
    elif len(parts) == 3:
        depth = "../../"

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Skip files that we already manually updated to use the new CSS
    # index.html and diagnosis.html in both EN and JA are already updated safely.
    if 'css/main.css' in content or 'main.css' in content:
        # File holds new stylesheet already
        return

    # Delete <style> block completely
    content = re.sub(r'<style>.*?</style>', '', content, flags=re.DOTALL)

    # Delete font preconnect and imports as they are in main.css
    content = re.sub(r'<link rel="preconnect" href="https://fonts\.googleapis\.com">', '', content)
    content = re.sub(r'<link rel="preconnect" href="https://fonts\.gstatic\.com" crossorigin>', '', content)
    content = re.sub(r'<link href="https://fonts\.googleapis\.com/css2\?family=M\+PLUS\+Rounded\+1c[^>]*>', '', content)

    # Insert link to main.css before </head>
    css_link = f'\n    <link rel="stylesheet" href="{depth}css/main.css">\n</head>'
    content = content.replace('</head>', css_link)

    # Clean up excessive newlines caused by deletions
    content = re.sub(r'\n{3,}', '\n\n', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Processed: {filepath}")

def main():
    base_dir = r"C:\Users\01051992\Desktop\NEWalctype16\alctype16"
    for root, dirs, files in os.walk(base_dir):
        # Always process html files
        for file in files:
            if file.endswith(".html"):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
