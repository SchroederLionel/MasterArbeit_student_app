import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  final String text;
  final bool isError;
  CustomSnackbar({Key? key, required this.text, required this.isError})
      : super(
            key: key,
            backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
            content: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
            ));
}
