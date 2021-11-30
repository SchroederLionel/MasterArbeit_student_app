import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 70,
          width: 70,
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor)),
    );
  }
}
