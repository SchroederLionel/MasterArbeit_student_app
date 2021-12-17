import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// Button which allows to pop a dialog.
class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
        onPressed: () {
          Navigator.pop(context, false);
        },
        child: const CustomText(safetyText: 'Cancel', textCode: 'cancel'));
  }
}
