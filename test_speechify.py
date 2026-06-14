import requests

API_KEY = "sk_ka15z2n9phv842hw1fvt0b634fb8cesaj1czhfm4cv0"
headers = {
    "Authorization": f"Bearer {API_KEY}",
}

endpoints = [
    "https://api.speechify.ai/v1/voices",
    "https://api.speechify.ai/v1/audio/voices"
]

for url in endpoints:
    try:
        res = requests.get(url, headers=headers)
        print(f"URL: {url} -> Status: {res.status_code}")
        if res.status_code == 200:
            data = res.json()
            voices = data if isinstance(data, list) else data.get('voices', data.get('data', []))
            print(f"Total voices: {len(voices)}")
            ko_voices = []
            for v in voices:
                lang = str(v.get('languages', '')) + str(v.get('locale', '')) + str(v.get('language', ''))
                if 'ko' in lang.lower() or 'korean' in lang.lower():
                    ko_voices.append(v)
            print(f"Korean voices found: {len(ko_voices)}")
            for v in ko_voices:
                print(v)
            if not ko_voices:
                print("Sample voices:")
                print(voices[:5])
            break
        else:
            print(res.text)
    except Exception as e:
        print(f"Error: {e}")
