import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    [Color? backgroundColor = Colors.red]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
