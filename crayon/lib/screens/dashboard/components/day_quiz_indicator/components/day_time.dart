import 'package:crayon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DayTime extends StatelessWidget {
  const DayTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    var now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            getStringSize3(
              appTranslation!.translate('${now.weekday}-day') ??
                  '${now.weekday}',
            ),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            '${getStringSize3(appTranslation.translate('${now.month}-month') ?? '${now.month}')} ${getStringSize2(now.year.toString())}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          )
        ]),
        const SizedBox(width: 5),
        Text(
          getStringSize2(now.day.toString()),
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }

  String getStringSize2(String text) {
    return text.length > 3 ? text.substring(2, 4) : text;
  }

  String getStringSize3(String text) {
    return text.length > 3 ? text.substring(0, 3) : text;
  }
}
