import 'package:crayon/state/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  PageController? _controller;

  setPageController(PageController controller) {
    _controller = controller;
    setState(NotifierState.loaded);
  }

  resetControlller() {
    if (_controller != null) {
      // _controller!.dispose();
      setState(NotifierState.initial);
    }
  }

  int _day = DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1;
  int get day => _day;

  void moveToPage(int pageNumber) {
    if (_controller != null) {
      if (_day != pageNumber) {
        _day = pageNumber;
        _controller!.animateToPage(pageNumber,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
        notifyListeners();
      }
    }
  }

  Color getButtonColor(int pageNumber) {
    if (_day == pageNumber) {
      return Colors.orangeAccent;
    } else {
      return const Color(0xff1a1c26);
    }
  }

  Color getTextColorColor(int pageNumber, BuildContext context) {
    if (_day == pageNumber) {
      return Colors.white;
    } else {
      return Colors.white70;
    }
  }
}
