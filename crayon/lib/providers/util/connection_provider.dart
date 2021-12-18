import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:crayon/state/enum.dart';

class ConnectionProvider {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectionProvider() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Convert result into enum
      var connectionStatus = _getStatusFromResult(result);
      // Broadcast value
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
