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
        Expanded(
          child: Text(
            appTranslation!.translate('myLectures') ?? 'My Lectures',
            textAlign: TextAlign.right,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline2,
          ),
        )
      ],
    );
  }
}
