import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, bool error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: error ? Colors.red : Colors.green,
    ),
  );
}
