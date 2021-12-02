import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/navigation/navigation_tile.dart';
import 'package:crayon/screens/dashboard/components/navigation/settings_dialog.dart';
import 'package:crayon/screens/dashboard/components/qrcode/qrcode.dart';
import 'package:crayon/service/auth_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crayon/route/route.dart' as route;

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
          Consumer<UserProvider>(builder: (_, _provider, __) {
            if (_provider.state == NotifierState.initial) {
              return const SizedBox();
            } else if (_provider.state == NotifierState.loading) {
              return const LoadingWidget();
            } else {
              return _provider.user.fold(
                  (failure) => const SizedBox(),
                  (_) => Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return NavigationTile(pageNumber: index);
                            }),
                      ));
            }
          }),
          ListView(
            shrinkWrap: true,
            children: [
              IconButton(
                  onPressed: () => showDialog(
                      context: context, builder: (_) => const SettingsDialog()),
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {
                    AuthService().signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        route.login, (Route<dynamic> route) => false);
                  },
                  icon: const Icon(Icons.power_settings_new)),
            ],
          )
        ],
      ),
    );
  }
}
