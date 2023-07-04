import 'package:flutter/material.dart'
    show BuildContext, Color, ScaffoldMessenger, SnackBar, Text;

void showSnackBar(
    {required BuildContext context, required String content, Map? d}) {
  Color? bgColor = d?["bgColor"];
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: Text(content),
    ),
  );
}
