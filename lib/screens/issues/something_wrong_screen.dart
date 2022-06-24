import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/widgets/issues_widget.dart';

class SomethingWrong extends StatelessWidget {
  const SomethingWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IssuesWidget(
        icon: Assets.somethingWrong,
        title: Strings.somethingWrong,
        description: Strings.somethingWrongDesc,

      ),
    );
  }
}
