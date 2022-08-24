# -*- coding: utf-8 -*-

# http://stackoverflow.com/questions/14404731/pyhon-image-comparison-regardless-of-size
# http://www.guguncube.com/1656/python-image-similarity-comparison-using-several-techniques

import os
import errno
import itertools
import requests
from PIL import Image
from numpy import average, linalg, dot
import shutil
import yaml
 
 
def main():
    import tempfile
    import shutil

    base_directory = tempfile.mkdtemp()


    #array of image urls we want checked, they will each be compared with all other images in the list


    # directory = r'E:\Work\UNI\Third_year_first_semester\Szoftver tervezes\Projekt\Image recognition repos\IMAGES'
    directory = r'E:\Work\UNI\Third_year_first_semester\Szoftver tervezes\Projekt\Image recognition repos\IMAGES_noBGD'
    compDirectory = r'E:\Work\UNI\Third_year_first_semester\Szoftver tervezes\Projekt\Image recognition repos\ImagesToTest'


    result = compare_similarity(compDirectory, directory, base_directory)
    print(yaml.dump(result, sort_keys=False, default_flow_style=False))



    #delete all files in directory when done
    shutil.rmtree(base_directory)

def compare_similarity(compDirectory, directory, download_base_directory):
    largest_similarity = 0.0
    matching_images = []

    image_comparison_dict = {
        'similarity': largest_similarity,
        'images': []
    }

    #create list of possible pairings
    """
    url_pairs = list()
    for i in range(len(test_image_urls)-1):
        for j in range(len(image_urls)-1):
            if (test_image_urls[i], image_urls[j]) not in url_pairs:
                url_pairs.append((test_image_urls[i], image_urls[j]))
    """
    paths = []
    testpaths = []
    pathCombinations = []

    for filename in os.listdir(directory):
        if filename.endswith(".jpg") or filename.endswith(".png"):
            paths += [directory + "\\" + filename]
    for filename in os.listdir(compDirectory):
        if filename.endswith(".jpg") or filename.endswith(".png"):
            testpaths += [compDirectory + "\\" + filename]
    #print(testpaths)

    for i in range(len(testpaths)):
        for j in range(len(paths)):
            pathCombinations += [(testpaths[i], paths[j])]


    # url_pairs = list(itertools.combinations(image_urls, 2))
    result = []
    #print(pathCombinations)
    for pair in pathCombinations:
        filepath_url = []
        for url in pair:
            url = url.strip()
            filename = url.split('\\')[-1]
            #print(filename)
            filepath = os.path.join(download_base_directory, filename)
            mkdir_p_filepath(filepath)
            # print(filepath)
            #print(url, filepath)
            if not os.path.exists(filepath):
                shutil.copy(url, filepath)
                # download_file(url, filepath)
            filepath_url.append((filepath, url))
        
        image_filepath1, url1 = filepath_url[0][0], filepath_url[0][1]
        image_filepath2, url2 = filepath_url[1][0], filepath_url[1][1]
 
        similarity = image_similarity_vectors_via_numpy(image_filepath1, image_filepath2)


        baseDict = {
            'image': url2.split('\\')[-1],
            'similarity': float(similarity)
        }
        result += [baseDict]



        """
        if similarity > largest_similarity:
            largest_similarity = similarity
            matching_images = [url1, url2]
            image_comparison_dict = {
                'similarity': largest_similarity,
                'images': matching_images
            }
        """
    resultSorted = sorted(result, key=lambda d: d['similarity'], reverse=True)

    return resultSorted



def image_similarity_vectors_via_numpy(filepath1, filepath2):

    #print(filepath1)
    #print(filepath2)
    image1 = Image.open(filepath1)
    image2 = Image.open(filepath2)
 
    image1 = get_thumbnail(image1)
    image2 = get_thumbnail(image2)
    
    images = [image1, image2]
    vectors = []
    norms = []
    for image in images:
        vector = []
        for pixel_tuple in image.getdata():
            vector.append(average(pixel_tuple))
        vectors.append(vector)
        norms.append(linalg.norm(vector, 2))
    a, b = vectors
    a_norm, b_norm = norms
    # If we did not resize the images to be equal, we would get an error here
    # ValueError: matrices are not aligned
    res = dot(a / a_norm, b / b_norm)
    return res
 
def get_thumbnail(image, size=(128,128), greyscale=False):
    #get a smaller version of the image - makes comparison much faster/easier
    image = image.resize(size, Image.ANTIALIAS)
    if greyscale:
        #convert image to greyscale
        image = image.convert('L')
    return image
 
def mkdir_p_filepath(path):
    dirpath = os.path.dirname(os.path.abspath(path))
    mkdir_p(dirpath)
 
def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise

def download_file(url, filepath):
    _USER_AGENT = 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36'
    headers = { 'user-agent': _USER_AGENT }
    r = requests.get(url, headers=headers, timeout=60, stream=True)
    with open(filepath, 'wb') as f:
        for chunk in r.iter_content(chunk_size=1024): 
            if chunk:
                f.write(chunk)
                f.flush()
    return filepath
 
 
if __name__ == "__main__":
    main()