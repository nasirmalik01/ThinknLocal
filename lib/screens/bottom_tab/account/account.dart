import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/utils.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/account/account_controller.dart';
import 'package:thinknlocal_app/screens/bottom_tab/account/account_settings_card.dart';
import 'package:thinknlocal_app/screens/bottom_tab/account/user_profile_box.dart';
import 'package:thinknlocal_app/screens/edit_account/edit_account.dart';
import 'package:thinknlocal_app/widgets/loading_indicator.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';
import 'package:get/get.dart';

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
      body: Obx(() => _accountController.isError.value
       ? const SizedBox()
       : _accountController.isLoading.value
       ? bouncingLoadingIndicator()
       : Container(
        height: sizes.height ,
        width: sizes.width,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: PreferenceUtils.getGradient()
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: getHeight() * 0.1,
              width: getWidth(),
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
                  child: TextView.title(Strings.hello, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium,)),
            ),
            Container(
              color: AppColors.pureWhiteColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: Column(
                  children: [
                    UserProfileBox(
                        name: '${_accountController.account?.firstName ?? Strings.unknown} ${_accountController.account!.lastName ?? ''}',
                        email: _accountController.account?.email,
                        nameShort: '${_accountController.account?.firstName?[0] ?? ''}${_accountController.account?.lastName?[0] ?? ''}',
                        onTapEdit: () async {
                          await Get.to(() => EditAccount(account: _accountController.account,));
                          _accountController.getProfileInfo();
                        },
                      onHelpClick: (){
                        _accountController.openBeacon();
                      }
                    ),
                    SizedBox(height: getHeight() * 0.02),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TextView.titleWithDecoration(Strings.accountSettings, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium)),
                    SizedBox(height: sizes.height * 0.03),
                    Column(
                      children: [
                        AccountSettingCard(onChange: (val) => _accountController.changePushNotificationValue(val), title: Strings.pushNotifications, subTitle: Strings.enablePushNotifications, leadingIcon: Assets.notificationSvg, switchValue: _accountController.isPushNotifications.value),
                        AccountSettingCard(onChange: (val) => _accountController.changeEmailValue(val), title: Strings.email.capitalizeFirst, subTitle: Strings.allowSystemEmails, leadingIcon: Assets.emailSvg, switchValue: _accountController.isEmail.value),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      )

    );
  }
}
