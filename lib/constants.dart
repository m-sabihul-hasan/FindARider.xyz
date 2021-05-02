import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:flutter_app/Screens/RecieveBooking/recievebooking_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const button_text = Colors.white;
const label_text = Colors.black;
const apiBaseRoute = "http://localhost:3000";
String userType = "";
String finalUsername = "asd";
String user = "";
Map<String, dynamic> bookedTripDetails = {};
Map<String, dynamic> viewTripDetails = {};
List activeRoutes = [];
bool viewingBookedRide = false;
List<Map<dynamic, dynamic>> buttonsToShow = [];
IO.Socket socket;
bool socketinit = false;
String bookingRecieve = "";
String trip_id_chat = "";

initsocket() {
  if (socketinit == false) {
    socket = IO.io('http://localhost:3000');
  }
}

sendInfoToServer() {
  if (socketinit == false) {
    socket.emit(
        'username', json.encode({"username": finalUsername, "userType": user}));
    socket.onConnect((_) {
      print('connected');
      // socket.emit('message', 'test');
    });
    socket.onDisconnect((_) => print('disconnect'));

    socket.on('bookingRequestRecieve', (data) {
      //navigate to booking request screen
      bookingRecieve = data;
      navigatorKey.currentState
          .push(MaterialPageRoute(builder: (context) => RecieveBooking()));
    });

    socket.on('activeride', (data) {
      print("SEX");
      data = json.decode(data);
      bookedTripDetails = data;
      viewingBookedRide = true;
    });
    socketinit = true;
  }
}
