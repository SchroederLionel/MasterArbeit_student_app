import 'package:crayon/constants/constants.dart';
import 'package:crayon/service/validator_service.dart';
import 'package:crayon/widgets/cancel_button.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizLogin extends StatefulWidget {
  const QuizLogin({Key? key}) : super(key: key);

  @override
  _QuizLoginState createState() => _QuizLoginState();
}

class _QuizLoginState extends State<QuizLogin> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actions: [
        const CancelButton(),
        ElevatedButton(
            onPressed: () {
              if (_nameController.text.length > 1) {
                resetView();
                Navigator.of(context).pop(_nameController.text);
              }
            },
            child: const CustomText(textCode: 'join', safetyText: 'Join'))
      ],
      title: CustomText(
          textCode: 'gameshow',
          safetyText: 'Gameshow',
          style: Theme.of(context).textTheme.headline2),
      content: SizedBox(
        width: 400,
        child: CustomTextFormField(
          inputAction: TextInputAction.done,
          controller: _nameController,
          icon: Icons.account_circle,
          labelSafety: 'Username',
          labelCode: 'username',
          validator: (String? text) =>
              ValidatorService(context: context).isStringLengthAbove2(text),
        ),
      ),
    );
  }
}
