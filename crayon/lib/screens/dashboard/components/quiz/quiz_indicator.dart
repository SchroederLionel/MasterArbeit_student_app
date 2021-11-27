import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizLobbyIndicator extends StatelessWidget {
  const QuizLobbyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizLobbyProvider>(builder: (_, provider, __) {
      if (provider.state == LoadingState.yes) {
        return InkWell(
          onTap: () {
            if (provider.state == LoadingState.yes) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmationDialog(
                        confirmationDialogData: ConfirmationDialogData(
                      itemTitle: provider.lectureName,
                      description: '',
                      title: 'Do you want to leave the Quiz lobby:',
                    ));
                  }).then((value) {
                if (value == true) {
                  provider.reset();
                }
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            height: 30,
            width: 30,
            child: provider.state == LoadingState.yes
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                      Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  )
                : Container(),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
