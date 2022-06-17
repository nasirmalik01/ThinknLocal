import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/widgets/issues_widget.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssuesWidget(
        icon: Assets.updateRequired,
        title: Strings.updateRequired,
        description: Strings.updateRequiredDesc,
        buttonText: Strings.updateAppNow,
        isButtonRequired: true,
        onPress: (){
          StoreRedirect.redirect(androidAppId: "com.thinknlocal.Thinknlocal", iOSAppId: "com.thinknlocal.Thinknlocal");
        },
      ),
    );
  }
}
