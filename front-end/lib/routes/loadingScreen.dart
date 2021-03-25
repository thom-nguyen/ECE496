import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import './reviewImageScreen.dart';
import './resultsScreen.dart';

class UnknownApiException implements Exception {
  int httpCode;

  UnknownApiException(this.httpCode);
}

class ItemNotFoundException implements Exception {}

class NetworkException implements Exception {}

class ApiClient {
  final String pickedImagePath;
  int statusCode;
  double probability;
  String description;
  String prediction;
  String symptoms;
  bool isConditionSupported = false;

  ApiClient(this.pickedImagePath);

  returnResponseOrThrowException(response) {
    statusCode = response.statusCode;
    print("Status code: $statusCode\n");

    if (statusCode == 200) {
      print("Uploaded complete.");
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      probability = double.parse(responseBody["probability"]);
      description = responseBody["description"];
      prediction = responseBody["prediction"];
      symptoms = responseBody["ss"];

      if (prediction == Constants.basalCellCarcinoma ||
          prediction == Constants.onychomycosis) {
        isConditionSupported = true;
      } else {
        isConditionSupported = false;
      }

      print("Probability score: $probability");
      print("Description: $description");
      print("Prediction result: $prediction");
      print("Symptoms: $symptoms");
    }

    print("This is the response: " + response.toString() + "\n");
  }

  uploadImage() async {
    Uri postApiUri =
        Uri.parse("${Constants.awsServer}${Constants.uploadEndpoint}");

    File imageFile = File(pickedImagePath);

    // Base64 encoding
    final bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);

    Map data = {"image": img64};

    var body = json.encode(data);

    print("Uploading image...");

    try {
      await http
          .post(
            postApiUri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body,
          )
          .then((response) => returnResponseOrThrowException(response))
          .catchError((e) {
        print(e);
        statusCode = 400;
      });
    } catch (e) {
      print(e);
      statusCode = 400;
    }

    return statusCode;
  }
}

class LoadingProgress extends StatefulWidget {
  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  ApiClient api;
  Timer timer;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final SelectImageArguments args = ModalRoute.of(context).settings.arguments;
    api = new ApiClient(args.pickedImagePath);

    uploadImage() async {
      int statusCode = await api.uploadImage();
      timer = new Timer(const Duration(seconds: 2), () {
        if (statusCode == 200) {
          Navigator.pushNamed(
            context,
            '/results',
            arguments: ImageScreeningResults(api.isConditionSupported, api.prediction, api.probability, api.description, api.symptoms),
          );
        } else {
          Navigator.pushNamed(context, '/error');
        }
      });
    }

    uploadImage();

    return SizedBox(
      height: 175.0,
      width: 175.0,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        strokeWidth: 18.0,
        semanticsLabel: 'Loading screening results.',
        backgroundColor: Color(0xFF94B4E1),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.fromLTRB(12.0, 20.0, 20.0, 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      iconSize: 60.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    // Title name
                    Text(
                      'ForeSight',
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).accentColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 450.0,
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Loading...',
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).hintColor,
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    LoadingProgress(),
                  ],
                ),
              ),
              Container(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
