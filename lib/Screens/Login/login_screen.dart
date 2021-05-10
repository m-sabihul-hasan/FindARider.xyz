import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Login/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

login(email, password) async {
  var res = await http.post(
    Uri.http("localhost:3000", "/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  return res.body;
}
