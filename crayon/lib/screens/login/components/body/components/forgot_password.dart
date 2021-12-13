import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/screens/login/dialog/reset_password_dialog.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return TextButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black87,
              context: context,
              builder: (BuildContext context) {
                return const ResetPasswordDailog();
              }).then((value) {
            if (value is bool) {
              if (value) {
                var snackBar = SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text(
                      appTranslation!.translate(
                              'reset-password-link-was-send-to-your-email') ??
                          'Reset password link was sent to your email',
                      textAlign: TextAlign.center,
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else if (value is Failure) {
              final snackBar = SnackBar(
                  backgroundColor: Colors.redAccent, content: Text(value.code));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        },
        child: CustomText(
            overflow: null,
            textAlign: null,
            textCode: 'forgot-password',
            safetyText: 'Forgot password?',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor)));
  }
}
