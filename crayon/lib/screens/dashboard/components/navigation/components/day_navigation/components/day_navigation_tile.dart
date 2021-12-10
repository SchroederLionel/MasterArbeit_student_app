import 'package:crayon/l10n/app_localizations.dart';
import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayNavigationTile extends StatelessWidget {
  final int pageNumber;

  const DayNavigationTile({Key? key, required this.pageNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTranslation = AppLocalizations.of(context);
    String day = appTranslation!.translate('${pageNumber + 1}-day') ?? '?';
    return Consumer<NavigationProvider>(builder: (_, provider, __) {
      return InkWell(
        onTap: () {
          provider.moveToPage(pageNumber);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 10,
          color: provider.getButtonColor(pageNumber),
          child: Text(
            day.substring(0, 1),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 21,
                color: provider.getTextColorColor(pageNumber, context)),
          ),
        ),
      );
    });
  }
}
