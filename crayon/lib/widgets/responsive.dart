import 'package:flutter/material.dart';

/// Responsive widget is used to provide a different screen depending on the screen hight and width.
/// Mobile screen required to ensure at least one screen is provided.
class Responsive extends StatelessWidget {
  final Widget? smallMobile;

  /// Mobile screen required.
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
    // Small mobile (if height of mobile is less than 480)
    final Size _size = MediaQuery.of(context).size;
    if (_size.height <= 480) {
      return smallMobile ?? mobile;
    }
    // If width is higher or equal to 850 and the tablet which is not null then we will return the tablet layout.
    // if no tablet layout available return mobile screen.
    if (_size.width >= 850 && tablet != null) {
      return tablet ?? mobile;
    }
    // Else return mobile layout.
    else {
      return mobile;
    }
  }
}
