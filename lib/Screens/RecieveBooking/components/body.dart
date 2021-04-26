import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/RecieveBooking/recievebooking_screen.dart';
import 'package:flutter_app/Screens/RecieveBooking/components/background.dart';
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
            SizedBox(height: size.height * 0.25),
            CircleAvatar(
              maxRadius: 70,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 50,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Container(
                color: Color(0xFF28bcac),
                height: size.height * 0.2,
                width: size.width * 0.85,
                child: Center(
                    child: Text("${bookingRecieve} is requesting for a pickup!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25)))),
            SizedBox(height: size.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RoundedButton(
                    press: () {
                      socket.emit('bookingRequestResponse',
                          '{"res":"true", "passenger":"${bookingRecieve}"}');
                      navigatorKey.currentState.pop();
                    },
                    borderColor: Color(0xFF4caf52),
                    color: Color(0xFF4caf52),
                    // height: size.height * 0.06,
                    width: 0.2,
                    paddingVertical: 20,
                    text: Text("Accept",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25))),
                RoundedButton(
                    press: () {
                      socket.emit('bookingRequestResponse',
                          '{"res":"false", "passenger":"${bookingRecieve}"}');
                      navigatorKey.currentState.pop();
                    },
                    borderColor: Color(0xFFef4533),
                    color: Color(0xFFef4533),
                    // height: size.height * 0.06,
                    width: 0.2,
                    paddingVertical: 20,
                    // backgroundColor: Color(0xFFef4533),
                    text: Text("Reject",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
