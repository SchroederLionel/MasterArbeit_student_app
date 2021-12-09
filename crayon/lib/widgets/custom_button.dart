import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final String? labelCode;
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
