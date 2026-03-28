import os
import shutil
import subprocess

src_dir = r"c:\Users\01051992\Desktop\alc-type16\alctype16\types"
en_dir = r"c:\Users\01051992\Desktop\alc-type16\alctype16\en\types"

# 1. Ensure en_dir exists
os.makedirs(en_dir, exist_ok=True)

# 2. Copy the current English files (with uncommitted changes) to en_dir
print("Copying current English versions...")
for fname in os.listdir(src_dir):
    if fname.endswith(".html"):
        src_path = os.path.join(src_dir, fname)
        en_path = os.path.join(en_dir, fname)
        shutil.copy2(src_path, en_path)
        print(f"  Copied to en/types/{fname}")

# 3. Restore the Japanese files using git restore
print("\nRestoring original Japanese files...")
subprocess.run(["git", "restore", src_dir], cwd=r"c:\Users\01051992\Desktop\alc-type16")
print("  Git restore completed.")

# 4. Patch all 32 files to add <!-- admax -->
print("\nPatching ads...")
def patch_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    target = '<script src="https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30"></script>'
    replacement = '<!-- admax -->\n<script src="https://adm.shinobi.jp/s/aff5e37cd93a72cfb48eee5ae3b4df30"></script>\n<!-- admax -->'
    
    if target in content and replacement not in content:
        content = content.replace(target, replacement)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

count_en = 0
for fname in os.listdir(en_dir):
    if fname.endswith(".html"):
        if patch_file(os.path.join(en_dir, fname)): count_en += 1

count_ja = 0
for fname in os.listdir(src_dir):
    if fname.endswith(".html"):
        if patch_file(os.path.join(src_dir, fname)): count_ja += 1

print(f"Successfully patched {count_en} English files and {count_ja} Japanese files.")
