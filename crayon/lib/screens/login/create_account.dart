import 'package:crayon/screens/login/create_account_dialog.dart';
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
          child: Text(
            'Create account',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
