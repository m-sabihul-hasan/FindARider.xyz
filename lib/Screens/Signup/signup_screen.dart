import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Signup/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart';
import 'dart:convert';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

signup(name, email, mobile, username, password, confirm_password) async {
  var res = await http.post(
    Uri.http("localhost:3000", "/signup"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'mobile': mobile,
      'username': username,
      'password': password,
      'confirm_password': confirm_password,
    }),
  );
  // Future.delayed(Duration(seconds: 2), () => print(res));

  var to_check = json.decode(res.body);
  List toShow = [];
  if (to_check['username'] == true) toShow.add('Username');
  if (to_check['email'] == true) toShow.add('Email');
  if (to_check['mobile'] == true) toShow.add('Mobile no.');
  String toShow_string = toShow.join(", ");
  // print(toShow_string);
  return toShow_string;
}
