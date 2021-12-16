import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// Custom Button is a button which is used so that each button looks the same and Provides translation.

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  /// String code which is used for translation
  final String? labelCode;

  /// If the labelCode is null or the translation return null the labelSafety will be displayed.
  final String labelSafety;
  const CustomButton(
      {required this.icon,
      required this.labelSafety,
      this.labelCode,
      required this.color,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // max available width.
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: CustomText(
          safetyText: labelSafety,
          textCode: labelCode,
        ),
        style: TextButton.styleFrom(
            backgroundColor: color,
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0)),
      ),
    );
  }
}
