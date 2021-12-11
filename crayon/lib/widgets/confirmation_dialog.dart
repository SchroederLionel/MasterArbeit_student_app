import 'package:crayon/constants/constants.dart';
import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

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
      title: const CustomText(textCode: 'delete', safetyText: 'Delete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              textCode: confirmationDialogData.title,
              safetyText: 'Confirm deletion',
              style: Theme.of(context).textTheme.bodyText1),
          Center(
            child: Text(
              confirmationDialogData.itemTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
      actions: [
        const CancelButton(),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
              resetView();
            },
            child: const CustomText(textCode: 'yes', safetyText: 'Yes'))
      ],
    );
  }
}
