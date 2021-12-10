import 'package:crayon/providers/util/theme.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LanguageWidget(),
            ElevatedButton.icon(
                onPressed: () => themeProvider.swapTheme(),
                icon: const Icon(Icons.lightbulb_outline),
                label: const CustomText(
                    textCode: 'brightness', safetyText: 'Brightness'))
          ],
        ),
      ),
    );
  }
}
