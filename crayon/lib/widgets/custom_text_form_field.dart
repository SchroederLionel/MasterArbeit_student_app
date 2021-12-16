import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// CustomTextFormField is a widgets which allows to use a text field with a form field.
/// Used for input checks and keeping the same layout for each textfield.
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  /// Validator function which is used by the form widget to check if a string is valid.(returns null if string is valid).
  final String? Function(String?)? validator;
  final IconData icon;
  final String? labelCode;
  final String labelSafety;
  final bool? isPassword;
  final TextInputAction inputAction;
  const CustomTextFormField(
      {required this.validator,
      this.onChanged,
      required this.inputAction,
      required this.controller,
      required this.icon,
      required this.labelSafety,
      this.labelCode,
      this.isPassword,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    String labelText = '';
    if (labelCode != null) {
      labelText = appTranslation!.translate(labelCode as String) ?? labelSafety;
    } else {
      labelText = labelSafety;
    }
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        obscureText: isPassword ?? false,
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
