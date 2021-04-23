import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Home/home_screen.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:flutter_app/Screens/Signup/components/background.dart';
import 'package:flutter_app/Screens/Signup/components/or_divider.dart';
import 'package:flutter_app/Screens/Signup/components/social_icon.dart';
import 'package:flutter_app/Screens/DriverCreateRide/drivercreateride_screen.dart';
import 'package:flutter_app/components/already_have_an_account_acheck.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/components/rounded_input_field.dart';
import 'package:flutter_app/components/rounded_limited_input_field.dart';
import 'package:flutter_app/components/rounded_limited_number_field.dart';
import 'package:flutter_app/components/rounded_password_field.dart';
import 'package:flutter_app/components/rounded_text_formfield.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: Text(
                "Confirm",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              press: () async {
                String unique = await createRide(
                    startLocation, destination, car, licenseNumber, space);
                setState(() {
                  if (unique.isNotEmpty) {
                    this.pie_color = Colors.red;
                    this.pie = "";
                  } else {
                    this.pie_color = Colors.green;
                    this.pie = "Ride created succcesfully!";
                    // finalUsername = username;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                });
              },
            ),
            Text(pie, style: TextStyle(color: pie_color)),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
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
