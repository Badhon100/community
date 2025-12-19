import 'package:flutter/material.dart';

commonText(
  String text, {
  Color color = Colors.white,
  double size = 12,
  FontWeight fontWeight = FontWeight.normal,
  int? maxLine = null,
}) => Text(
  text,
  style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
  maxLines: maxLine,
);
