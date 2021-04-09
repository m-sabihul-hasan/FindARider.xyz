import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_field_container.dart';
import 'package:flutter_app/constants.dart';

class RoundedTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double width;
  final ValueChanged<String> onChanged;
  const RoundedTextFormField({
    Key key,
    this.hintText,
    this.width = 0.6,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: onChanged,
        cursorColor: label_text,
        decoration: InputDecoration(
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
