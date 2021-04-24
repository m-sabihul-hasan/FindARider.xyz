import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_field_container.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double width;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.width = 0.6,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextField(
        controller: controller,
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

class RoundedNumberField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double width;
  final ValueChanged<String> onChanged;
  const RoundedNumberField({
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
      child: TextField(
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

class BasicTimeField extends StatelessWidget {
  final format;
  final double width;
  final ValueChanged onChanged;
  // final time;
  const BasicTimeField({
    Key key,
    this.format,
    this.width = 0.6,
    this.onChanged,
    // this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: width,
                child:
                    // Text('Basic time field (${format.pattern})'),
                    DateTimeField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: label_text),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Time",
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              )
            ]));
  }
}

class BasicDateField extends StatelessWidget {
  final format;
  final double width;
  final ValueChanged onChanged;
  // final time;
  const BasicDateField({
    Key key,
    this.format,
    this.width = 0.6,
    this.onChanged,
    // this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: width,
                child:
                    // Text('Basic time field (${format.pattern})'),
                    DateTimeField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: label_text),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Date",
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              )
            ]));
  }
}
