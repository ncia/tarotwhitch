import requests

API_KEY = "sk_ka15z2n9phv842hw1fvt0b634fb8cesaj1czhfm4cv0"
headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

url = "https://api.speechify.ai/v1/audio/speech"
payload = {
    "input": "Hello test",
    "voice_id": "min-seo",
    "audio_format": "mp3",
    "model": "simba-multilingual"
}

try:
    res = requests.post(url, headers=headers, json=payload)
    print(f"Status: {res.status_code}")
    print(f"Content-Type: {res.headers.get('Content-Type')}")
    body = res.text
    print(f"Body starts with: {body[:100]}")
except Exception as e:
    print(f"Error: {e}")
