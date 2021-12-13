import 'package:crayon/constants/constants.dart';
import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: CustomText(
            textCode: 'reset-password',
            safetyText: 'Reset password',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 24)),
        actions: [
          const CancelButton(),
          ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              provider
                  .resetPassword(_emailController.text)
                  .then((value) => value.fold((failure) {
                        setState(() {
                          hasError = true;
                          errorText = failure.code;
                        });
                      }, (worked) {
                        resetView();
                        Navigator.of(context).pop();
                        CustomSnackbar(
                                saftyString:
                                    'Reset password link was sent to your email',
                                context: context,
                                text:
                                    'reset-password-link-was-send-to-your-email',
                                isError: false)
                            .showSnackBar();
                      }));
            },
            child: const CustomText(
              overflow: null,
              textAlign: null,
              textCode: 'send',
              safetyText: 'Send',
              style: null,
            ),
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
              labelCode: 'email',
              labelSafety: 'Email',
              validator: (String? text) =>
                  ValidatorService(context: context).checkEmail(text),
            ),
            const SizedBox(height: 10),
            hasError ? ErrorText(error: errorText) : Container()
          ],
        ));
  }
}
