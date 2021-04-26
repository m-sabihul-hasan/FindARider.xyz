import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Home/home_screen.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:flutter_app/Screens/Signup/components/background.dart';
import 'package:flutter_app/Screens/Signup/components/or_divider.dart';
import 'package:flutter_app/Screens/Signup/components/social_icon.dart';
import 'package:flutter_app/Screens/DriverCreateRide/drivercreateride_screen.dart';
import 'package:flutter_app/Screens/TripDetails/tripdetails_screen.dart';
import 'package:flutter_app/components/already_have_an_account_acheck.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/components/rounded_input_field.dart';
import 'package:flutter_app/components/rounded_limited_input_field.dart';
import 'package:flutter_app/components/rounded_limited_number_field.dart';
import 'package:flutter_app/constants.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String startLocation = "";

  String destination = "";

  String car = "";

  String licenseNumber = "";

  int space = 0;

  String pie = "";

  String fare = "";

  String time = "";

  String date = "";

  Color pie_color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Create a Ride",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Start Location",
              onChanged: (value) {
                startLocation = value;
              },
              icon: null,
            ),
            RoundedInputField(
              hintText: "Destination",
              onChanged: (value) {
                destination = value;
              },
              icon: null,
            ),
            RoundedInputField(
              hintText: "Car",
              onChanged: (value) {
                car = value;
              },
              icon: null,
            ),
            RoundedLimitedInputField(
              hintText: "License Number",
              onChanged: (value) {
                licenseNumber = value;
              },
              icon: null,
              length: 7,
            ),
            RoundedLimitedNumberField(
              hintText: "Space",
              onChanged: (value) {
                space = int.parse(value);
              },
              icon: null,
              length: 2,
            ),
            RoundedNumberField(
              hintText: "Fare",
              onChanged: (value) {
                fare = value;
              },
              icon: null,
            ),
            // Container(child: ,)
            SizedBox(height: size.height * 0.02),
            BasicTimeField(
              width: 360,
              format: DateFormat("HH:mm"),
              onChanged: (value) {
                if (value != null)
                  time = DateFormat.Hm().format(value).toString();
                else
                  time = "";
              },
            ),
            SizedBox(height: size.height * 0.035),
            BasicDateField(
              width: 360,
              format: DateFormat("yyyy-MM-dd"),
              onChanged: (value) {
                if (value != null)
                  date = DateFormat.Md().format(value).toString();
                else
                  date = "";
              },
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: Text(
                "Confirm",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              press: () async {
                List createRideReturn = await createRide(startLocation,
                    destination, car, licenseNumber, space, fare, time, date);
                setState(() {
                  List createRideErrors = createRideReturn[0];
                  if (createRideErrors.length > 0) {
                    String space_error = "";
                    String license_error = "";
                    if (createRideErrors.contains('Space')) {
                      space_error =
                          "Space cannot be empty and must be greater than 0 and lesser than 5.";
                      createRideErrors.remove('Space');
                    }
                    if (createRideErrors.contains('License Number')) {
                      license_error =
                          "License Number must contain atleast 6 characters.\n\n";
                      createRideErrors.remove('License Number');
                    }
                    this.pie_color = Colors.red;
                    String createRideFixes = "";
                    if (createRideErrors.isNotEmpty)
                      createRideFixes =
                          createRideErrors.join(", ") + " cannot be empty.\n\n";
                    this.pie =
                        "${createRideFixes}${license_error}${space_error}";
                  } else {
                    this.pie_color = Colors.green;
                    this.pie =
                        "Ride created successfully!\n"; //${createRideReturn[1]}";
                    // finalUsername = username;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TripDetails()),
                    );
                  }
                });
              },
            ),
            Text(pie, style: TextStyle(color: pie_color)),
            SizedBox(height: size.height * 0.03),
            // AlreadyHaveAnAccountCheck(
            //   login: false,
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
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
