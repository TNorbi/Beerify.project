# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


import compress as cmp
import database_connection as db
import backgroundRemover as bgd
import image_similarity_path as sim
import shutil
import os
import saveBest as svb
import yaml

basepath = 'E:\\Work\\UNI\\Third_year_first_semester\\Szoftver tervezes\\Projekt finished\\projekt_python\\'

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print("---------- Main starts ----------")
    #dbname = db.get_database()

    directory = basepath + 'pictures'
    compressedDirectory = basepath + 'picturesCompressed'
    similarityDirectory = basepath + 'similarityDirectory'
    imageToCompare = basepath + 'ImagesToTest'
    resultDirectory = basepath + 'result'
    try:
        shutil.rmtree(compressedDirectory)
    except:
        pass
    try:
        shutil.rmtree(similarityDirectory)
    except:
        pass
    try:
        shutil.rmtree(resultDirectory)
    except:
        pass
    os.mkdir(compressedDirectory)
    os.mkdir(similarityDirectory)
    os.mkdir(resultDirectory)
    cmp.compress_images(directory, 75, compressedDirectory)
    bgd.removeBgdFolder(compressedDirectory, similarityDirectory)
    bgd.removeBgd(imageToCompare, imageToCompare)


    data = sim.runSimilarity(similarityDirectory, imageToCompare)
    result = svb.saveBest(data, directory, resultDirectory)
    print(yaml.dump(result, sort_keys=False, default_flow_style=False))




# See PyCharm help at https://www.jetbrains.com/help/pycharm/
