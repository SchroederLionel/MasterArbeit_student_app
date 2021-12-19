import 'package:crayon/state/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// NavigationProvider is in charge if the navigation.
/// Initialy the state is initial no day-time-navigation will be shown. (Options such as qr code scanning & settings & logout will be shown).
/// If the user is enrolled in at least one lecture the day-time navifation will be shown and changes to the state loaded.
class NavigationProvider extends ChangeNotifier {
  BuildContext context;
  NavigationProvider({required this.context});
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  /// Can be null if the user isn't enrolled in any lecture.
  PageController? _controller;

  /// Function which allows to set the pagecontroller.
  /// Used for the daytime navigation
  /// param required the controller.
  setPageController(PageController controller) {
    _controller = controller;
    setState(NotifierState.loaded);
  }

  /// Function which allows to reset the daytime navigation to initial.
  /// This happens if the user is in no lectures enrolled.
  resetControlller() {
    if (_controller != null) {
      setState(NotifierState.initial);
    }
  }

  /// At init level the dayime selected will be the current weekeday transformed into europeaan norm.
  /// The transformation -1 will allows to make sunday the day 7 instead of 1.
  int _day = DateTime.now().weekday == 0 ? 6 : DateTime.now().weekday - 1;
  int get day => _day;

  /// function which allows day-time-navigation.
  /// If the controller isn'null and the current page is different than the requested page passed as param the _controller will be used to show the new day body.
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
      return Theme.of(context).primaryColor;
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
