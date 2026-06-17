from PIL import Image
import glob

def center_crystal_ball():
    for f in glob.glob('assets/images/witch_*.jpg'):
        img = Image.open(f)
        w, h = img.size
        pixels = img.load()
        
        sum_x = 0
        sum_y = 0
        count = 0
        for y in range(400, 700):
            for x in range(w):
                r, g, b = pixels[x, y]
                # Identify crystal ball glow
                if r > 180 and b > 180 and g > 50:
                    sum_x += x
                    sum_y += y
                    count += 1
                    
        if count > 0:
            cx = sum_x / count
            cy = sum_y / count
            print(f'{f}: center=({cx:.1f}, {cy:.1f})')
        else:
            print(f'{f}: Not found')

center_crystal_ball()
