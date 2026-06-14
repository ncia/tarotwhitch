from PIL import Image
import numpy as np

def change_background(image_path, output_path):
    img = Image.open(image_path).convert("RGBA")
    data = np.array(img)

    # Get the background color from the top-left pixel
    bg_color = data[0, 0]
    
    # Define the new background color (darker purple, e.g., #31004a)
    new_bg_color = np.array([49, 0, 74, 255])
    
    # Define a tolerance for matching the background color
    tolerance = 30
    
    # Find all pixels that are close to the background color
    r, g, b, a = data[:, :, 0], data[:, :, 1], data[:, :, 2], data[:, :, 3]
    mask = (abs(r - bg_color[0]) < tolerance) & \
           (abs(g - bg_color[1]) < tolerance) & \
           (abs(b - bg_color[2]) < tolerance)
           
    # Replace the background color
    data[mask] = new_bg_color
    
    # Save the modified image
    new_img = Image.fromarray(data, 'RGBA')
    new_img.save(output_path)

if __name__ == "__main__":
    change_background("assets/images/app_icon.png", "assets/images/app_icon.png")
    print("App icon background color changed successfully.")
