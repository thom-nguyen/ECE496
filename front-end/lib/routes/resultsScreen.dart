import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../constants.dart';

class ImageScreeningResults {
  final double probability;
  final String description;
  final String prediction;
  final String symptoms;
  final bool isConditionSupported;

  ImageScreeningResults(this.isConditionSupported, this.prediction,
      this.probability, this.description, this.symptoms);
}

class ResultsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final ImageScreeningResults imageScreeningResults =
        ModalRoute.of(context).settings.arguments;

    if (imageScreeningResults == null ||
        imageScreeningResults.probability == null) {
      Navigator.pushNamed(context, '/error');
    }

    Color lightGreen = Color(0xFFCAF5EF);
    Color darkGreen = Color(0xFF1EE6CC);

    Color lightYellow = Color(0xFFF3E3AE);
    Color darkYellow = Color(0xFFFEC100);

    Color lightRed = Color(0xFFE8AFB2);
    Color darkRed = Color(0xFFE6535A);

    Color lightRadial;
    Color darkRadial;
    Color percentColor;

    if (imageScreeningResults.isConditionSupported) {
      if (imageScreeningResults.probability < 80) {
        lightRadial = lightYellow;
        darkRadial = darkYellow;
        percentColor = darkYellow;
      } else {
        lightRadial = lightRed;
        darkRadial = darkRed;
        percentColor = darkRed;
      }
    } else {
      lightRadial = lightGreen;
      darkRadial = darkGreen;
      percentColor = darkGreen;
    }

    _showMaterialDialog(String description, String symptoms) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          content: Container(
            height: 400.0,
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "DESCRIPTION",
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).hintColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  "$description",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).hintColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Row(
                  children: [
                    Text(
                      "SIGNS & SYMPTOMS",
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).hintColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$symptoms",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).hintColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(12.0, 30.0, 20.0, 0.0),
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
                            Navigator.pushNamed(context, '/selectImage');
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

                  // Probability Score
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Probability Score',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).hintColor,
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${imageScreeningResults.prediction}',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).hintColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              minimum: 0,
                              maximum: 100,
                              radiusFactor: 0.55,
                              axisLineStyle: AxisLineStyle(
                                color: lightRadial,
                                thicknessUnit: GaugeSizeUnit.factor,
                                thickness: 0.2,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: imageScreeningResults.probability,
                                  cornerStyle: CornerStyle.bothCurve,
                                  enableAnimation: true,
                                  animationDuration: 1200,
                                  animationType: AnimationType.ease,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: darkRadial,
                                  width: 0.2,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  angle: 0,
                                  widget: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        width: 200,
                                        child: Text(
                                          '${imageScreeningResults.probability}%',
                                          style: GoogleFonts.roboto(
                                            color: percentColor,
                                            fontSize: 38,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 325.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              _showMaterialDialog(
                                  imageScreeningResults.description,
                                  imageScreeningResults.symptoms);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: percentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(180.0),
                                side: BorderSide.none,
                              ),
                              elevation: 7.0,
                            ),
                            child: Text(
                              'Description',
                              style: GoogleFonts.roboto(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Button row
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/selectImage');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                            side: BorderSide(
                                width: 2.0,
                                color: Theme.of(context).primaryColor),
                          ),
                          elevation: 10.0,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.redoAlt,
                          color: Theme.of(context).primaryColor,
                          size: 30.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                            side: BorderSide.none,
                          ),
                          elevation: 10.0,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.home,
                          color: Theme.of(context).backgroundColor,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
