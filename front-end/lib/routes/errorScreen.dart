import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorScreen extends StatelessWidget {
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

              // Error symbol
              Container(
                height: 450.0,
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Uh-oh!',
                            style: GoogleFonts.roboto(
                              color: Theme.of(context).hintColor,
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // Error symbol
                          FaIcon(
                            FontAwesomeIcons.exclamationTriangle,
                            color: Color(0xFFFF7746),
                            size: 120.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350.0,
                      child: Text(
                        'Something went wrong! Please try again, or contact support if the problem persists.',
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).hintColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Button row
              Container(
                padding: const EdgeInsets.only(bottom: 40.0),
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
