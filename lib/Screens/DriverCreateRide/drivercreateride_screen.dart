import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/DriverCreateRide/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';
import 'dart:convert';

class DriverCreateRide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

createRide(startLocation, destination, car, licenseNumber, space, fare, time,
    date) async {
  List empty = [];
  if (startLocation == "") empty.add('Start Location');
  if (destination == "") empty.add('Destination');
  if (car == "") empty.add('Car');
  if (space == 0 || space > 4) empty.add('Space');
  if (licenseNumber.length < 6) empty.add('License Number');
  if (fare == "") empty.add('Fare');
  if (time == "") empty.add('Time');
  if (date == "") empty.add('Date');
  if (empty.length > 0) return [empty, []];

  var res = await http.post(
    Uri.http("localhost:3000", "/createride"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'startLocation': startLocation,
      'destination': destination,
      'car': car,
      'licenseNumber': licenseNumber,
      'space': space.toString(),
      'fare': fare.toString(),
      'time': time,
      'date': date,
      'driver': finalUsername,
      'passenger1': 'None',
      'passenger2': 'None',
      'passenger3': 'None',
      'passenger4': 'None',
    }),
  );

  bookedTripDetails = {
    'startLocation': startLocation,
    'destination': destination,
    'car': car,
    'licenseNumber': licenseNumber,
    'space': space.toString(),
    'fare': fare.toString(),
    'time': time,
    'date': date,
    'driver': finalUsername,
    'tripID': res.body,
    'passenger1': 'None',
    'passenger2': 'None',
    'passenger3': 'None',
    'passenger4': 'None',
  };
  viewingBookedRide = true;
  return [[], res.body];
}
