from rembg.bg import remove
import numpy as np
import io
from PIL import ImageFile, Image
import os


# Uncomment the following line if working with trucated image formats (ex. JPEG / JPG)


def removeBgdFolder(input_path, output_path):
    print("---------- Remove background from images in folder ----------")
    if input_path and output_path:
        os.chdir(input_path)
    else:
        print("ERROR: No directory added")
        exit(1)

    # compressedDirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt\\projekt_python\\compressed'
    # 2. Extract all of the .png and .jpeg files:
    files = os.listdir()

    # 3. Extract all of the images:
    images = [file for file in files if file.endswith(('jpg', 'png'))]
    #print(images)
    for image in images:
        os.chdir(input_path)
        ImageFile.LOAD_TRUNCATED_IMAGES = True

        f = np.fromfile(image)
        result = remove(f)
        img = Image.open(io.BytesIO(result)).convert("RGB")
        os.chdir(output_path)
        rgba = img.convert("RGBA")
        datas = rgba.getdata()
        newData = []
        for item in datas:
            if item[0] == 0 and item[1] == 0 and item[2] == 0:  # finding black colour by its RGB value
                # storing a transparent value when we find a black colour
                newData.append((255, 255, 255, 0))
            else:
                newData.append(item)  # other colours remain unchanged
        rgba.putdata(newData)

        rgba.save("noBgd_" + image.split(".")[0]+".png", "PNG")
        #img.save("noBgd_"+image)



def removeBgd(input_path, output_path):
    print("---------- Remove background from one file ----------")
    if input_path and output_path:
        os.chdir(input_path)
    else:
        print("ERROR: No directory added")
        exit(1)
    ImageFile.LOAD_TRUNCATED_IMAGES = True
    files = os.listdir()
    images = [file for file in files if file.endswith(('jpg', 'png'))]
    if(len(images) > 1):
        print("More input in ImagesToTest folder")
        exit(1)
    filename = images[0]
    newFilename = "testImage.jpg"
    fullpath = input_path + "\\" + filename
    f = np.fromfile(fullpath)
    result = remove(f)
    img = Image.open(io.BytesIO(result)).convert("RGB")
    os.chdir(output_path)
    img = img.resize((480,640))
    os.remove(fullpath)
    rgba = img.convert("RGBA")
    datas = rgba.getdata()
    newData = []
    for item in datas:
        if item[0] == 0 and item[1] == 0 and item[2] == 0:  # finding black colour by its RGB value
            # storing a transparent value when we find a black colour
            newData.append((255, 255, 255, 0))
        else:
            newData.append(item)  # other colours remain unchanged
    rgba.putdata(newData)
    rgba.save("search_" + newFilename.split(".")[0]+".png", "PNG")
    #img.save("search_" + newFilename)
