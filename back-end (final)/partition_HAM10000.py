import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
from glob import glob
import seaborn as sns
from PIL import Image
np.random.seed(123)
import csv
from csv import reader

from sklearn.metrics import confusion_matrix
import itertools

import keras
from keras.utils.np_utils import to_categorical # used for converting labels to one-hot-encoding
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPool2D
from keras import backend as K
import shutil

# define paths
dataset_dir = 'dataset'
image_dir = 'images'

image_dir_dict = {}
for file in os.listdir(image_dir):
    filename = os.fsdecode(file)
    filepath = os.path.join(image_dir, filename)
    image_dir_dict[filename] = filepath

# define lesion types
lesion_type_dict = {
    'nv': 'Melanocytic nevi',
    'mel': 'Melanoma',
    'bkl': 'Benign keratosis-like lesions ',
    'bcc': 'Basal cell carcinoma',
    'akiec': 'Actinic keratoses',
    'vasc': 'Vascular lesions',
    'df': 'Dermatofibroma'
}
nv_dir = os.path.join(dataset_dir, 'melanocytic_nevi')
mel_dir = os.path.join(dataset_dir, 'melanoma')
bkl_dir = os.path.join(dataset_dir, 'benign_keratosis_like')
bcc_dir = os.path.join(dataset_dir, 'basal_cell_carcinoma')
akiec_dir = os.path.join(dataset_dir, 'actinic_keratoses')
vasc_dir = os.path.join(dataset_dir, 'vascular_lesions')
df_dir = os.path.join(dataset_dir, 'dermatofibroma')

# lesion_id, image_id, dx, dx_type, age, sex, localization, dataset
with open('HAM10000_metadata.csv', 'r') as read_obj:
    csv_reader = reader(read_obj)
    for row in csv_reader:
        if row[2]=='nv':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(nv_dir))
        if row[2]=='mel':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(mel_dir))
        if row[2]=='bkl':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(bkl_dir))
        if row[2]=='bcc':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(bcc_dir))
        if row[2]=='akiec':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(akiec_dir))
        if row[2]=='vasc':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(vasc_dir))
        if row[2]=='df':
            shutil.move(image_dir_dict[row[1] + '.jpg'], os.path.join(df_dir))
