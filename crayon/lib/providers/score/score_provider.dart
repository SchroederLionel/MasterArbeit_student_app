import 'package:crayon/datamodels/custom_snackbar.dart';
import 'package:crayon/datamodels/failure.dart';
import 'package:crayon/datamodels/quiz/quiz_result.dart';
import 'package:crayon/service/api_service.dart';
import 'package:crayon/state/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ScoreProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  QuizResult result;
  BuildContext context;
  ScoreProvider({required this.result, required this.context});

  setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void postResponse() async {
    ApiService api = ApiService();
    setState(NotifierState.loading);

    Either<Failure, void> _result = await Task(() => api.postResponse(result))
        .attempt()
        .map(
          (either) => either.leftMap((obj) {
            try {
              return obj as Failure;
            } catch (e) {
              throw obj;
            }
          }),
        )
        .run();

    _result.fold((failure) {
      CustomSnackbar(
              text: "responses-were-not-send",
              isError: true,
              context: context,
              saftyString: "Something went wrong")
          .showSnackBar();
    }, (_) {
      CustomSnackbar(
              text: 'Responses send successfully',
              isError: false,
              context: context,
              saftyString: 'Responses send successfully')
          .showSnackBar();
    });
    setState(NotifierState.loaded);
  }
}
