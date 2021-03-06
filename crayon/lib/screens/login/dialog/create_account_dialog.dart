import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:crayon/route/route.dart' as route;
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
    ValidatorService service = ValidatorService(context: context);
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return AlertDialog(
      scrollable: true,
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
                            Navigator.of(context)
                                .popAndPushNamed(route.dashboard);
                          }));
                },
                child:
                    const CustomText(textCode: 'create', safetyText: 'Create'))
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
      content: SizedBox(
        width: 500,
        child: Column(
          children: [
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _emailController,
              icon: Icons.email,
              labelCode: 'email',
              labelSafety: 'Email',
              validator: (String? text) => service.checkEmail(text),
              onChanged: (text) {},
            ),
            CustomTextFormField(
              inputAction: TextInputAction.next,
              controller: _passwordController,
              icon: Icons.password,
              isPassword: true,
              labelCode: 'password',
              labelSafety: 'Password',
              validator: (String? text) => service.checkPassword(text),
            ),
            CustomTextFormField(
              inputAction: TextInputAction.done,
              controller: _verificationPasswordController,
              icon: Icons.password,
              isPassword: true,
              labelCode: 'newVerificationPass',
              labelSafety: 'Verification password',
              validator: (String? text) => service.checkVerificationPassword(
                  _passwordController.text, text),
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
