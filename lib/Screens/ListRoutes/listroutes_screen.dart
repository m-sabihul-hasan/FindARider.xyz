import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ListRoutes/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';
import 'dart:convert';

class ListRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

listRides() async {
  var res = await http.post(
    Uri.http("localhost:3000", "/listrides"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  var activeRoutesJson = json.decode(res.body);
  // print(activeRoutesJson.runtimeType);
  activeRoutes = [];
  for (var trip_id in activeRoutesJson.keys) {
    activeRoutesJson[trip_id]["tripID"] = trip_id;
    activeRoutes.add(activeRoutesJson[trip_id]);
  }
  // print(activeRoutes);
  // return activeRoutes;
}
