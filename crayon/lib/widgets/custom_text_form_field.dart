import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final IconData icon;
  final String labelText;
  final bool isPassword;
  final TextInputAction inputAction;
  const CustomTextFormField(
      {required this.validator,
      required this.onChanged,
      required this.inputAction,
      required this.controller,
      required this.icon,
      required this.labelText,
      required this.isPassword,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        textInputAction: inputAction,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            prefix: Icon(
              icon,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).primaryColor),
            border: const UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            focusColor: Theme.of(context).primaryColor,
            labelText: labelText),
      ),
    );
  }
}
