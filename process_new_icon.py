import sys
from PIL import Image

def process_icon(input_path, output_path):
    img = Image.open(input_path).convert("RGBA")
    
    # Create a light purple background (R=225, G=204, B=248)
    bg = Image.new("RGBA", img.size, (225, 204, 248, 255))
    
    has_alpha = False
    for item in img.getdata():
        if item[3] < 255:
            has_alpha = True
            break
            
    if has_alpha:
        # composite
        bg.paste(img, (0, 0), img)
        final_img = bg.convert("RGB")
    else:
        # replace white
        data = img.getdata()
        new_data = []
        for item in data:
            if item[0] > 235 and item[1] > 235 and item[2] > 235:
                new_data.append((225, 204, 248, 255))
            else:
                new_data.append(item)
        img.putdata(new_data)
        final_img = img.convert("RGB")
        
    final_img.save(output_path)

if __name__ == "__main__":
    process_icon(r"C:\workspace\flutter_tarot\assets\images\app_icon.png", r"C:\workspace\flutter_tarot\assets\images\app_icon_purple.png")
