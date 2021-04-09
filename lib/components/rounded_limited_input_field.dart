import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_field_container.dart';
import 'package:flutter_app/constants.dart';

class RoundedLimitedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double width;
  final int length;
  final ValueChanged<String> onChanged;
  const RoundedLimitedInputField({
    Key key,
    this.hintText,
    this.width = 0.6,
    this.icon = Icons.person,
    this.onChanged,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextField(
        maxLength: length,
        onChanged: onChanged,
        cursorColor: label_text,
        decoration: InputDecoration(
          counterText: '',
          counterStyle: TextStyle(fontSize: 0),
          icon: Icon(
            icon,
            color: label_text,
          ),
          // hintText: hintText,
          labelText: hintText,
          labelStyle: TextStyle(color: label_text),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
