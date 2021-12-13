import 'package:crayon/constants/constants.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
          textCode: 'question',
          safetyText: 'Question',
          style: Theme.of(context).textTheme.headline2),
      content: SizedBox(
        width: 400,
        child: CustomTextFormField(
          inputAction: TextInputAction.done,
          validator: (String? text) =>
              ValidatorService(context: context).isStringLengthAbove2(text),
          controller: _questionController,
          icon: Icons.contact_support,
          labelCode: 'question',
          labelSafety: 'Question',
        ),
      ),
      actions: [
        const CancelButton(),
        ElevatedButton(
            onPressed: () {
              resetView();
              Navigator.pop(context, _questionController.text);
            },
            child: const CustomText(textCode: 'send', safetyText: 'Send'))
      ],
    );
  }
}
