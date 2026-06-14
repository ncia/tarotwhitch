import json
data = json.load(open('parsed_voices.json', encoding='utf-8'))
ages = set()
for v in data:
    if v.get('gender') == 'female':
        ages.add(v.get('age'))
print("Unique ages for ko female voices:", ages)

