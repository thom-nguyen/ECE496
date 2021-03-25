import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60.0)),
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/foresight-logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Column(
                children: [
                  // Welcome title
                  Container(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Welcome to',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).primaryColor,
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ForeSight',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).accentColor,
                            fontSize: 70,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Steps
                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                    child: Text(
                      Constants.stepsText,
                      softWrap: true,
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).hintColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        height: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                width: 200,
                height: 40,
                // padding: const EdgeInsets.all(2.0),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).backgroundColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/disclaimer');
                  },
                  child: Text(
                    'View Disclaimer',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: 225,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide.none,
                    ),
                    elevation: 10.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/selectImage');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).backgroundColor),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: Theme.of(context).backgroundColor,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
