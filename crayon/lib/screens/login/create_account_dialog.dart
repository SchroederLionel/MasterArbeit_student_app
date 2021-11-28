import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({Key? key}) : super(key: key);

  @override
  _CreateAccountDialogState createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _verificationPassword = TextEditingController();
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
        ElevatedButton(onPressed: () {}, child: Text('Join'))
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text('Create Account',
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
              labelText: appTranslation!.translate('email') ?? 'Email',
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
                  ValidatorService.checkEmail(text, appTranslation),
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
                  ValidatorService.checkEmail(text, appTranslation),
              onChanged: (text) {},
            )
          ],
        ),
      ),
    );
  }
}
