import 'package:crayon/providers/quiz/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Provider.of<TimeProvider>(context, listen: false).start());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeProvider>(
      builder: (_, timeProver, __) {
        return Text(
          '${timeProver.remainingDuration}',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        );
      },
    );
  }
}
