import requests
import os
import json

def runSimilarity(
        directory='E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt finished\\V2\\result',
        compDirectory="E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt finished\\V2\\ImagesToTest"):
    print("---------- Running similarity test V2 ----------")
    if directory and compDirectory:

        os.chdir(directory)
    else:
        print("ERROR: No directory added")
        exit(1)
    # compressedDirectory = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt\\projekt_python\\compressed'
    # 2. Extract all of the .png and .jpeg files:
    files = os.listdir()

    # 3. Extract all of the images:
    images = [file for file in files if file.endswith(('jpg', 'png'))]
    result = []
    #rint(images)
    for image in images:
        r = requests.post(
            "https://api.deepai.org/api/image-similarity",
            files={
                'image1': open(directory+"\\"+image, 'rb'),
                'image2': open(compDirectory + "\\search_testImage.png", 'rb'),
            },
            headers={'api-key': '2f49a104-b067-4d30-b5f8-949096880c20'}
        )
        dict2 = r.json()
        dict2['id'] = image
        result += [dict2]


    resultSorted = sorted(result, key=lambda d: d['output']['distance'])
    #print(resultSorted)
    return resultSorted




