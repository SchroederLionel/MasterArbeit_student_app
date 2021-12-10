import 'package:crayon/screens/login/dialog/create_account_dialog.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CreateAccountDialog();
                });
          },
          child: CustomText(
            textCode: 'create-account',
            safetyText: 'Create account',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600),
          )),
    );
  }
}
