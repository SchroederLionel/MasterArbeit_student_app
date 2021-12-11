import 'package:crayon/providers/login/login_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/navigation/components/day_navigation/day_navigation.dart';
import 'package:crayon/screens/dashboard/components/navigation/dialogs/qrcode.dart';
import 'package:crayon/screens/dashboard/components/navigation/dialogs/settings_dialog.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    return Container(
      width: 50,
      color: const Color(0xff1a1c26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const QrCode();
                      }).then((value) async {
                    if (value is String) {
                      provider.addLecture(value);
                    }
                  });
                },
                icon: const Icon(Icons.qr_code_scanner)),
          ),
          const DayNavigation(),
          ListView(
            shrinkWrap: true,
            children: [
              IconButton(
                  onPressed: () => showDialog(
                      context: context, builder: (_) => const SettingsDialog()),
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {
                    Provider.of<LoginProvider>(context, listen: false)
                        .signOut(context);
                  },
                  icon: const Icon(Icons.power_settings_new)),
            ],
          )
        ],
      ),
    );
  }
}
