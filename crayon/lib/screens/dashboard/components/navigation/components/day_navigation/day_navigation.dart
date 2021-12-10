import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/navigation/components/day_navigation/components/day_navigation_tile.dart';
import 'package:crayon/state/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayNavigation extends StatelessWidget {
  const DayNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<NavigationProvider, UserProvider>(
        builder: (_, _navigationProvider, _userProvider, __) {
      if (_userProvider.user == null) {
        return const SizedBox();
      }
      if (_userProvider.user!.enrolledLectures.isEmpty) {
        return const SizedBox();
      }
      if (_navigationProvider.state == NotifierState.initial) {
        return const SizedBox();
      } else {
        return Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (context, index) {
                return DayNavigationTile(pageNumber: index);
              }),
        );
      }
    });
  }
}
