import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_components.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
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
  final AccountComponents _accountComponents = AccountComponents();
  bool _value = false;

  void _onChanged(bool value) {
    setState(() {
      _value = value;
    });
  }

  bool _value2 = false;

  void _onChanged2(bool value2) {
    setState(() {
      _value2 = value2;
    });
  }

  bool _value3 = false;

  void _onChanged3(bool value3) {
    setState(() {
      _value3 = value3;
    });
  }

  bool _value4 = false;
  void _onChanged4(bool value4) {
    setState(() {
      _value4 = value4;
    });
  }

  bool _value5 = false;
  void _onChanged5(bool value5) {
    setState(() {
      _value5 = value5;
    });
  }

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
            child: ListView(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  padding: EdgeInsets.only(bottom: sizes!.height * 0.02),
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
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      _accountComponents.profileBox(
                          name: "Johnathon Doe",
                          email: "johnathon.doe@gmail.com",
                          nameShort: "JD",
                          onTapEdit: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const EditAccount()));
                          }
                      ),
                      SizedBox(height: getHeight() * 0.02),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: TextView.getMediumText15("Account Settings", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
                      SizedBox(height: sizes!.height * 0.03),
                      Column(
                        children: [
                          SizedBox(
                            height: getHeight() * 0.08,
                            width: getWidth(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: sizes!.width * 0.02),
                                SizedBox(
                                    height: getHeight() * 0.04,
                                    width: getWidth() * 0.06,
                                    child: Image.asset(Assets.bellicon, color: _value? AppColors.greenColor: AppColors.darkGrey,)),
                                SizedBox(width: sizes!.width * 0.05),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView.getMediumText15("Push Notifications", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                        SizedBox(
                                            width: sizes!.width * 0.45,
                                            child: TextView.regular11Text("Enable push notifications lorem ipsum", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                      ],
                                    ),
                                    SizedBox(width: sizes!.width * 0.1),
                                    CupertinoSwitch(activeColor: AppColors.greenColor ,value: _value, onChanged: (bool value) {_onChanged(value);}),
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
                                SizedBox(width: sizes!.width * 0.02),
                                SizedBox(
                                    height: getHeight() * 0.04,
                                    width: getWidth() * 0.06,
                                    child: Image.asset(Assets.mailIcon, color: _value2? AppColors.greenColor: AppColors.darkGrey,)),
                                SizedBox(width: sizes!.width * 0.05),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView.getMediumText15("Emails", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                        SizedBox(
                                            width: sizes!.width * 0.45,
                                            child: TextView.regular11Text("Allow system emails for causes lorem ipsum", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                      ],
                                    ),
                                    SizedBox(width: sizes!.width * 0.1),
                                    CupertinoSwitch(activeColor: AppColors.greenColor ,value: _value2, onChanged: (bool value) {_onChanged2(value);}),
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
                                SizedBox(width: sizes!.width * 0.02),
                                SizedBox(
                                    height: getHeight() * 0.04,
                                    width: getWidth() * 0.06,
                                    child: Image.asset(Assets.locationIcon, color: _value3? AppColors.greenColor: AppColors.darkGrey,)),
                                SizedBox(width: sizes!.width * 0.05),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView.getMediumText15("Location Services", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                        SizedBox(
                                            width: sizes!.width * 0.45,
                                            child: TextView.regular11Text("Allow location services while the app is running", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                      ],
                                    ),
                                    SizedBox(width: sizes!.width * 0.1),
                                    CupertinoSwitch(activeColor: AppColors.greenColor ,value: _value3, onChanged: (bool value) {_onChanged3(value);}),
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
                                SizedBox(width: sizes!.width * 0.02),
                                SizedBox(
                                    height: getHeight() * 0.04,
                                    width: getWidth() * 0.06,
                                    child: Image.asset(Assets.locationIcon, color: _value4? AppColors.greenColor: AppColors.darkGrey,)),
                                SizedBox(width: sizes!.width * 0.05),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView.getMediumText15("Location Services", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                        SizedBox(
                                            width: sizes!.width * 0.45,
                                            child: TextView.regular11Text("Allow location services while the app is running", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                      ],
                                    ),
                                    SizedBox(width: sizes!.width * 0.1),
                                    CupertinoSwitch(activeColor: AppColors.greenColor ,value: _value4, onChanged: (bool value) {_onChanged4(value);}),
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
                                SizedBox(width: sizes!.width * 0.02),
                                SizedBox(
                                    height: getHeight() * 0.04,
                                    width: getWidth() * 0.06,
                                    child: Image.asset(Assets.locationIcon, color: _value5? AppColors.greenColor: AppColors.darkGrey,)),
                                SizedBox(width: sizes!.width * 0.05),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView.getMediumText15("Location Services", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                                        SizedBox(
                                            width: sizes!.width * 0.45,
                                            child: TextView.regular11Text("Allow location services while the app is running", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 2))
                                      ],
                                    ),
                                    SizedBox(width: sizes!.width * 0.1),
                                    CupertinoSwitch(activeColor: AppColors.greenColor ,value: _value5, onChanged: (bool value) {_onChanged5(value);}),
                                  ],
                                ),
                              ],
                            ),

                          ),
                          Divider(height: getHeight() * 0.03, thickness: getHeight() * 0.001 ,color: AppColors.borderColor),
                        ],
                      )
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
