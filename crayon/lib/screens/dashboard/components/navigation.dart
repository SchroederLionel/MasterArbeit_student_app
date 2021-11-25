import 'package:crayon/screens/dashboard/components/navigation/navigation_tile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _drawerOpened = false;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 65,
          color: const Color(0xff222429),
          alignment: Alignment.centerLeft,
          child: Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const [
                NavigationTile(day: 'M'),
                NavigationTile(day: 'T'),
                NavigationTile(day: 'W'),
                NavigationTile(day: 'T'),
                NavigationTile(day: 'F'),
                NavigationTile(day: 'S'),
                NavigationTile(day: 'S'),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: const RotatedBox(
            quarterTurns: 3,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.only(top: 58),
              color: Color(0xff222429),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
