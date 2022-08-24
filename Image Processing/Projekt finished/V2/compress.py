from PIL import Image
import PIL
import os
import glob
from rembg.bg import remove
import numpy as np
import io
from PIL import ImageFile,Image

#https://sempioneer.com/python-for-seo/how-to-compress-images-in-python/
#mydirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt\\projekt_python\\pictures'




def getSize(filename):
    st = os.stat(filename)
    return st.st_size

def compress_images(directory=False, quality=75, compressedDirectory = False):
    # 1. If there is a directory then change into it, else perform the next operations inside of the 
    # current working directory:
    print("---------- Image compression starts ----------")
    if directory and compressedDirectory:

        os.chdir(directory)
    else:
        print("ERROR: No directory added")
        exit(1)
    #compressedDirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt\\projekt_python\\compressed'
    # 2. Extract all of the .png and .jpeg files:
    files = os.listdir()
    
    # 3. Extract all of the images:
    images = [file for file in files if file.endswith(('jpg', 'png'))]

    

    # 4. Loop over every image:
    for image in images:
        # print(image)
        # print(getSize(image))
        # 5. Open every image:
        #img = Image.open(image)

        # 5. Compress every image and save it with a new name:
        img = Image.open(image)
        #(width,length) = pilImage.size
        img.thumbnail((480, 640), Image.ANTIALIAS)
        #img = pilImage.resize(width//4, length//4)
        os.chdir(compressedDirectory)
        img = img.resize((480, 640))
        img.save("Compressed_" + image, optimize=True, quality=quality)
        while getSize("Compressed_" + image) > 100000:
            quality = quality-5
            img.save("Compressed_" + image, optimize=True, quality=quality)
            if quality < 10:
                quality = 75
                break


        os.chdir(directory)
        


