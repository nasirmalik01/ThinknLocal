import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/issues_widget.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IssuesWidget(
        icon: Assets.underMaintenance,
        title: Strings.underMaintenance,
        description: Strings.underMaintenanceDesc,
      ),
    );
  }
}
