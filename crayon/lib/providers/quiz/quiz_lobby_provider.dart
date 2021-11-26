import 'package:crayon/state/enum.dart';
import 'package:flutter/cupertino.dart';

class QuizLobbyProvider extends ChangeNotifier {
  final BuildContext context;
  LoadingState _state = LoadingState.no;

  QuizLobbyProvider({required this.context});

  late String _lectureId;
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  set(String lectureId, bool isWaiting) {
    _isWaiting = isWaiting;
    lectureId = lectureId;
    notifyListeners();
  }
}
