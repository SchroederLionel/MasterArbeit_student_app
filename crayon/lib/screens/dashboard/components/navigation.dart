import 'package:crayon/screens/dashboard/components/navigation/navigation_tile.dart';
import 'package:crayon/screens/dashboard/components/navigation/settings_dialog.dart';
import 'package:crayon/screens/dashboard/components/qrcode/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Navigation extends StatelessWidget {
  late Barcode? result;
  late QRViewController? controller;
  Navigation({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
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
                      builder: (context) {
                        return const QrCode();
                      }).then((value) {
                    if (value is String) {
                      const snackBar = SnackBar(
                          backgroundColor: Colors.greenAccent,
                          content: Text(
                            'Lecture added to your lectures',
                            style: const TextStyle(color: Colors.white),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                icon: const Icon(Icons.qr_code_scanner)),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return NavigationTile(pageNumber: index);
                }),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              IconButton(
                  onPressed: () => showDialog(
                      context: context, builder: (_) => const SettingsDialog()),
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.power_settings_new)),
            ],
          )
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      result = scanData;
    });
  }
}
