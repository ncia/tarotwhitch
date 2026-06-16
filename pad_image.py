from PIL import Image

def process_image(filename):
    img = Image.open(filename)
    if img.size != (1408, 736):
        print(f"{filename} size is not 1408x736, it is {img.size}")
        return
    
    # Crop left 120 pixels to shift everything left
    cropped = img.crop((120, 0, 1408, 736))
    
    # Create new image
    new_img = Image.new('RGB', (1408, 736))
    new_img.paste(cropped, (0, 0))
    
    # Create a mirrored edge for the remaining 120 pixels on the right
    edge = cropped.crop((1288-120, 0, 1288, 736))
    mirrored_edge = edge.transpose(Image.FLIP_LEFT_RIGHT)
    
    # Paste the mirrored edge to fill the gap
    new_img.paste(mirrored_edge, (1288, 0))
    
    new_img.save(filename)
    print(f"Successfully centered {filename}")

if __name__ == "__main__":
    process_image('assets/images/witch_morgan.jpg')
