import 'package:crayon/providers/util/theme.dart';
import 'package:crayon/widgets/language_widget.dart';
import 'package:crayon/widgets/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsRow extends StatelessWidget {
  const OptionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      const LanguageWidget(),
      IconButton(
        onPressed: () => themeProvider.swapTheme(),
        icon: const Icon(
          Icons.lightbulb,
          color: Colors.orangeAccent,
        ),
      ),
      const Spacer(),
      const NetworkSensitive(child: SizedBox())
    ]);
  }
}
