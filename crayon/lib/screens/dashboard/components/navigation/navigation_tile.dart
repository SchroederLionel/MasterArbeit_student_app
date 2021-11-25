import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationTile extends StatelessWidget {
  final int pageNumber;

  final String day;
  const NavigationTile({Key? key, required this.day, required this.pageNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (_, provider, __) {
      return InkWell(
        onTap: () {
          provider.moveToPage(pageNumber);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 10,
          color: provider.getColor(pageNumber),
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 21, color: Colors.white),
          ),
        ),
      );
    });
  }
}
