import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_controller.dart';
import 'package:flutter_app/screens/bottom_tab/account/account_settings_card.dart';
import 'package:flutter_app/screens/bottom_tab/account/user_profile_box.dart';
import 'package:flutter_app/screens/edit_account/edit_account.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';


class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final AccountController _accountController = Get.put(AccountController());


  @override
  Widget build(BuildContext context) {
    _accountController.getProfileInfo();

    return Scaffold(
      body: Obx(() =>
      _accountController.isLoading.value ? circularProgressIndicator() : Container(
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: PreferenceUtils.getGradient()
                ),
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextView.title(Strings.hello, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
              child: Column(
                children: [
                  UserProfileBox(
                      name: '${_accountController.account.firstName} ${_accountController.account.lastName}',
                      email: _accountController.account.email,
                      nameShort: '${_accountController.account.firstName![0]}${_accountController.account.lastName![0]}',
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
                      child: TextView.titleWithDecoration(Strings.accountSettings, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
                  SizedBox(height: sizes.height * 0.03),
                  Column(
                    children: [
                      AccountSettingCard(onChange: (val) => _accountController.changePushNotificationValue(val), title: Strings.pushNotifications, subTitle: Strings.enablePushNotifications, leadingIcon: Assets.bellIcon, switchValue: _accountController.isPushNotifications.value),
                      AccountSettingCard(onChange: (val) => _accountController.changeEmailValue(val), title: Strings.email, subTitle: Strings.allowSystemEmails, leadingIcon: Assets.mailIcon, switchValue: _accountController.isEmail.value),
                      AccountSettingCard(onChange: (val) => _accountController.changeLocationServicesValue(val), title: Strings.locationServices, subTitle: Strings.allowLocationServices, leadingIcon: Assets.locationIcon, switchValue: _accountController.isLocation.value),
                      AccountSettingCard(onChange: (val) => _accountController.changeOtherOptionValue(val), title: Strings.otherOption, subTitle: Strings.otherOptionDescription, leadingIcon: Assets.squareIcon, switchValue: _accountController.isOtherOption.value),
                      AccountSettingCard(onChange: (val) => _accountController.changeOtherOption2Value(val), title: Strings.otherOption2, subTitle: Strings.otherOptionDescription, leadingIcon: Assets.squareIcon, switchValue: _accountController.isOtherOption2.value, isLast: true,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      )

    );
  }
}
