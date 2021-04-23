import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final Text text;
  final Function press;
  final double width;
  final Color color, textColor;
  final double marginVertical;
  final double borderWidth;
  final Color borderColor;
  final double paddingVertical;
  final double paddingHorizontal;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.width = 0.4,
    this.marginVertical = 10,
    this.borderWidth = 2,
    this.borderColor = Colors.black,
    this.color = button_text,
    this.textColor = Colors.black,
    this.paddingVertical = 30,
    this.paddingHorizontal = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth)),
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(),
        child: FlatButton(
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal),
          color: color,
          onPressed: press,
          child: text,
        ),
      ),
    );
  }
}
