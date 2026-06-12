import os
from PIL import Image

def crop_witch_face(filename):
    filepath = os.path.join(r"C:\workspace\flutter_tarot\assets\images", filename)
    if not os.path.exists(filepath):
        print(f"File not found: {filepath}")
        return
        
    img = Image.open(filepath)
    width, height = img.size
    
    # We want a 550x550 square from the top center
    # Face is roughly at Y=250, so this centers the face and includes some of the torso/crystal ball.
    crop_size = 550
    left = (width - crop_size) // 2
    top = 0
    right = left + crop_size
    bottom = crop_size
    
    cropped_img = img.crop((left, top, right, bottom))
    cropped_img.save(filepath)
    print(f"Cropped {filename} to {crop_size}x{crop_size}")

if __name__ == "__main__":
    witches = ['witch_aria.jpg', 'witch_evelyn.jpg', 'witch_luna.jpg', 'witch_serena.jpg']
    for w in witches:
        crop_witch_face(w)
