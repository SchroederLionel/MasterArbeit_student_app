import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/providers/util/error_provider.dart';
import 'package:crayon/screens/login/forgot_password.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final errorProvider = Provider.of<ErrorProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextFormField(
                validator: (email) =>
                    ValidatorService.checkEmail(email, appTranslation),
                onChanged: (String email) => loginProvider.setEmail(email),
                controller: _emailController,
                icon: Icons.email,
                labelText: appTranslation!.translate('email') ?? 'Email',
                isPassword: false),
            CustomTextFormField(
                validator: (password) =>
                    ValidatorService.checkPassword(password, appTranslation),
                onChanged: (String password) =>
                    loginProvider.setPassword(password),
                controller: _passwordController,
                icon: Icons.password,
                labelText: appTranslation.translate('password') ?? 'Password',
                isPassword: true),
            const ForgotPassword(),
            const SizedBox(
              height: 18,
            ),
            Consumer<LoginProvider>(
                builder: (context, loginButton, child) => loginButton.state ==
                        LoadingState.no
                    ? CustomButton(
                        icon: Icons.login,
                        color: loginButton.getColor()
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        text: appTranslation.translate('signIn') ?? 'Sign In',
                        onPressed: () => loginButton.changeLoadingState(
                            context, errorProvider))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )),
            Consumer<ErrorProvider>(builder: (context, errorNotifier, child) {
              if (errorNotifier.state == ErrorState.noError) {
                return Container();
              } else {
                return ErrorText(error: errorNotifier.errorText);
              }
            }),
          ],
        ),
      ),
    );
  }
}
