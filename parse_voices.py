import json
import sys
import re

log_file = r'C:\Users\ncia\.gemini\antigravity-ide\brain\077ed19e-36f7-4270-9fd7-6c12bc88f389\.system_generated\tasks\task-938.log'

with open(log_file, 'r', encoding='utf-8') as f:
    text = f.read()

# Extract the JSON payload
match = re.search(r'(\{.*\})', text)
if match:
    try:
        data = json.loads(match.group(1))
        voices = [v for v in data.get('items', [])]
        ko_voices = [v for v in voices if 'ko' in str(v.get('language', '')) or 'ko' in str(v)]
        with open('parsed_voices.json', 'w', encoding='utf-8') as out:
            json.dump(ko_voices, out, indent=2, ensure_ascii=False)
    except Exception as e:
        print("JSON parse error:", e)
else:
    print("No JSON found")
