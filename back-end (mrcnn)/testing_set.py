import numpy as np
import tensorflow as tf
from tensorflow.keras.preprocessing import image

import pathlib

test_image = image.load_img('../../Data/datasets (B1, B2, C, D, E)/beta/onychomycosis/B1_OM (1).jpg')
input_dimension = 224
test_image = test_image.reshape(input_dimension, input_dimension)
test_image = image.img_to_array(test_image)
test_image = np.expand_dims(test_image, axis=0)

saved_model_file_name = 'Jan22_0644PM_53_00001_16_0777.h5'

saved_model = tf.kears.models.load_model('..saved_models/' + saved_model_file_name)

print(saved_model.predict(test_image, batch_size=1))