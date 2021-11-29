import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:flutter/material.dart';

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({Key? key}) : super(key: key);

  @override
  _CreateAccountDialogState createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _verificationPassword = TextEditingController();
  String? _error;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _verificationPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return AlertDialog(
      actions: [
        const CancelButton(),
        ElevatedButton(
            onPressed: () {
              var hasError = ValidatorService.isValid(_email.text,
                  _password.text, _verificationPassword.text, appTranslation);
              if (hasError != null) {
                setState(() {
                  _error = hasError;
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(appTranslation!.translate('create') ?? 'Create'))
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
          appTranslation.translate('create-account') ?? 'Create Account',
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24)),
      content: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _email,
              icon: Icons.email,
              isPassword: false,
              labelText: appTranslation.translate('email') ?? 'Email',
              validator: (String? text) =>
                  ValidatorService.checkEmail(text, appTranslation),
              onChanged: (text) {},
            ),
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _password,
              icon: Icons.password,
              isPassword: true,
              labelText: appTranslation.translate('password') ?? 'Password',
              validator: (String? text) =>
                  ValidatorService.checkPassword(text, appTranslation),
              onChanged: (text) {},
            ),
            CustomTextFormField(
              inputAction: TextInputAction.done,
              controller: _verificationPassword,
              icon: Icons.password,
              isPassword: true,
              labelText: appTranslation.translate('newVerificationPass') ??
                  'Verification password',
              validator: (String? text) =>
                  ValidatorService.checkVerificationPassword(
                      _password.text, text, appTranslation),
              onChanged: (text) {},
            ),
            _error == null
                ? Container()
                : Center(child: ErrorText(error: _error as String)),
          ],
        ),
      ),
    );
  }
}
