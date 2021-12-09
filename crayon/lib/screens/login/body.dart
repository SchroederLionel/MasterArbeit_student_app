import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/user/user_credentials.dart';
import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/screens/login/create_account.dart';
import 'package:crayon/screens/login/forgot_password.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:crayon/widgets/loading_widget.dart';
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
    ValidatorService service = ValidatorService(context: context);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextFormField(
              inputAction: TextInputAction.next,
              validator: (email) => service.checkEmail(email),
              controller: _emailController,
              icon: Icons.email,
              labelCode: 'email',
              labelSafety: 'Email',
            ),
            CustomTextFormField(
              inputAction: TextInputAction.done,
              validator: (password) => service.checkPassword(password),
              controller: _passwordController,
              icon: Icons.password,
              labelCode: 'password',
              labelSafety: 'Password',
            ),
            const ForgotPassword(),
            const SizedBox(
              height: 18,
            ),
            Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  if (provider.state == NotifierState.initial) {
                    return child as Widget;
                  } else if (provider.state == NotifierState.loading) {
                    return const LoadingWidget();
                  } else {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      provider.userCredential.fold(
                          (failure) => CustomSnackbar(
                                  text: failure.code,
                                  context: context,
                                  saftyString: 'Failed to login',
                                  isError: true)
                              .showSnackBar(),
                          (success) => Navigator.of(context)
                              .pushReplacementNamed(route.dashboard));
                    });

                    return child as Widget;
                  }
                },
                child: CustomButton(
                    icon: Icons.login,
                    color: Theme.of(context).primaryColor,
                    labelCode: 'signIn',
                    labelSafety: 'Sign In',
                    onPressed: () {
                      var userBasics = UserBasics(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (userBasics.isValid()) {
                        loginProvider.signUserIn(userBasics);
                      } else {
                        CustomSnackbar(
                                saftyString: 'Fill in all the fields!',
                                context: context,
                                text: 'complete-all-the-fields',
                                isError: true)
                            .showSnackBar();
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
