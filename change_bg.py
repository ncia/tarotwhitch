import sys
from PIL import Image

def change_bg(input_path, output_path):
    img = Image.open(input_path).convert("RGBA")
    data = img.getdata()

    new_data = []
    # threshold for white
    for item in data:
        # Check if pixel is near white
        if item[0] > 235 and item[1] > 235 and item[2] > 235:
            # 연한 연보라 (Light pastel purple: R=225, G=204, B=248)
            new_data.append((225, 204, 248, 255))
        else:
            new_data.append(item)

    img.putdata(new_data)
    img.convert("RGB").save(output_path)

input_img = r"C:\Users\ncia\.gemini\antigravity-ide\brain\f2998b6b-9c26-48f2-84c5-e9b46781ea08\media__1781265525446.jpg"
output_img = r"C:\workspace\flutter_tarot\assets\images\card_back.jpg"

change_bg(input_img, output_img)
