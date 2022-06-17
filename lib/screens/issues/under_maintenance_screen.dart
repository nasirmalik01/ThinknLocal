import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/issues_widget.dart';
import 'package:get/get.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssuesWidget(
        icon: Assets.underMaintenance,
        title: Strings.underMaintenance,
        description: Strings.underMaintenanceDesc,
        buttonText: Strings.retry,
        isButtonRequired: true,
        onPress: (){
          PreferenceUtils.setBool(Strings.showHome, true);
          Get.offAndToNamed(Routes.bottomNavBarScreen);
        },
      ),
    );
  }
}
