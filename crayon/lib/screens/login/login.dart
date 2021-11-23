import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/providers/util/error_provider.dart';
import 'package:crayon/providers/util/theme.dart';
import 'package:crayon/screens/login/reset_password_dialog.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/error_text.dart';
import 'package:crayon/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final errorProvider = Provider.of<ErrorProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(children: [
            Row(children: [
              const LanguageWidget(),
              IconButton(
                  onPressed: () => themeProvider.swapTheme(),
                  icon: const Icon(
                    Icons.lightbulb,
                  )),
            ]),
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/crayon.png',
                        height: 100,
                      ),
                      CustomTextFormField(
                          validator: (email) => ValidatorService.checkEmail(
                              email, appTranslation),
                          onChanged: (String email) => {},
                          // loginProvider.setEmail(email),
                          controller: _emailController,
                          icon: Icons.email,
                          labelText:
                              appTranslation!.translate('email') ?? 'Email',
                          isPassword: false),
                      CustomTextFormField(
                          validator: (password) =>
                              ValidatorService.checkPassword(
                                  password, appTranslation),
                          onChanged: (String password) => {},
                          // loginProvider.setPassword(password),
                          controller: _passwordController,
                          icon: Icons.password,
                          labelText: appTranslation.translate('password') ??
                              'Password',
                          isPassword: true),
                      Consumer<LoginProvider>(
                          builder: (context, loginButton, child) =>
                              loginButton.state == LoadingState.no
                                  ? CustomButton(
                                      icon: Icons.login,
                                      color: loginButton.getColor(),
                                      text:
                                          appTranslation.translate('signIn') ??
                                              'Sign In',
                                      onPressed: () =>
                                          loginButton.changeLoadingState(
                                              context, errorProvider))
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    )),
                      TextButton(
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else if (value is Failure) {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text(value.code));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          },
                          child: const Text('Forgot password')),
                      Consumer<ErrorProvider>(
                          builder: (context, errorNotifier, child) {
                        if (errorNotifier.state == ErrorState.noError) {
                          return Container();
                        } else {
                          return ErrorText(error: errorNotifier.errorText);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
