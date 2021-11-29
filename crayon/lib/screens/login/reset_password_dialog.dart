import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class ResetPasswordDailog extends StatefulWidget {
  const ResetPasswordDailog({Key? key}) : super(key: key);

  @override
  _ResetPasswordDailogState createState() => _ResetPasswordDailogState();
}

class _ResetPasswordDailogState extends State<ResetPasswordDailog> {
  late TextEditingController _emailController;
  String errorText = '';
  bool hasError = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          appTranslation!.translate('reset-password') ?? 'Reset password',
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24),
        ),
        actions: [
          const CancelButton(),
          ElevatedButton(
            onPressed: () async {
              provider
                  .resetPassword(_emailController.text)
                  .then((value) => value.fold((failure) {
                        setState(() {
                          hasError = true;
                          errorText = failure.code;
                        });
                      }, (worked) {
                        Navigator.of(context).pop();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                              text: appTranslation.translate(
                                      'reset-password-link-was-send-to-your-email') ??
                                  'Reset password link was sent to your email',
                              isError: false));
                        });
                      }));
            },
            child: Text(appTranslation.translate('send') ?? 'Send'),
          )
        ],
        content: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          children: [
            CustomTextFormField(
              inputAction: TextInputAction.done,
              controller: _emailController,
              icon: Icons.email,
              isPassword: false,
              labelText: appTranslation.translate('email') ?? 'Email',
              validator: (String? text) =>
                  ValidatorService.checkEmail(text, appTranslation),
              onChanged: (text) {},
            ),
            const SizedBox(height: 10),
            hasError ? ErrorText(error: errorText) : Container()
          ],
        ));
  }
}
