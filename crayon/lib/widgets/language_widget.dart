import 'package:crayon/datamodels/custom_locale.dart';
import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/l10n/l10n.dart';
import 'package:crayon/providers/util/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Language widget is used to change the language;
class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// localProvider allows to change the language of the app.
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return DropdownButton(
      value: localeProvider.getLocal,
      icon: Container(
        child: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        margin: const EdgeInsets.only(left: 5),
      ),
      iconSize: 24,
      elevation: 16,
      onChanged: (_) {},
      items: AppLocalizations.languages.map((CustomLocale locale) {
        final String flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          alignment: Alignment.center,
          value: locale,
          child: Text(
            flag,
            style: const TextStyle(fontSize: 24),
          ),
          onTap: () {
            localeProvider
                .setLocale(CustomLocale(languageCode: locale.languageCode));
          },
        );
      }).toList(),
    );
  }
}
