import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

dependencyInjectionSetUp() async {
  /// To register a singleton class
  GetIt.I.registerSingleton<RemoteServices>(RemoteServices());
  GetIt.I<RemoteServices>().init();
}

showSnackBar({String? title, String? subTitle, Color? backgroundColor}){
  Get.closeCurrentSnackbar();
  Get.snackbar(title ?? 'Attention', subTitle ?? 'Please try again', snackPosition: SnackPosition.BOTTOM, backgroundColor: backgroundColor ?? Colors.redAccent, colorText: AppColors.pureWhiteColor, duration: const Duration(seconds: 2),);
}

showLoadingDialog({String? message}){
  Get.dialog(
    Center(
      child: Container(
        height: getHeight()*0.15,
        width: getWidth()*0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.pureWhiteColor.withOpacity(0.4)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCircle(color: AppColors.pureWhiteColor,),
            SizedBox(height: getHeight()*0.01,),
            Material(
                color: Colors.transparent,
                child: TextView.title(message ?? 'Please wait', color: AppColors.pureWhiteColor))
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

circularProgressIndicator(){
  return const Center(
    child: SpinKitFadingCircle(
      color: AppColors.greenColor,
    ),
  );
}