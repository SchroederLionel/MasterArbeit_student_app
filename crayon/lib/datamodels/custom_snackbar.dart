import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// Class which allows to show a snackbar.
/// Is used for translation purposes.
class CustomSnackbar extends SnackBar {
  final BuildContext context;

  /// text is the code which should be used for translation.
  final String? text;
  final String saftyString;
  final bool isError;
  CustomSnackbar(
      {Key? key,
      this.text,
      required this.saftyString,
      required this.isError,
      required this.context})
      : super(
            key: key,
            backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
            content: CustomText(
              safetyText: saftyString,
              textCode: text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
            ));

  showSnackBar() {
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(this));
  }
}
