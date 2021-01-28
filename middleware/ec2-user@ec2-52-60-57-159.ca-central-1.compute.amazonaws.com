import numpy as np
import json, requests
import tensorflow as tf
from io import BytesIO
from tensorflow.keras.preprocessing import image
from flask import Flask, request, jsonify
from PIL import Image
import base64

app = Flask(__name__)


def load_model():
    global model
    # model variable refers to the global variable
    model = tf.keras.models.load_model('foresight_trained.h5')


@app.route('/')
def test():
    return 'ForeSight API!'


@app.route('/predict', methods=['POST'])
def get_prediction():
    if request.method == 'POST':

        # Image Handler - base64
        uploaded_file = request.get_json()['image']
        img = Image.open(BytesIO(base64.b64decode(uploaded_file)))

        # Image Handler - multipart request
        # uploaded_file = request.files['file']
        # img = Image.open(uploaded_file)

        # Image Processing
        input_dim = 224
        img = img.resize((input_dim, input_dim))
        img = np.array(img)
        img = np.expand_dims(img, axis=0)

        # Get Prediction
        pred = np.array(model.predict(img, batch_size=1))
        pred_nmy = pred[0][0]
        pred_omy = pred[0][1]

        if(pred_omy >= 0.5):
            prediction = 'Onychomycosis'
            confidence = round(pred_omy * 100, 2)
        else:
            prediction = 'Not Onychomycosis'
            confidence = round(pred_nmy * 100, 2)
            
        # Return JSON response
        return jsonify({"status": 200, "message": 'Prediction calculated', "prediction": prediction, "confidence": confidence})


if __name__ == '__main__':
    load_model()  # load model at the beginning once only
    app.run(host='0.0.0.0', port=80)  # http://localhost:80/