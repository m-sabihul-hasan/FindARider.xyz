import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/DriverHome/driverhome_screen.dart';
import 'package:flutter_app/Screens/PassengerHome/passengerhome_screen.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/Screens/Login/components/background.dart';
// import 'package:flutter_app/Screens/Home/home_screen.dart';
import 'package:flutter_app/Screens/Signup/signup_screen.dart';
import 'package:flutter_app/components/already_have_an_account_acheck.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/components/rounded_input_field.dart';
import 'package:flutter_app/components/rounded_password_field.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String pie = "";

  Color pie_color;

  String email = "";

  String password = "";

  String login_return;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Login",
                style: GoogleFonts.yellowtail(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                )),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: Text(
                "Login",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              press: () async {
                String login_return = await login(email, password);
                setState(() {
                  if (login_return == "false") {
                    this.pie_color = Colors.red;
                    this.pie = "Incorrect Username/Password combination.";
                  } else {
                    this.pie_color = Colors.green;
                    this.pie = "Login Successful!";
                    finalUsername = login_return;
                    if (user == "Passenger") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PassengerHome();
                          },
                        ),
                      );
                    } else if (user == "Driver") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DriverHome();
                          },
                        ),
                      );
                    }
                  }
                });
              },
            ),
            Text(pie, style: TextStyle(color: pie_color)),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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
