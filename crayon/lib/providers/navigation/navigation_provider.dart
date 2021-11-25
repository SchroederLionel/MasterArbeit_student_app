import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  late PageController _controller;

  setPageController(PageController controller) => _controller = controller;
  int _day = DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1;

  void moveToPage(int pageNumber) {
    if (_day != pageNumber) {
      _day = pageNumber;
      _controller.animateToPage(pageNumber,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      notifyListeners();
    }
  }

  Color getColor(int pageNumber) {
    if (_day == pageNumber) {
      return Colors.orangeAccent;
    } else {
      return const Color(0xff1a1c26);
    }
  }
}
