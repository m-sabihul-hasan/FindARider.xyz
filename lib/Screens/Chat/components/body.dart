import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Chat/chat_screen.dart';
import 'package:flutter_app/Screens/Chat/components/background.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
        body: Column(children: <Widget>[
      SizedBox(height: size.height * 0.1),
      // Text("Home",
      //     style: GoogleFonts.yellowtail(
      //       textStyle:
      //           TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
      //     )),
      // SizedBox(height: size.height * 0.05),
      // SvgPicture.asset(
      //   "assets/icons/chat.svg",
      //   height: size.height * 0.45,
      // ),
      SizedBox(height: size.height * 0.05),
      RoundedButton(
        text: Text("connect",
            style: GoogleFonts.yellowtail(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
        press: () {
          connectToServer(socket);
        },
      ),
      RoundedButton(
        text: Text("send hi",
            style: GoogleFonts.yellowtail(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
        press: () {
          sendMessage('hi');
        },
      ),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  child: Center(
                      child: Text(
                    '${items[index]} (${items[index]})',
                    style: TextStyle(fontSize: 18),
                  )),
                );
              }))
    ]));
    // return Background(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         SizedBox(height: size.height * 0.1),
    //         // Text("Home",
    //         //     style: GoogleFonts.yellowtail(
    //         //       textStyle:
    //         //           TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
    //         //     )),
    //         // SizedBox(height: size.height * 0.05),
    //         // SvgPicture.asset(
    //         //   "assets/icons/chat.svg",
    //         //   height: size.height * 0.45,
    //         // ),
    //         SizedBox(height: size.height * 0.05),
    //         RoundedButton(
    //           text: Text("connect",
    //               style: GoogleFonts.yellowtail(
    //                 textStyle: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 40,
    //                     fontWeight: FontWeight.bold),
    //               )),
    //           press: () {
    //             connectToServer(socket);
    //           },
    //         ),
    //         RoundedButton(
    //           text: Text("send hi",
    //               style: GoogleFonts.yellowtail(
    //                 textStyle: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 40,
    //                     fontWeight: FontWeight.bold),
    //               )),
    //           press: () {
    //             sendMessage('hi');
    //           },
    //         ),

    //         Container(
    //           child: Column(
    //             children: <Widget>[
    //               Text(items[0]),
    //               ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: items.length,
    //                 itemBuilder: (context, index) {
    //                   return new Text(items[index]);
    //                 },
    //               )
    //             ],
    //           ),
    //         ),

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
    // ],
    // ),
    // ),
    // );
  }
}
