import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(appTranslation!.translate('hello') ?? 'Hello',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              height: 0.80,
            )),
        Row(
          children: [
            Text(appTranslation.translate('there') ?? 'There',
                style: const TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w700,
                  height: 0.80,
                )),
            const Text('.',
                style: TextStyle(
                    fontSize: 70.0,
                    height: 0.80,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent))
          ],
        )
      ],
    );
  }
}
