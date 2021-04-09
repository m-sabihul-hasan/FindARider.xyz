import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_field_container.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter/services.dart';

class RoundedLimitedNumberField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double width;
  final int length;
  final ValueChanged<String> onChanged;
  const RoundedLimitedNumberField({
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
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
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
