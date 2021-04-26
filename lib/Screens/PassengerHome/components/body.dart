import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ListRoutes/listroutes_screen.dart';
// import 'package:flutter_app/Screens/Login/login_screen.dart';
// import 'package:flutter_app/Screens/Signup/signup_screen.dart';
import 'package:flutter_app/Screens/PassengerHome/components/background.dart';
import 'package:flutter_app/Screens/Chat/chat_screen.dart';
import 'package:flutter_app/Screens/TripDetails/tripdetails_screen.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initsocket();
    sendInfoToServer();
    userType = "P";
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: size.height * 0.1),
            // Text("Home",
            //     style: GoogleFonts.yellowtail(
            //       textStyle:
            //           TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
            //     )),
            // SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/cover.png",
              height: size.height * 0.32,
              width: size.width,
            ),
            SizedBox(height: size.height * 0.025),
            Text("Welcome ${finalUsername}!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),
            SizedBox(height: size.height * 0.025),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              borderWidth: 0,
              borderColor: Colors.white,
              marginVertical: 0,
              width: 1,
              paddingVertical: 40,
              text: Text(
                "Find a Ride",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w200),
              ),
              press: () {
                viewingBookedRide = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListRoutes();
                    },
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              press: () {
                viewingBookedRide = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TripDetails();
                    },
                  ),
                );
              },
              borderWidth: 0,
              borderColor: Colors.white,
              width: 1,
              paddingVertical: 40,
              marginVertical: 0,
              text: Text(
                "Current Ride",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w200),
              ),
              // press: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return ChatScreen();
              //       },
              //     ),
              //   );
              // },
            ),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              borderWidth: 0,
              borderColor: Colors.white,
              width: 1,
              paddingVertical: 40,
              marginVertical: 0,
              text: Text(
                "Ride History",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w200),
              ),
              // press: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return ChatScreen();
              //       },
              //     ),
              //   );
              // },
            ),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              borderWidth: 0,
              borderColor: Colors.white,
              width: 1,
              paddingVertical: 40,
              marginVertical: 0,
              text: Text(
                "File a Complaint",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w200),
              ),
              // press: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return ChatScreen();
              //       },
              //     ),
              //   );
              // },
            ),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              text: Text("Chat (Testing)",
                  style: GoogleFonts.yellowtail(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatScreen();
                    },
                  ),
                );
              },
            ),
            // SizedBox(height: size.height * 0.05),
            // RoundedButton(
            //   text: Text("Passenger",
            //       style: GoogleFonts.yellowtail(
            //         textStyle: TextStyle(
            //             color: Colors.black,
            //             fontSize: 40,
            //             fontWeight: FontWeight.bold),
            //       )),
            //   color: button_text,
            //   textColor: Colors.black,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return LoginScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // SizedBox(height: size.height * 0.25),
            // RoundedButton(
            //   text: Text(
            //     "Signup using student email",
            //     style:
            //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //   ),
            //   color: button_text,
            //   textColor: Colors.black,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
