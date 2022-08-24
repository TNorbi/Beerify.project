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
    for image in images:
        os.chdir(input_path)
        ImageFile.LOAD_TRUNCATED_IMAGES = True

        f = np.fromfile(image)
        result = remove(f)
        img = Image.open(io.BytesIO(result)).convert("RGB")
        os.chdir(output_path)
        img.save("noBgd_"+image)



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
    img = img.resize((640,480))
    os.remove(fullpath)
    img.save("search_" + newFilename)
