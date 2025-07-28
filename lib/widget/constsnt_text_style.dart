import 'package:flutter/material.dart';

TextStyle TextStyleHeading(
  BuildContext context, {
  double? fontSize,
  Color? color,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = "Ubuntu",
}) {
  return TextStyle(
    fontSize: fontSize ?? MediaQuery.of(context).size.width * 0.05,
    color: color ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}

TextStyle TextStyleSubHeading1(
  BuildContext context, {
  double? fontSize,
  Color? color,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = "Ubuntu",
}) {
  return TextStyle(
    fontSize: fontSize ?? MediaQuery.of(context).size.width * 0.04,
    color: color ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}
TextStyle TextStyleSubHeading2(
  BuildContext context, {
  double? fontSize,
  Color? color,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = "Ubuntu",
}) {
  return TextStyle(
    fontSize: fontSize ?? MediaQuery.of(context).size.width * 0.04,
    color: color ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}

