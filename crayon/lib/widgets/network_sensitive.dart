import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  const NetworkSensitive({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.wifi) {
      return child;
    } else if (connectionStatus == ConnectivityStatus.cellular) {
      return child;
    } else {
      return const NoInternet();
    }
  }
}
