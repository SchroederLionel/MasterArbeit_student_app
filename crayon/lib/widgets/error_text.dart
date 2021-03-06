import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// Widget which is used to display error messages.
/// Uses the Custom text widget for translation.
class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({required this.error, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        textCode: error,
        safetyText: error,
        style: const TextStyle(
            fontSize: 19,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.red),
      ),
    );
  }
}
