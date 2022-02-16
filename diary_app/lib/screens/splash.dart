import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {

  static String ID = '/slash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Image.asset('assets/images/diary_logo.png'),
                ),
                // Text('My Diary',
                //   style: GoogleFonts.lobster(
                //     color: Colors.white,
                //     fontSize: 35.0,
                //   ),
                // )
              ],
            ),
          ),
      ),
    );
  }
}
