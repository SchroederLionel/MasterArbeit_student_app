import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/screens/login/reset_password_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ResetPasswordDailog();
              }).then((value) {
            if (value is bool) {
              if (value) {
                const snackBar = SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text(
                      'Reset password send to your email',
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
        child: const Text(
          'Forgot password?',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontFamily: 'Poppins'),
        ));
  }
}
