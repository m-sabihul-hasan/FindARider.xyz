import 'package:flutter/material.dart';
// import 'package:flutter_app/Screens/Login/login_screen.dart';
// import 'package:flutter_app/Screens/Signup/signup_screen.dart';
import 'package:flutter_app/Screens/ListRoutes/components/background.dart';
import 'package:flutter_app/Screens/TripDetails/tripdetails_screen.dart';
import 'package:flutter_app/Screens/ListRoutes/listroutes_screen.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  // initState() {
  //   super.initState();
  //   listRides();
  // }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listRides(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> asd) {
          Size size = MediaQuery.of(context).size;
          // print(activeRoutes);
          return Scaffold(
            body: Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                      padding: EdgeInsets.all(15),
                      child:
                          // Transform.rotate(
                          //     angle: 180 * math.pi / 180,
                          FloatingActionButton.extended(
                        onPressed: () {
                          navigatorKey.currentState.pop();
                        },
                        icon: Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            )),
                        label: Text("Back",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        backgroundColor: Colors.black,
                        elevation: 0,
                      ))
                ]),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: activeRoutes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                      width: double.infinity,
                                      // height: 200,
                                      margin:
                                          EdgeInsets.fromLTRB(20, 20, 20, 10),
                                      padding: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: size.height * 0.04),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    25, 5, 25, 0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                          child: Text(
                                                        "Start: ${activeRoutes[index]["startLocation"]}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )),
                                                      Flexible(
                                                          child: Text(
                                                        "Destination: ${activeRoutes[index]["destination"]}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ))
                                                    ])),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    25, 35, 15, 15),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Time: ${activeRoutes[index]["time"]}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )
                                                    ])),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 15, 0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircularButton(
                                                        press: () {
                                                          viewingBookedRide =
                                                              false;
                                                          viewTripDetails =
                                                              activeRoutes[
                                                                  index];
                                                          // print(viewTripDetails);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TripDetails()),
                                                          );
                                                        },
                                                        width: size.width * 0.2,
                                                        text: Text(
                                                          "View Details",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ])),
                                            SizedBox(
                                                height: size.height * 0.025),
                                          ])),
                                  Positioned(
                                      left: 50,
                                      top: 12,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 10, left: 10, right: 10),
                                        color: Colors.white,
                                        child: Text(
                                          'Route ${index + 1}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    // Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    // return Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       Expanded(
    //         child: Scrollbar(
    //           child: ListView.builder(
    //             padding: const EdgeInsets.all(8),
    //             itemCount: activeRoutes.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return Container(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     Stack(
    //                       children: <Widget>[
    //                         Container(
    //                             width: double.infinity,
    //                             // height: 200,
    //                             margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
    //                             padding: EdgeInsets.only(bottom: 10),
    //                             decoration: BoxDecoration(
    //                               border:
    //                                   Border.all(color: Colors.black, width: 2),
    //                               borderRadius: BorderRadius.circular(5),
    //                               shape: BoxShape.rectangle,
    //                             ),
    //                             child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   SizedBox(height: size.height * 0.04),
    //                                   Container(
    //                                       margin:
    //                                           EdgeInsets.fromLTRB(25, 5, 25, 0),
    //                                       child: Row(
    //                                           mainAxisAlignment:
    //                                               MainAxisAlignment
    //                                                   .spaceBetween,
    //                                           // crossAxisAlignment: CrossAxisAlignment.center,
    //                                           children: [
    //                                             Text(
    //                                               "Start:   ",
    //                                               textAlign: TextAlign.left,
    //                                               style:
    //                                                   TextStyle(fontSize: 20),
    //                                             ),
    //                                             Text(
    //                                               "Destination: ",
    //                                               style:
    //                                                   TextStyle(fontSize: 20),
    //                                               textAlign: TextAlign.right,
    //                                             )
    //                                           ])),
    //                                   Container(
    //                                       margin: EdgeInsets.fromLTRB(
    //                                           25, 35, 15, 15),
    //                                       child: Row(
    //                                           mainAxisAlignment:
    //                                               MainAxisAlignment.start,
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: [
    //                                             Text(
    //                                               "Time: ",
    //                                               style:
    //                                                   TextStyle(fontSize: 20),
    //                                             )
    //                                           ])),
    //                                   SizedBox(height: size.height * 0.025),
    //                                 ])),
    //                         Positioned(
    //                             left: 50,
    //                             top: 12,
    //                             child: Container(
    //                               padding: EdgeInsets.only(
    //                                   bottom: 10, left: 10, right: 10),
    //                               color: Colors.white,
    //                               child: Text(
    //                                 'Route',
    //                                 style: TextStyle(
    //                                     color: Colors.black,
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             )),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
