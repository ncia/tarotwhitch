import os
import json
import time
import urllib.request
import urllib.error

# We will use the GEMINI_API_KEY from .env
api_key = ""
with open(".env", "r") as f:
    for line in f:
        if line.startswith("GEMINI_API_KEY="):
            api_key = line.strip().split("=")[1].strip('"\'')

URL = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={api_key}"

new_keys_en = {
  "witchNameMorgan": "Morgan",
  "witchTitleMorgan": "Original Tarot Witch",
  "witchBgMorgan": "The legitimate successor of dark magic following the legendary Morgan le Fay family. Direct and sometimes cynical, but with sharp insight, she provides clear answers to your frustrating situations.",
  "witchPromptMorgan": "Your name is \"Morgan\", and please adopt the persona of a mysterious, direct, yet insightful tarot witch who penetrates to the essence. Rather than being kind, give advice that is slightly chic yet trustworthy.",
  "witchNameLuna": "Luna",
  "witchTitleLuna": "Comfort of Moonlight",
  "witchBgLuna": "Awakened as a witch after receiving a blessing from the moon spirit in a mysterious forest. With a warm and delicate empathy that touches hurt and exhausted souls, she delivers gentle and cozy comfort like moonlight in the night sky.",
  "witchPromptLuna": "Your name is \"Luna\", and please adopt the persona of a tarot witch who gently and affectionately comforts wounds like moonlight. Be highly empathetic and use a warm tone like a close sister or friend.",
  "witchNameSerena": "Serena",
  "witchTitleSerena": "Ancient Wisdom",
  "witchBgSerena": "The great witch of the forest who maintains a young and alluring appearance in her 20s despite transcending 100 years of time. Having witnessed the rise and fall of countless human affairs, she offers profound advice on the flow of fate with deep philosophical thought and an elegant attitude.",
  "witchPromptSerena": "Your name is \"Serena\", and please adopt the persona of an ancient witch who has lived for over 100 years, being very philosophical, profound, and elegant. Use an elegant tone that is slightly old-fashioned and full of wisdom.",
  "witchNameAria": "Aria",
  "witchTitleAria": "Sunshine Energy",
  "witchBgAria": "A genius rookie tarot witch who just graduated at the top of her class from magic school. Although she may lack a bit of practical experience, she is full of unique, bubbly, and bright positive energy, cheerfully suggesting bright and practical action guidelines to the client.",
  "witchPromptAria": "Your name is \"Aria\", and please adopt the persona of a very positive, bubbly, and energetic teenage witch who just turned 19. Use a lot of emojis and a friendly, lively tone.",
  "witchNameEvelyn": "Evelyn",
  "witchTitleEvelyn": "Alchemist of Ambition",
  "witchBgEvelyn": "Once a cold businesswoman who dominated the big city, she fully awakened her spiritual abilities and created a new magic combining alchemy and tarot. When it comes to money, job changes, and success, she provides a definite solution with sharp and realistic fact-bombing rather than emotional comfort.",
  "witchPromptEvelyn": "Your name is \"Evelyn\", and please adopt the persona of a charismatic and realistic witch who is well-versed in success and business. Rather than unnecessary comfort, use a career woman-like tone that offers bone-chilling advice (fact-bombing) and rational solutions.",
  "witchNameKaren": "Karen",
  "witchTitleKaren": "Witch of Twilight",
  "witchBgKaren": "The older version of 'Morgan', who was called the 'Original Tarot Witch' in the past and was skilled in dark magic and authentic tarot. Over decades of wandering the world and watching countless fates, her past sharp attitude has softened, and she now wisely unravels intertwined relationships and the threads of fate with deep and benevolent insight.",
  "witchPromptKaren": "Your name is \"Karen\", and having been 'Morgan' in your youth, please adopt the persona of an old witch who has gained deep wisdom and benevolence over a long time. Your previously direct personality has rounded out, and use a warm grandmotherly tone full of experience as if treating a grandchild.",
  "witchBloodTypeA": "Type A",
  "witchBloodTypeB": "Type B",
  "witchBloodTypeO": "Type O",
  "witchBloodTypeAB": "Type AB",
  "witchHeightCm": "{height}cm",
  "witchWeightKg": "{weight}kg",
  "chatWitchGreeting": "Hello. I am the Tarot Witch {witchName}. The energy of the universe has guided you here. What is your concern?",
  "chatWitchChanged": "[Witch changed to {witchName}.]\nHello. I am your new spiritual guide, {witchName}. What is your concern?",
  "chatAskPickCards": "I have delivered your concerns to the universe. Please put your heart into it and draw 3 tarot cards.",
  "chatReadingCards": "You have drawn all the cards. I will weave the energy of the cards you drew to read your fortune...",
  "chatProfileAge": "Age",
  "chatProfileBloodType": "Blood Type",
  "chatProfileHeight": "Height",
  "chatProfileWeight": "Weight",
  "chatProfileBackground": "Background Story",
  "chatProfileClose": "Close",
  "chatPickCardsButton": "Draw Tarot Cards ✨",
  "chatHintPickCardsFirst": "Please draw cards first.",
  "chatHintWriteConcern": "Write your concern...",
  "chatProfileTapHint": "Tap the profile picture to view details"
}

def translate_to_lang(lang_code):
    prompt = f"Translate the following JSON string values to language code '{lang_code}'. Return ONLY valid JSON, nothing else.\n{json.dumps(new_keys_en, ensure_ascii=False, indent=2)}"
    data = {
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {"temperature": 0.1}
    }
    req = urllib.request.Request(URL, data=json.dumps(data).encode('utf-8'), headers={'Content-Type': 'application/json'})
    try:
        with urllib.request.urlopen(req) as response:
            res = json.loads(response.read().decode('utf-8'))
            text = res['candidates'][0]['content']['parts'][0]['text'].strip()
            if text.startswith("```json"):
                text = text[7:]
            if text.startswith("```"):
                text = text[3:]
            if text.endswith("```"):
                text = text[:-3]
            return json.loads(text.strip())
    except Exception as e:
        print(f"Failed to translate {lang_code}: {e}")
        return new_keys_en

l10n_dir = "lib/l10n"
for filename in os.listdir(l10n_dir):
    if filename.endswith(".arb") and filename not in ["app_en.arb", "app_ko.arb"]:
        lang_code = filename[4:-4]
        path = os.path.join(l10n_dir, filename)
        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        if "witchNameMorgan" in data:
            print(f"Skipping {lang_code}, already translated.")
            continue
            
        print(f"Translating for {lang_code}...")
        translated = translate_to_lang(lang_code)
        
        data.update(translated)
        
        # Add placeholders
        data["@witchHeightCm"] = { "placeholders": { "height": { "type": "String" } } }
        data["@witchWeightKg"] = { "placeholders": { "weight": { "type": "String" } } }
        data["@chatWitchGreeting"] = { "placeholders": { "witchName": { "type": "String" } } }
        data["@chatWitchChanged"] = { "placeholders": { "witchName": { "type": "String" } } }
        
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            
        time.sleep(2)

print("Done translating all ARB files.")
