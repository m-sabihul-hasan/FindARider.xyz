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
  final double marginHorizontal;
  // final Color backgroundColor;
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
    this.marginHorizontal = -1,
    this.paddingVertical = 30,
    this.paddingHorizontal = 5,
    // this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      margin: marginHorizontal == -1
          ? EdgeInsets.symmetric(vertical: marginVertical)
          : EdgeInsets.symmetric(
              vertical: marginVertical, horizontal: marginHorizontal),
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

class CircularButton extends StatelessWidget {
  final Text text;
  final Function press;
  final double width;
  final Color color, textColor;
  final double marginVertical;
  final double borderWidth;
  final Color borderColor;
  final double paddingVertical;
  final double paddingHorizontal;
  const CircularButton({
    Key key,
    this.text,
    this.press,
    this.width = 100,
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
    return GestureDetector(
      onTap: press,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: text,
        ),
      ),
    );
    // decoration: BoxDecoration(
    //     border: Border.all(color: borderColor, width: borderWidth)),
    // margin: EdgeInsets.symmetric(vertical: marginVertical),
    // width: size.width * width,
    // child: ClipRRect(
    //   borderRadius: BorderRadius.horizontal(),
    //   child: FlatButton(
    //     padding: EdgeInsets.symmetric(
    //         vertical: paddingVertical, horizontal: paddingHorizontal),
    //     color: color,
    //     onPressed: press,
    //     child: text,
    //   ),
    // ),
    // );
  }
}

// class DifferentCorneredButton extends StatelessWidget {
//   final Text text;
//   final Function press;
//   final double width;
//   final Color color, textColor;
//   final double marginVertical;
//   final double borderWidth;
//   final Color borderColor;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   const DifferentCorneredButton({
//     Key key,
//     this.text,
//     this.press,
//     this.width = 100,
//     this.marginVertical = 10,
//     this.borderWidth = 2,
//     this.borderColor = Colors.black,
//     this.color = button_text,
//     this.textColor = Colors.black,
//     this.paddingVertical = 30,
//     this.paddingHorizontal = 5,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return RaisedButton(
//       onPressed: press,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15.0),
//               bottomLeft: Radius.circular(15.0))),
//       child: text,
//       color: color,
//       textColor: textColor,
//     );
//     // decoration: BoxDecoration(
//     //     border: Border.all(color: borderColor, width: borderWidth)),
//     // margin: EdgeInsets.symmetric(vertical: marginVertical),
//     // width: size.width * width,
//     // child: ClipRRect(
//     //   borderRadius: BorderRadius.horizontal(),
//     //   child: FlatButton(
//     //     padding: EdgeInsets.symmetric(
//     //         vertical: paddingVertical, horizontal: paddingHorizontal),
//     //     color: color,
//     //     onPressed: press,
//     //     child: text,
//     //   ),
//     // ),
//     // );
//   }
// }
class DifferentCorneredButton extends StatelessWidget {
  final Text text;
  final Function press;
  final double width;
  final Color color, textColor;
  final double marginVertical;
  final double borderWidth;
  final Color borderColor;
  final double paddingVertical;
  final double paddingHorizontal;
  final double marginHorizontal;
  final borderradius;
  const DifferentCorneredButton({
    Key key,
    this.text,
    this.press,
    this.width = 0.4,
    this.marginVertical = 10,
    this.borderWidth = 2,
    this.borderColor = Colors.black,
    this.color = button_text,
    this.textColor = Colors.black,
    this.marginHorizontal = -1,
    this.paddingVertical = 30,
    this.paddingHorizontal = 5,
    this.borderradius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: borderradius),
      margin: marginHorizontal == -1
          ? EdgeInsets.symmetric(vertical: marginVertical)
          : EdgeInsets.symmetric(
              vertical: marginVertical, horizontal: marginHorizontal),
      width: size.width * width,
      child: ClipRRect(
        borderRadius: borderradius,
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
