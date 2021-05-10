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

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String errorMessage = "";
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
                setState(() {
                  errorMessage = "";
                });
                if (viewingBookedRide != true) {
                  viewingBookedRide = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListRoutes();
                      },
                    ),
                  );
                } else {
                  setState(() {
                    errorMessage =
                        "Ride already booked. Please go to Current Ride";
                  });
                }
              },
            ),
            Divider(
              color: Colors.black,
            ),
            RoundedButton(
              press: () {
                setState(() {
                  errorMessage = "";
                });
                if (viewingBookedRide != false) {
                  viewingBookedRide = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TripDetails();
                      },
                    ),
                  );
                } else {
                  setState(() {
                    errorMessage = "No ride booked yet.";
                  });
                }
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
            ),
            Divider(
              color: Colors.black,
            ),
            Text(errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
