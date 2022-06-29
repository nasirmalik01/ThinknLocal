import 'package:flutter/material.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/account.dart';
import 'package:thinknlocal_app/screens/sign_in/login_controller.dart';
import 'package:thinknlocal_app/widgets/button.dart';
import 'package:thinknlocal_app/widgets/text_field.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/text_views.dart';

class RequiredParamsScreen extends StatefulWidget {
  final Account? account;
  const RequiredParamsScreen({this.account, Key? key}) : super(key: key);

  @override
  _RequiredParamsScreenState createState() => _RequiredParamsScreenState();
}

class _RequiredParamsScreenState extends State<RequiredParamsScreen> {
  TextEditingController? zipCodeController;
  final LogInController _logInController = Get.put(LogInController());

  @override
  void initState() {
    super.initState();
    zipCodeController = TextEditingController();
  }

  @override
  void dispose() {
    zipCodeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: sizes.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  width: getWidth(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.lightGreenColor,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06, ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: TextView.headerWithBlurRadius("Back", color: AppColors.lightBlack,fontFamily: Assets.poppinsMedium,
                            textDecoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight() * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.header("Add Required Info", color: AppColors.lightBlack, fontFamily: Assets.poppinsSemiBold, lines: 1, fontSize: sizes.fontSize25),
                      SizedBox(height: getHeight() * 0.04),
                      TextView.titleWithDecoration("Basic info", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.01),
                      TextView.titleWithDecoration("Zip Code", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium),
                      SizedBox(height: getHeight() * 0.01),
                      TextFieldWidget(textEditingController: zipCodeController, hint: "Zip Code", textInputType: TextInputType.number, ),
                      SizedBox(height: getHeight() * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(onPress: (){
                            Navigator.pop(context);
                          },
                              width: sizes.width * 0.42, height: getHeight() * 0.08,
                              text: 'Cancel', textColor: AppColors.pureWhiteColor,
                              btnColor: AppColors.borderColor),
                          Button(onPress: () async {
                            if( zipCodeController!.text.isEmpty){
                              return showSnackBar(subTitle: Strings.requiredFieldError);
                            }

                            if(zipCodeController!.text.length != 5){
                              return showSnackBar(subTitle: Strings.zipCodeError);
                            }

                            if(_provider == Strings.apple) {
                              _logInController.loginWithApple( zip: zipCodeController!.text);
                            }
                            else{
                              _logInController.loginWithGoogle(zip: zipCodeController!.text);
                            }
                          },
                              width: sizes.width * 0.42, height: getHeight() * 0.08,
                              text: 'Submit', textColor: AppColors.pureWhiteColor,
                              btnColor: AppColors.greenColor),
                        ],
                      ),
                      SizedBox(height: getHeight() * 0.04),
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