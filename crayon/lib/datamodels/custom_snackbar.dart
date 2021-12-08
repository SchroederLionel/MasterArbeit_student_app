import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  final BuildContext context;
  final String text;
  final bool isError;
  CustomSnackbar(
      {Key? key,
      required this.text,
      required this.isError,
      required this.context})
      : super(
            key: key,
            backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
            content: Text(
              AppLocalizations.of(context)!.translate(text) ?? text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
            ));
}
