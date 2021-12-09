import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  final BuildContext context;
  final String text;
  final String saftyString;
  final bool isError;
  CustomSnackbar(
      {Key? key,
      required this.text,
      required this.saftyString,
      required this.isError,
      required this.context})
      : super(
            key: key,
            backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
            content: Text(
              AppLocalizations.of(context)!.translate(text) ?? saftyString,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
            ));

  showSnackBar() {
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(this));
  }
}
