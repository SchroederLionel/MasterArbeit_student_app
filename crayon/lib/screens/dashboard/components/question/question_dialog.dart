import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class QuestionDialog extends StatefulWidget {
  const QuestionDialog({Key? key}) : super(key: key);

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController _questionController = TextEditingController();
  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Question',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: CustomTextFormField(
          inputAction: TextInputAction.done,
          validator: (String? text) =>
              ValidatorService.isStringLengthAbove2(text, appTranslation),
          onChanged: (_) {},
          controller: _questionController,
          icon: Icons.contact_support,
          labelText: 'Question',
          isPassword: false),
      actions: [
        const CancelButton(),
        ElevatedButton(onPressed: () {}, child: const Text('Send'))
      ],
    );
  }
}
