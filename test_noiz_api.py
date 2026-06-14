import requests

API_KEY = "ZTgxYTAyZDEtZjZkYi00M2NkLWI1NTEtMzdmZDM3YjdmOTlmJG5jaWFAZGF1bS5uZXQ="

headers = {
    "Authorization": API_KEY,
    "Content-Type": "application/json"
}

endpoints = [
    "https://api.noiz.ai/v1/voices",
    "https://api.noiz.ai/v1/system-voices",
    "https://api.noiz.ai/v1/tts/voices",
    "https://api.noiz.ai/voices",
    "https://api.noiz.ai/v1/models"
]

for url in endpoints:
    try:
        res = requests.get(url, headers=headers)
        print(f"URL: {url} -> Status: {res.status_code}")
        if res.status_code == 200:
            print(res.json())
    except Exception as e:
        print(f"Error: {e}")
