import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Home/home_screen.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:flutter_app/Screens/Signup/components/background.dart';
import 'package:flutter_app/Screens/Signup/components/or_divider.dart';
import 'package:flutter_app/Screens/Signup/components/social_icon.dart';
import 'package:flutter_app/Screens/Signup/signup_screen.dart';
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
  String name = "";

  String email = "";

  String password = "";

  String confirm_password = "";

  String username = "";

  String mobile = "";

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
            Text("Signup",
                style: GoogleFonts.yellowtail(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                )),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Full Name",
              onChanged: (value) {
                name = value;
              },
              icon: null,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: size.width * 0.2),
              Container(
                  child: RoundedLimitedInputField(
                hintText: "Email",
                length: 7,
                onChanged: (value) {
                  email = value + "@st.habib.edu.pk";
                },
                icon: null,
                width: 0.35,
              )),
              Text("@st.habib.edu.pk", style: TextStyle(fontSize: 20)),
            ]),
            RoundedLimitedNumberField(
              hintText: "Mobile no.",
              onChanged: (value) {
                mobile = value;
              },
              icon: null,
              length: 11,
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                username = value;
              },
              icon: null,
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Confirm Password",
              onChanged: (value) {
                confirm_password = value;
              },
            ),
            // RoundedButton(
            //   text: "SIGNUP",
            //   press: () {},
            // ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: Text(
                "Sign up",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              press: () async {
                String unique = await signup(
                    name, email, mobile, username, password, confirm_password);
                setState(() {
                  if (unique.isNotEmpty) {
                    this.pie_color = Colors.red;
                    this.pie = unique + " already in use by other account(s).";
                  } else {
                    this.pie_color = Colors.green;
                    this.pie = "Registration Successful!";
                    finalUsername = username;
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
