import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// The confirmation dialog allows the user to confirm an action.
/// Requires ConfirmationDialog Data and allows translation.
class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogData confirmationDialogData;
  const ConfirmationDialog({required this.confirmationDialogData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
        textCode: confirmationDialogData.textCode,
        safetyText: confirmationDialogData.safetyText,
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                confirmationDialogData.itemTitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
      actions: [
        const CancelButton(),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: const CustomText(textCode: 'yes', safetyText: 'Yes'))
      ],
    );
  }
}
