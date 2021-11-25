import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TitleDash extends StatelessWidget {
  const TitleDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appTranslation!.translate('myLectures') ?? 'My Lectures',
          style: const TextStyle(
              fontSize: 36,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.black),
        )
      ],
    );
  }
}
