import 'package:crayon/datamodels/lecture/lecture.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lecture_data.length,
        itemBuilder: (context, index) {
          return const Card();
        });
  }
}
