import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/screens/login/create_account.dart';
import 'package:crayon/screens/login/forgot_password.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crayon/route/route.dart' as route;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextFormField(
                inputAction: TextInputAction.next,
                validator: (email) =>
                    ValidatorService.checkEmail(email, appTranslation),
                onChanged: (String email) => {},
                controller: _emailController,
                icon: Icons.email,
                labelText: appTranslation!.translate('email') ?? 'Email',
                isPassword: false),
            CustomTextFormField(
                inputAction: TextInputAction.done,
                validator: (password) =>
                    ValidatorService.checkPassword(password, appTranslation),
                onChanged: (String password) => {},
                controller: _passwordController,
                icon: Icons.password,
                labelText: appTranslation.translate('password') ?? 'Password',
                isPassword: true),
            const ForgotPassword(),
            const SizedBox(
              height: 18,
            ),
            Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  if (provider.state == NotifierState.initial) {
                    return child as Widget;
                  } else if (provider.state == NotifierState.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      provider.userCredential.fold(
                          (l) => ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackbar(
                                  text: appTranslation.translate(l.code) ??
                                      l.code,
                                  isError: true)),
                          (r) => Navigator.of(context)
                              .pushReplacementNamed(route.dashboard));
                    });

                    return child as Widget;
                  }
                },
                child: CustomButton(
                    icon: Icons.login,
                    color: Theme.of(context).primaryColor,
                    text: appTranslation.translate('signIn') ?? 'Sign In',
                    onPressed: () {
                      var userBasics = UserBasics(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (userBasics.isValid()) {
                        loginProvider.signUserIn(userBasics);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                                text: appTranslation
                                        .translate('complete-all-the-fields') ??
                                    'Fill in all the fields!',
                                isError: true));
                      }
                    })),
            const SizedBox(
              height: 18,
            ),
            const CreateAccount(),
          ],
        ),
      ),
    );
  }
}
