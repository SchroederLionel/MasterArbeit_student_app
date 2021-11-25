import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  final String day;
  const NavigationTile({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        elevation: 10,
        color: Color(0xff454952),
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, color: Colors.white),
        ),
      ),
    );
  }
}
