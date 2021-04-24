import 'package:flutter/material.dart';

const button_text = Colors.white;
const label_text = Colors.black;
const apiBaseRoute = "http://localhost:3000";
String userType = "";
String finalUsername = "asd";
String user = "";
Map<String, String> bookedTripDetails = {};
Map<String, dynamic> viewTripDetails = {};
List activeRoutes = [];
bool viewingBookedRide = false;
List<Map<dynamic, dynamic>> buttonsToShow = [];
