import 'package:crayon/providers/score/score_provider.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_button.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crayon/route/route.dart' as route;

/// Shows the score of the player after a quiz.
class Score extends StatefulWidget {
  final int score;
  final int maxScore;
  const Score({Key? key, required this.score, required this.maxScore})
      : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<ScoreProvider>(context, listen: false).postResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Center(
                child: Text(
                  '${widget.score}/${widget.maxScore}',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontFamily: 'Comforter',
                      ),
                ),
              ),
              Consumer<ScoreProvider>(builder: (_, score, __) {
                if (score.state == NotifierState.initial) {
                  return const LoadingWidget();
                } else if (score.state == NotifierState.loaded) {
                  return CustomButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).primaryColor,
                    labelCode: 'back-to-dashboard',
                    labelSafety: 'Back to Dashboard',
                    icon: Icons.dashboard,
                  );
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
