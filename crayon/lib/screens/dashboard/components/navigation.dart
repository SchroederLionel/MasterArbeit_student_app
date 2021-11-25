import 'package:crayon/screens/dashboard/components/navigation/navigation_tile.dart';
import 'package:crayon/screens/dashboard/components/navigation/settings_dialog.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      color: const Color(0xff1a1c26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.qr_code_scanner)),
          ),
          ListView(
            shrinkWrap: true,
            children: const [
              NavigationTile(pageNumber: 0),
              NavigationTile(pageNumber: 1),
              NavigationTile(pageNumber: 2),
              NavigationTile(pageNumber: 3),
              NavigationTile(pageNumber: 4),
              NavigationTile(pageNumber: 5),
              NavigationTile(pageNumber: 6),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              IconButton(
                  onPressed: () => showDialog(
                      context: context, builder: (_) => const SettingsDialog()),
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.power_settings_new))
            ],
          ),
        ],
      ),
    );
  }
}
