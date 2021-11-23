import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final double score;
  const Score({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your score',
                style: TextStyle(
                    fontFamily: 'Poppoins', color: Colors.white, fontSize: 26),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                height: 100,
                child: Text(
                  score.toString(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue,
                        Colors.blueAccent,
                        Colors.green,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
