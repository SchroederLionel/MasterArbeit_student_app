import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogData confirmationDialogData;
  const ConfirmationDialog({required this.confirmationDialogData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        confirmationDialogData.title ??
            appTranslation!.translate('delete') ??
            'Delete',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            confirmationDialogData.description ??
                appTranslation!.translate('confirmationDeletion') ??
                'Confirm deletion',
            style: Theme.of(context).textTheme.bodyText1,
          ),
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
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmationDialogData.acceptTitle ??
                appTranslation!.translate('yes') ??
                'Yes'))
      ],
    );
  }
}
