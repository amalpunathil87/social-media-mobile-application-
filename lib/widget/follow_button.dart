import 'package:flutter/material.dart';
import 'package:instagram/utils/color.dart';

class followbutton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color bordercolor;
  final String text;
  final Color textcolor;
  const followbutton(
      {super.key,
      required this.backgroundColor,
      required this.bordercolor,
      this.function,
      required this.text,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: bordercolor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: textcolor, fontWeight: FontWeight.bold),
            ),
            width: 250,
            height: 27,
          )),
    );
  }
}
