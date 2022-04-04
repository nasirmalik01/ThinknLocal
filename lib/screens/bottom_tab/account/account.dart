import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_components.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AccountComponents _accountComponents = AccountComponents();
  bool _notificationBoolean = false;

  void _onChangeNotifications(bool value) {
    setState(() {
      _notificationBoolean = value;
    });
  }

  bool _emailBoolean = false;

  void _onChangeEmail(bool value2) {
    setState(() {
      _emailBoolean = value2;
    });
  }

  bool _locationBoolean = false;

  void _onChangeLocation(bool value3) {
    setState(() {
      _locationBoolean = value3;
    });
  }

  bool _otherOptionBoolean = false;
  void _onChangeOtherOption(bool value4) {
    setState(() {
      _otherOptionBoolean = value4;
    });
  }

  bool _otherOptionBoolean2 = false;
  void _onChangeOtherOption2(bool value5) {
    setState(() {
      _otherOptionBoolean2 = value5;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Container(
              height: getHeight() * 0.1,
              padding: EdgeInsets.only(bottom: sizes.height * 0.02),
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
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: TextView.getMediumText18("Hello,", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                children: [
                  _accountComponents.profileBox(
                      name: "Johnathon Doe",
                      email: "johnathon.doe@gmail.com",
                      nameShort: "JD",
                      onTapEdit: () {
                        pushNewScreen(
                          context,
                          screen: const EditAccount(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      }
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: TextView.getMediumText15("Account Settings", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
                  SizedBox(height: sizes.height * 0.03),
                  Column(
                    children: [
                      SizedBox(
                        height: getHeight() * 0.08,
                        width: getWidth(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: sizes.width * 0.02),
                            SizedBox(
                                height: getHeight() * 0.04,
                                width: getWidth() * 0.06,
                                child: Image.asset(Assets.bellIcon, color: _notificationBoolean? AppColors.greenColor: AppColors.darkGrey,)),
                            SizedBox(width: sizes.width * 0.05),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView.getMediumText15("Push Notifications", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                    SizedBox(
                                        width: sizes.width * 0.45,
                                        child: TextView.regular11Text("Enable push notifications lorem ipsum", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                  ],
                                ),
                                SizedBox(width: sizes.width * 0.1),
                                CupertinoSwitch(activeColor: AppColors.greenColor ,value: _notificationBoolean, onChanged: (bool value) {_onChangeNotifications(value);}),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
                      SizedBox(
                        height: getHeight() * 0.08,
                        width: getWidth(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: sizes.width * 0.02),
                            SizedBox(
                                height: getHeight() * 0.04,
                                width: getWidth() * 0.06,
                                child: Image.asset(Assets.mailIcon, color: _emailBoolean? AppColors.greenColor: AppColors.darkGrey,)),
                            SizedBox(width: sizes.width * 0.05),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView.getMediumText15("Emails", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                    SizedBox(
                                        width: sizes.width * 0.45,
                                        child: TextView.regular11Text("Allow system emails for causes lorem ipsum", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                  ],
                                ),
                                SizedBox(width: sizes.width * 0.1),
                                CupertinoSwitch(activeColor: AppColors.greenColor ,value: _emailBoolean, onChanged: (bool value) {_onChangeEmail(value);}),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
                      SizedBox(
                        height: getHeight() * 0.08,
                        width: getWidth(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: sizes.width * 0.02),
                            SizedBox(
                                height: getHeight() * 0.04,
                                width: getWidth() * 0.06,
                                child: Image.asset(Assets.locationIcon, color: _locationBoolean? AppColors.greenColor: AppColors.darkGrey,)),
                            SizedBox(width: sizes.width * 0.05),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView.getMediumText15("Location Services", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                    SizedBox(
                                        width: sizes.width * 0.45,
                                        child: TextView.regular11Text("Allow location services while the app is running", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                  ],
                                ),
                                SizedBox(width: sizes.width * 0.1),
                                CupertinoSwitch(activeColor: AppColors.greenColor ,value: _locationBoolean, onChanged: (bool value) {_onChangeLocation(value);}),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
                      SizedBox(
                        height: getHeight() * 0.08,
                        width: getWidth(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: sizes.width * 0.02),
                            SizedBox(
                                height: getHeight() * 0.04,
                                width: getWidth() * 0.06,
                                child: Image.asset(Assets.locationIcon, color: _otherOptionBoolean? AppColors.greenColor: AppColors.darkGrey,)),
                            SizedBox(width: sizes.width * 0.05),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView.getMediumText15("Other Option", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                    SizedBox(
                                        width: sizes.width * 0.45,
                                        child: TextView.regular11Text("Other option description related to something", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                  ],
                                ),
                                SizedBox(width: sizes.width * 0.1),
                                CupertinoSwitch(activeColor: AppColors.greenColor ,value: _otherOptionBoolean, onChanged: (bool value) {_onChangeOtherOption(value);}),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
                      SizedBox(
                        height: getHeight() * 0.08,
                        width: getWidth(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: sizes.width * 0.02),
                            SizedBox(
                                height: getHeight() * 0.04,
                                width: getWidth() * 0.06,
                                child: Image.asset(Assets.locationIcon, color: _otherOptionBoolean2? AppColors.greenColor: AppColors.darkGrey,)),
                            SizedBox(width: sizes.width * 0.05),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView.getMediumText15("Other Option 2", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                    SizedBox(
                                        width: sizes.width * 0.45,
                                        child: TextView.regular11Text("Other option description related to something", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                  ],
                                ),
                                SizedBox(width: sizes.width * 0.1),
                                CupertinoSwitch(activeColor: AppColors.greenColor ,value: _otherOptionBoolean2, onChanged: (bool value) {_onChangeOtherOption2(value);}),
                              ],
                            ),
                          ],
                        ),

                      ),
                      SizedBox(height: sizes.height * 0.02),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
