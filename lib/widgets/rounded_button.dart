import 'package:flutter/material.dart';

import '../constants/color_scheme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function() onPressed;
  final EdgeInsets? padding, margin;
  final Color? color;
  final double widthRatio;
  final double? height;
  const RoundedButton({
    this.margin,
    this.padding,
    this.height,
    required this.text,
    required this.onPressed,
    this.color = kYellow,
    this.textStyle =
        const TextStyle(color: kPurple, fontWeight: FontWeight.bold),
    this.widthRatio = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      margin: margin,
      width: size.width * widthRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: padding,
            alignment: Alignment.center,
            color: color,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
