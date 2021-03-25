import numpy as np
import json, requests
from io import BytesIO
# TENSORFLOW
# import tensorflow as tf                                   
# from tensorflow.keras.preprocessing import image
# PYTORCH
import torch      
import torch.nn as nn  
import torchvision.models as models
import torchvision.transforms as transforms

from flask import Flask, request, jsonify
from PIL import Image
import base64

app = Flask(__name__)

class_index = ['Condition Not Found Or Not Supported', 'Onychomycosis (Nail Fungus)', 'Basal Cell Carcinoma', 'Condition Not Found Or Not Supported']
desc_index = [
    'ForeSight could not detect a medical condition. Possible reasons include (1) the medical condition you have is currently' +
    ' not supported by the application, (2) there is no medical condition to report. If the signs or symptoms worsen, please consult a medical professional as soon as possible.', 
    'Onychomycosis, more commonly known as nail fungus, is a fungal infection of the nails that causes discoloration, thickening, and separation from the nail bed. ' +
    'If left untreated, onychomycosis can be painful, cause permanent damage to the nail, and/or lead to further bacterial skin infections.', 
    'Basal cell carcinoma is a type of skin cancer and often appears as a slightly transparent bump on the skin, though it can take other forms. ' +
    'Basal cell carcinoma occurs most often on areas of the skin that are exposed to the sun, such as your head and neck.', 
    'ForeSight could not detect a medical condition. Possible reasons include (1) the medical condition you have is currently ' +
    'not supported by the application, (2) there is no medical condition to report. If the signs or symptoms worsen, please consult a medical professional as soon as possible.'
    ]
ss_index = [
    'N/A', 
    'The infected nail may: thicken; have white to yellow-brown discoloration; become brittle, crumbly, or ragged; have a slightly foul smell.', 
    'The skin may have one of the following characteristics: a pearly white, skin-colored or pink bump; a brown, black, or blue lesion; a flat, scaly, reddish patch; a white, waxy, scar-like lesion.', 
    'N/A'
    ]

def load_model():
    global model
    # TENSORFLOW
    # model variable refers to the global variable
    # model = tf.keras.models.load_model('foresight_trained.h5')
    # PYTORCH
    model = models.resnet152(pretrained=True)
    for param in model.parameters():
        param.requires_grad = False
    model.fc = nn.Sequential(
        nn.Dropout(),
        nn.Linear(2048, 128),
        nn.ReLU(),
        nn.Linear(128, 64),
        nn.ReLU(),
        nn.Linear(64, 4)
    )
    model.load_state_dict(torch.load('foresight_final.pt', map_location=torch.device('cpu')))
    # model = torch.load('foresight_final.pt', map_location=torch.device('cpu'))
    model.eval()

# converting image to tensor in pytorch
def transform_image(image):
    my_transforms = transforms.Compose([transforms.Resize(224),
                                        transforms.ToTensor(),
                                        transforms.Normalize(
                                            [0.485, 0.456, 0.406],
                                            [0.229, 0.224, 0.225])])
    return my_transforms(image).unsqueeze(0)

# normalize pytorch model outputs
def softmax(x):
    """Compute softmax values for each sets of scores in x."""
    e_x = np.exp(x - np.max(x))
    return (e_x / e_x.sum()) * 100

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

        # TENSORFLOW
        # img = np.array(img)
        # img = np.expand_dims(img, axis=0)
        # pred = np.array(model.predict(img, batch_size=1))
        # pred_nmy = pred[0][0]
        # pred_omy = pred[0][1]
        # if(pred_omy >= 0.5):
        #     prediction = 'Onychomycosis'
        #     confidence = round(pred_omy * 100, 2)
        # else:
        #     prediction = 'Not Onychomycosis'
        #     confidence = round(pred_nmy * 100, 2)
        # return jsonify({"status": 200, "message": "Prediction calculated", "prediction": prediction, "confidence": confidence})

        # PYTORCH
        img_tensor = transform_image(img)
        pred = model.forward(img_tensor)
        pred = pred.detach().numpy()[0]
        pred = softmax(pred)
        prediction = np.argmax(pred)
        probability = np.round(pred[prediction], decimals=2)
        return jsonify({"status": 200, "prediction": class_index[prediction], "description": desc_index[prediction], "ss": ss_index[prediction], "probability": str(probability)})

if __name__ == '__main__':
    load_model()  # load model at the beginning once only
    app.run(host='0.0.0.0', port=80)  # http://localhost:80/