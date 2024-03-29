import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_field_container.dart';
import 'package:flutter_app/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: 0.6,
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: button_text,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: label_text),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          icon: Icon(
            Icons.lock,
            color: button_text,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: button_text,
          ),
        ),
      ),
    );
  }
}
