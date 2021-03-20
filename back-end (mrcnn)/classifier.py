import numpy as np
import tensorflow as tf
from tensorflow.keras import layers
from PIL import Image

print(tf.__version__)
print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))

import pathlib

img_dir = pathlib.Path('../../Data/datasets (B1, B2, C, D, E)/beta')

image_count = len(list(img_dir.glob('*/*.jpg')))
print('image count:', image_count)

seed=0
batch_size = 16
input_dimension = 224

train_ds = tf.keras.preprocessing.image_dataset_from_directory(
  img_dir,
  validation_split=0.2,
  subset="training",
  seed=seed,
  image_size=(input_dimension, input_dimension),
  batch_size=batch_size
)

val_ds = tf.keras.preprocessing.image_dataset_from_directory(
  img_dir,
  validation_split=0.2,
  subset="training",
  seed=seed,
  image_size=(input_dimension, input_dimension),
  batch_size=batch_size
)

class_name = train_ds.class_names
print(class_name)

resnet_model_layer = tf.keras.applications.ResNet152(
  include_top=False,
  pooling='avg'
)

data_augmentation_layer = tf.keras.Sequential([
  layers.experimental.preprocessing.RandomFlip("horizontal_and_vertical"),
  layers.experimental.preprocessing.RandomRotation(0.2),
])

normalization_layer = tf.keras.layers.experimental.preprocessing.Rescaling(1./255)

normalized_ds = train_ds.map(lambda x, y: (normalization_layer(x), y))
image_batch, labels_batch = next(iter(normalized_ds))
first_image = image_batch[0]
# Notice the pixels values are now in `[0,1]`.
print(np.min(first_image), np.max(first_image))

AUTOTUNE = tf.data.experimental.AUTOTUNE

train_ds = train_ds.cache().prefetch(buffer_size=AUTOTUNE)
val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)

num_classes = 2
epochs = 1
learning_rate = 0.0001

def create_model():
  model = tf.keras.Sequential([
    normalization_layer,
    data_augmentation_layer,
    resnet_model_layer,
    layers.Dense(64, activation='relu'),
    layers.Dense(32, activation='relu'),
    layers.Dense(num_classes, activation='softmax')
  ])

  model.compile(
    optimizer=tf.keras.optimizers.SGD(learning_rate=learning_rate),
    loss=tf.losses.SparseCategoricalCrossentropy(from_logits=True),
    metrics=['accuracy']
  )
  return model

model = create_model()

model.fit(
    train_ds,
    validation_data=val_ds,
    epochs=epochs,   
)

# Testing the model 
loss, accuracy = model.evaluate(
    val_ds
)

model.summary()

import time
# Saving our work
timestr = time.strftime("%b%d_%I%M%p")
model.save('../saved_models/' + timestr + '_' + str(epochs) + '_' + str(learning_rate).replace('.', '') + '_' + str(batch_size) + '_{:.3f}'.format(accuracy).replace('.', '') + '.h5')

print('saved model:', timestr)