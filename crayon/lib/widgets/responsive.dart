import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? smallMobile;
  final Widget mobile;
  final Widget? tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    this.smallMobile,
    this.tablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.height <= 480) {
      return smallMobile ?? mobile;
    }
    // If width is higher or equal to 850 and the tablet which is not null then we will return the tablet layout.
    if (_size.width >= 850 && tablet != null) {
      return tablet ?? mobile;
    }
    // Else return mobile layout.
    else {
      return mobile;
    }
  }
}
