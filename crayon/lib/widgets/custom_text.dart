import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? style;
  final String? textCode;
  final String safetyText;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? additional;

  const CustomText(
      {Key? key,
      this.textCode,
      this.additional,
      required this.safetyText,
      this.style,
      this.textAlign,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    String? text;
    if (textCode == null) {
      text = safetyText;
    } else {
      text = appTranslation!.translate(textCode as String);
    }
    if (additional != null) {
      text = '$text $additional';
    }
    return Text(
      text ?? safetyText,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
