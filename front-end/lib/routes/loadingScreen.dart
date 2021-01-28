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
  double confidenceScore;
  String screeningMessage;
  String prediction;

  ApiClient(this.pickedImagePath);

  returnResponseOrThrowException(response) {
    if (response.statusCode == 200) {
      print("Uploaded complete.");
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      confidenceScore = responseBody["confidence"];
      screeningMessage = responseBody["message"];
      prediction = responseBody["prediction"];

      print("Confidence score: $confidenceScore");
      print("Message: $screeningMessage");
      print("Prediction result: $prediction");
    } else {
      print("Non-200 response code: ${response.statusCode}\n");
    }

    print("This is the response: " + response.toString() + "\n");

    return response;
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
    await http
        .post(
          postApiUri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        )
        .then((response) => returnResponseOrThrowException(response));
  }
}

class LoadingProgress extends StatefulWidget {
  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  ApiClient api;

  @override
  Widget build(BuildContext context) {
    final SelectImageArguments args = ModalRoute.of(context).settings.arguments;
    api = new ApiClient(args.pickedImagePath);

    uploadImage() async {
      await api.uploadImage();
      Navigator.pushNamed(
        context,
        '/results',
        arguments: ImageScreeningResults(
            api.confidenceScore, api.screeningMessage, api.prediction),
      );
    }

    uploadImage(); 

    return SizedBox(
      height: 150.0,
      width: 150.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF234256)),
        strokeWidth: 20.0,
        semanticsLabel: 'Loading screening results.',
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEFF3F6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingProgress(),
              Container(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Loading...',
                  style: GoogleFonts.lato(
                    color: Color(0xFF234256),
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
