import 'package:crayon/providers/navigation/navigation_provider.dart';
import 'package:crayon/providers/user/user_provider.dart';
import 'package:crayon/screens/dashboard/components/lecture_stream.dart';
import 'package:crayon/state/enum.dart';
import 'package:crayon/widgets/custom_text.dart';
import 'package:crayon/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      if (provider.state == NotifierState.initial) {
        return const SizedBox();
      } else if (provider.state == NotifierState.loading) {
        return const LoadingWidget();
      } else {
        if (provider.user == null) {
          return const SizedBox();
        } else {
          if (provider.user!.enrolledLectures.isEmpty) {
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              Provider.of<NavigationProvider>(context, listen: false)
                  .resetControlller();
            });
            return const Center(
                child: CustomText(
                    safetyText: "You aren't enrollet in any course",
                    textCode: 'no-courses-enrolled'));
          } else {
            return LectureStream(user: provider.user!);
          }
        }
      }
    });
  }
}
