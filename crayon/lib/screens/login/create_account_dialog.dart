import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({Key? key}) : super(key: key);

  @override
  _CreateAccountDialogState createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationPasswordController =
      TextEditingController();
  String? _error;
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _verificationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return AlertDialog(
      actions: [
        const CancelButton(),
        isLoading
            ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
            : ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  provider
                      .createAccount(
                          UserBasics(
                              email: _emailController.text,
                              password: _passwordController.text),
                          _verificationPasswordController.text)
                      .then((value) => value.fold((failure) {
                            setState(() {
                              _error = failure.code;
                              isLoading = false;
                            });
                          }, (userCredential) {
                            Navigator.of(context).pop();
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.of(context).pushNamed('dashboard');
                            });
                          }));
                },
                child: Text(appTranslation!.translate('create') ?? 'Create'))
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
        overflow: null,
        textAlign: null,
        textCode: 'create-account',
        safetyText: 'Create Account',
        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24),
      ),
      content: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _emailController,
              icon: Icons.email,
              isPassword: false,
              labelText: appTranslation!.translate('email') ?? 'Email',
              validator: (String? text) =>
                  ValidatorService.checkEmail(text, appTranslation),
              onChanged: (text) {},
            ),
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _passwordController,
              icon: Icons.password,
              isPassword: true,
              labelText: appTranslation.translate('password') ?? 'Password',
              validator: (String? text) =>
                  ValidatorService.checkPassword(text, appTranslation),
              onChanged: (text) {},
            ),
            CustomTextFormField(
              inputAction: TextInputAction.done,
              controller: _verificationPasswordController,
              icon: Icons.password,
              isPassword: true,
              labelText: appTranslation.translate('newVerificationPass') ??
                  'Verification password',
              validator: (String? text) =>
                  ValidatorService.checkVerificationPassword(
                      _passwordController.text, text, appTranslation),
              onChanged: (text) {},
            ),
            const SizedBox(height: 10),
            _error == null
                ? Container()
                : Center(child: ErrorText(error: _error as String)),
          ],
        ),
      ),
    );
  }
}
