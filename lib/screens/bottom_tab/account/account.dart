import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_components.dart';
import 'package:flutter_app/widgets/text_views.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  AccountComponents _accountComponents = AccountComponents();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: sizes!.height,
            width: sizes!.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      TextView.getMediumText18("Hello,", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView.bold12Text("Help", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),
                          TextView.bold12Text("Sign out", color: AppColors.orangeColor, fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline),
                        ],
                      ),
                      //SizedBox(height: getHeight() * 0.01),
                      _accountComponents.profileBox(
                          name: "Johnathon Doe",
                          email: "johnathon.doe@gmail.com",
                          nameShort: "JD"
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: TextView.getMediumText15("Account Settings", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
                      _accountComponents.accountSettingCard(
                          icon: Icons.notification_important,
                          title: "Push Notifications",
                          description: "Enable push notifications lorem ipsum."
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
