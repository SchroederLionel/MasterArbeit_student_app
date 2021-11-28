import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';

import 'package:flutter/material.dart';

class ResetPasswordDailog extends StatefulWidget {
  const ResetPasswordDailog({Key? key}) : super(key: key);

  @override
  _ResetPasswordDailogState createState() => _ResetPasswordDailogState();
}

class _ResetPasswordDailogState extends State<ResetPasswordDailog> {
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
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
              if (_emailController.text.isNotEmpty) {}
            },
            child: Text(
                appTranslation.translate('send-request') ?? 'Send request'),
          )
        ],
        content: CustomTextFormField(
          inputAction: TextInputAction.done,
          controller: _emailController,
          icon: Icons.email,
          isPassword: false,
          labelText: appTranslation.translate('email') ?? 'Email',
          validator: (String? text) =>
              ValidatorService.checkEmail(text, appTranslation),
          onChanged: (text) {},
        ));
  }
}
