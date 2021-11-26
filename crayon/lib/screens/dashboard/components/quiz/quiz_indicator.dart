import 'package:crayon/datamodels/confirmation_dialog_data.dart';
import 'package:crayon/providers/quiz/quiz_lobby_provider.dart';
import 'package:crayon/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizLobbyIndicator extends StatelessWidget {
  const QuizLobbyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizLobbyProvider>(builder: (_, provider, __) {
      return InkWell(
        onTap: () {
          if (provider.isWaiting) {
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                      confirmationDialogData: ConfirmationDialogData(
                    itemTitle: provider.lectureName,
                    description: '',
                    title: 'Do you want to leave the Quiz lobby:',
                  ));
                });
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          height: 30,
          width: 30,
          child: provider.isWaiting
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
    });
  }
}
