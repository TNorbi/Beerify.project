
import os
from PIL import Image
import yaml

def saveBest(data, originalDirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt finished\\projekt_python\\pictures',  resultDirectory = "E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt finished\\projekt_python\\result"):
    print("---------- Save best results ----------")
    bestResults = []
    imgNames = [d['id'] for d in data]
    imgNamesFiltered = []
    similarities = [d['output']['distance'] for d in data]
    for i in range(6):
        imgName = imgNames[i].split("_")[-1]
        imgNamesFiltered += [imgName]
        similarity = similarities[i]
        dict = {"image": imgName, "similarity" : 100-similarity}
        bestResults += [dict]
    #print(imgName)

    if originalDirectory and resultDirectory:

        os.chdir(originalDirectory)
    else:
        print("ERROR: No directory added")
        exit(1)
    # compressedDirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt\\projekt_python\\compressed'
    # 2. Extract all of the .png and .jpeg files:
    files = os.listdir()

    # 3. Extract all of the images:
    images = [file for file in files if file.endswith(('jpg', 'png'))]

    # 4. Loop over every image:
    index = 0
    for resImg in imgNamesFiltered:
        for image in images:
            if image == resImg:
                index = index + 1
                img = Image.open(image)
                os.chdir(resultDirectory)
                img.save("recommended_" + str(index) + ".jpg")
                os.chdir(originalDirectory)
                break


    return bestResults



