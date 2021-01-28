# import tensorflow as tf

# model = tf.keras.models.load_model('test.h5')
# model.summary()
# model = tf.saved_model.load('')

# import base64
# with open ("omy.jpg", "rb") as img:
#     encoded_str = base64.b64encode(img.read())
#     print('***   {}'.format(encoded_str))

# https://towardsdatascience.com/simple-way-to-deploy-machine-learning-models-to-cloud-fd58b771fdcf
# https://medium.com/analytics-vidhya/serving-ml-with-flask-tensorflow-serving-and-docker-compose-fe69a9c1e369
# https://stackoverflow.com/questions/33279153/rest-api-file-ie-images-processing-best-practices
# https://blog.miguelgrinberg.com/post/handling-file-uploads-with-flask

# https://gist.github.com/jaskiratr/cfacb332bfdff2f63f535db7efb6df93

# https://stackoverflow.com/questions/27669927/how-do-i-install-python-3-on-an-aws-ec2-instance

import tensorflow
print(tensorflow.__version__)
# tensorflow==2.4.1

import keras
print(keras.__version__)