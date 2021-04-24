import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Chat/chat_screen.dart';
import 'package:flutter_app/Screens/DriverHome/driverhome_screen.dart';
import 'package:flutter_app/Screens/PassengerHome/passengerhome_screen.dart';
// import 'package:flutter_app/Screens/Login/login_screen.dart';
// import 'package:flutter_app/Screens/Signup/signup_screen.dart';
import 'package:flutter_app/Screens/TripDetails/components/background.dart';
// import 'package:flutter_app/Screens/Chat/chat_screen.dart';
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
  Map<String, dynamic> showingTripDetails;
  updateButtons() {
    buttonsToShow = [];
    if (userType == "D") {
      buttonsToShow.add({"text": "Cancel", "function": {}});
      buttonsToShow.add({
        "text": "Home",
        "function": {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DriverHome();
              },
            ),
          )
        }
      });
      buttonsToShow.add({
        "text": "Chat",
        "function": {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen();
              },
            ),
          )
        }
      });
    } else {
      buttonsToShow.add({"text": "Book", "function": () {}});
      buttonsToShow.add({
        "text": "Home",
        "function": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PassengerHome();
              },
            ),
          );
        }
      });
      // buttonsToShow.add({
      //   "text": "Chat",
      //   "function": {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return ChatScreen();
      //         },
      //       ),
      //     )
      //   }
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    if (viewingBookedRide == false)
      showingTripDetails = viewTripDetails;
    else
      showingTripDetails = bookedTripDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          updateButtons();
        }));
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // setState(() {
    //   updateButtons();
    // });
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  // height: 200,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.04),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Trip ID: ${showingTripDetails["tripID"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              )
                            ]),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Driver:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["driver"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Date:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["date"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Time:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["time"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Pickup Location:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["startLocation"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Destination:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["destination"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Car:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["car"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'License:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["licenseNumber"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Passenger 1:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["passenger1"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Passenger 2:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["passenger2"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Passenger 3:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["passenger3"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Passenger 4:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["passenger4"]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Fare:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' ${showingTripDetails["fare"]} PKR',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Status:',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Ongoing',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.red,
                                ),
                              ),
                            ]),
                          ),
                        )
                      ]),
                ),
                Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Colors.white,
                      child: Text(
                        'Trip Details',
                        style: TextStyle(color: Colors.red, fontSize: 32),
                      ),
                    )),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Scaffold(
                  body: Padding(
                      padding: EdgeInsets.all(15),
                      child: Wrap(children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.all(15),
                            child: Align(
                                child: SizedBox(
                                    width: size.width * 0.25,
                                    height: 300.0,
                                    child: ListView.builder(
                                      itemCount: buttonsToShow.length,
                                      itemBuilder: (context, i) {
                                        return new Container(
                                            child: DifferentCorneredButton(
                                          press: buttonsToShow[i]["function"],
                                          width: 0.25,
                                          text: Text(buttonsToShow[i]["text"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22)),
                                          borderradius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ));
                                      },
                                    ))))
                      ])))
              // DifferentCorneredButton(
              //   press: () {},
              //   width: 0.25,
              //   text: Text("Book",
              //       style: TextStyle(color: Colors.black, fontSize: 22)),
              //   borderradius: BorderRadius.all(Radius.circular(15.0)),
              // ),
              // DifferentCorneredButton(
              //   width: 0.25,
              //   press: () {
              //     if (userType == "D")
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return DriverHome();
              //           },
              //         ),
              //       );
              //     else
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return PassengerHome();
              //           },
              //         ),
              //       );
              //   },
              //   text: Text("Home",
              //       style: TextStyle(color: Colors.black, fontSize: 22)),
              //   borderradius: BorderRadius.all(Radius.circular(15.0)),
              // ),
              // DifferentCorneredButton(
              //   width: 0.25,
              //   press: () {},
              //   text: Text("Chat",
              //       style: TextStyle(color: Colors.black, fontSize: 22)),
              //   borderradius: BorderRadius.all(Radius.circular(15.0)),
              // ),
            ])
          ],
        ),
      ),
      // ),
      // ],
      // ),
      // ),
    );
  }
}
