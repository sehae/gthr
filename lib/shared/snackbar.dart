import 'package:flutter/material.dart';

void showSnackBarFun(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Center(
      child: Text(message,
          style: const TextStyle(fontSize: 16)),
    ),
    backgroundColor: const Color(0xFF1E7251),
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    duration: const Duration(seconds: 5),
    elevation: 6.0,
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}