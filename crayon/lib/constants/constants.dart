import 'package:flutter/services.dart';

void resetView() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
}
