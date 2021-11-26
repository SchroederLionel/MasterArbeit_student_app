import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class QuizLogin extends StatefulWidget {
  const QuizLogin({Key? key}) : super(key: key);

  @override
  _QuizLoginState createState() => _QuizLoginState();
}

class _QuizLoginState extends State<QuizLogin> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actions: [
        const CancelButton(),
        ElevatedButton(onPressed: () {}, child: const Text('Join'))
      ],
      title: Text(
        "Gameshow",
        style: Theme.of(context).textTheme.headline2,
      ),
      content: CustomTextFormField(
        controller: _nameController,
        icon: Icons.account_circle,
        isPassword: false,
        labelText: 'Username',
        validator: (String? text) =>
            ValidatorService.isStringLengthAbove2(text, appTranslation),
        onChanged: (_) {},
      ),
    );
  }
}
