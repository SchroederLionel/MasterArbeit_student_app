import 'package:crayon/screens/dashboard/components/navigation/navigation_tile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      color: const Color(0xff222429),
      alignment: Alignment.centerLeft,
      child: ListView(
        shrinkWrap: true,
        children: const [
          NavigationTile(day: 'M', pageNumber: 0),
          NavigationTile(day: 'T', pageNumber: 1),
          NavigationTile(day: 'W', pageNumber: 2),
          NavigationTile(day: 'T', pageNumber: 3),
          NavigationTile(day: 'F', pageNumber: 4),
          NavigationTile(day: 'S', pageNumber: 5),
          NavigationTile(day: 'S', pageNumber: 6),
        ],
      ),
    );
  }
}
