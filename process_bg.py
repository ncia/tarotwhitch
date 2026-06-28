import sys
from PIL import Image
from collections import deque

def remove_bg(input_path, output_path, threshold=30):
    print(f"Processing {input_path}...")
    img = Image.open(input_path).convert("RGBA")
    width, height = img.size
    pixels = img.load()
    
    queue = deque()
    visited = [[False] * height for _ in range(width)]
    
    # Add all border pixels
    for x in range(width):
        queue.append((x, 0))
        queue.append((x, height - 1))
        visited[x][0] = True
        visited[x][height - 1] = True
        
    for y in range(height):
        queue.append((0, y))
        queue.append((width - 1, y))
        visited[0][y] = True
        visited[width - 1][y] = True
        
    transparent_count = 0
    while queue:
        x, y = queue.popleft()
        
        r, g, b, a = pixels[x, y]
        # Is it black/near black?
        if r <= threshold and g <= threshold and b <= threshold and a > 0:
            pixels[x, y] = (0, 0, 0, 0)
            transparent_count += 1
            
            # Add neighbors
            if x > 0 and not visited[x-1][y]: 
                visited[x-1][y] = True
                queue.append((x-1, y))
            if x < width - 1 and not visited[x+1][y]: 
                visited[x+1][y] = True
                queue.append((x+1, y))
            if y > 0 and not visited[x][y-1]: 
                visited[x][y-1] = True
                queue.append((x, y-1))
            if y < height - 1 and not visited[x][y+1]: 
                visited[x][y+1] = True
                queue.append((x, y+1))
                
    img.save(output_path, "PNG")
    print(f"Saved {output_path}, made {transparent_count} pixels transparent out of {width*height}")

if __name__ == '__main__':
    # args: input output threshold
    thresh = int(sys.argv[3]) if len(sys.argv)>3 else 30
    remove_bg(sys.argv[1], sys.argv[2], thresh)
