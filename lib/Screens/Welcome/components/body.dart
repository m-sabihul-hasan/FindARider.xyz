import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:flutter_app/Screens/PassengerHome/passengerhome_screen.dart';
import 'package:flutter_app/Screens/DriverHome/driverhome_screen.dart';
import 'package:flutter_app/Screens/RecieveBooking/recievebooking_screen.dart';
import 'package:flutter_app/Screens/Signup/signup_screen.dart';
import 'package:flutter_app/Screens/Chat/chat_screen.dart';
import 'package:flutter_app/Screens/TripDetails/tripdetails_screen.dart';
import 'package:flutter_app/Screens/Welcome/components/background.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/main.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            Text("Login",
                style: GoogleFonts.yellowtail(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
                )),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: Text("Driver",
                  style: GoogleFonts.yellowtail(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
              press: () {
                user = "Driver";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: Text("Passenger",
                  style: GoogleFonts.yellowtail(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
              color: button_text,
              textColor: Colors.black,
              press: () {
                user = "Passenger";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.25),
            RoundedButton(
              text: Text(
                "Signup using student email",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: button_text,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
