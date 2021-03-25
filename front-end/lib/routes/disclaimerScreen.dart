import '../constants.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.fromLTRB(12.0, 50.0, 20.0, 40.0),
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
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'DISCLAIMER',
                            style: GoogleFonts.roboto(
                              color: Theme.of(context).hintColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'Last updated March 25th, 2021.',
                            style: GoogleFonts.roboto(
                              color: Theme.of(context).hintColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 400.0,
                      child: Text(
                        Constants.disclaimerText,
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).hintColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.justify,
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
