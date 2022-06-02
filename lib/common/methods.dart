import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/local/user_location.dart';
import 'package:flutter_app/model/cities.dart';
import 'package:flutter_app/network/remote_repositories/location_repository.dart';
import 'package:flutter_app/network/remote_services.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';


///my dependency locator
GetIt getItLocator = GetIt.instance;
dependencyInjectionSetUp() {
  getItLocator.registerSingleton<RemoteServices>(RemoteServices());
}

///remove all Dependencies at the end of testing in tearDown
removeDependencies() {
  getItLocator.unregister(instance: RemoteServices());
}

showSnackBar({String? title, String? subTitle, Color? backgroundColor}) {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    title ?? 'Alert',
    subTitle ?? 'Please try again',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.redAccent,
    colorText: AppColors.pureWhiteColor,
    duration: const Duration(seconds: 2),
  );
}

showLoadingDialog({String? message}) {
  Get.dialog(
    Center(
      child: Container(
        height: getHeight() * 0.15,
        width: getWidth() * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.pureWhiteColor.withOpacity(0.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCircle(
              color: AppColors.pureWhiteColor,
            ),
            SizedBox(
              height: getHeight() * 0.01,
            ),
            Material(
                color: Colors.transparent,
                child: TextView.title(message ?? 'Please wait',
                    color: AppColors.pureWhiteColor))
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

circularProgressIndicator() {
  return const Center(
    child: SpinKitFadingCircle(
      color: AppColors.greenColor,
    ),
  );
}

convertDateToString({required String dateTime}) {
  var parsedDate = DateTime.parse(dateTime);
  DateFormat _dateTime = DateFormat.MMMEd();
  String formattedDate = _dateTime.format(parsedDate);
  String splitDate = formattedDate.split(',')[1];
  List<String> splitDateList = splitDate.split(' ');
  String month = splitDateList[1];
  int day = int.parse(splitDateList[2]) - 1;
  return '$month ${day.toString()}';
}

locationParams(Map<String, dynamic> query) {
  var location = MyHive.getLocation();
  query[Strings.latitude] = location.latitude;
  query[Strings.longitude] = location.longitude;
}

buildDynamicLinks(String category, String id) async {
  String url = Strings.dynamicLinkInitialUrl;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: url,
    link: Uri.parse('$url/$category/$id'),
    androidParameters: const AndroidParameters(
      packageName: 'com.thinknlocal.Thinknlocal',
      minimumVersion: 0,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.thinknlocal.Thinknlocal',
      minimumVersion: '0',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
        description: '',
        imageUrl: Uri.parse(Strings.dynamicLinkImageUrl),
        title: Strings.thinkLocal),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  String? desc = dynamicLink.shortUrl.toString();

  await Share.share(desc, subject: Strings.thinkLocal);
}

Future<String> getUserLocationAddress() async {
  if (MyHive.getLocation() != null) {
    final _address = await findAddress(MyHive.getLocation());
    return _address;
  }
  return '';
}

Future<Cities?> getLowestDistanceCity() async {
  Cities? _lowestDistanceCity;
  List<Cities> citiesList = [];
  var location = MyHive.getLocation();
  citiesList = await LocationRepository.fetchCities({Strings.latitude:  location.latitude, Strings.longitude: location.longitude}) ?? [];
  if(citiesList.isNotEmpty) {
    double _distance = citiesList[0].distance ?? 0.0;
    for (Cities city in citiesList) {
      if (city.distance! <= _distance) {
        _lowestDistanceCity = city;
      }
    }
  }
  return _lowestDistanceCity;
}

Future<String> findAddress(UserLocation type) async {
  var placeMarkers = await placemarkFromCoordinates(type.latitude, type.longitude);
  var completeAddress = '${placeMarkers.first.street},${placeMarkers.first.locality},${placeMarkers.first.country}';
  return completeAddress;
}

openPhoneDialPad(String phone, BuildContext context) async {
  try {
    String number = phone.toString();
    if (number == '') {
      showDialogWidget(title: 'No Phone Number Found', context: context);
    }
    else {
      await FlutterPhoneDirectCaller.callNumber(number);
    }
  }catch(e){
    log("Error thrown: ${e.toString()}");
  }
}

Future<dynamic> showDialogWidget({required BuildContext context, required String title}){
  return Get.defaultDialog(
      title: '',
      content: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Column(
          children: [
            TextView.title(title, color: Colors.black),
            SizedBox(height: 3.h,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: TextView.subTitle('Okay', color: AppColors.pureWhiteColor,)),
            ),
          ],
        ),
      )
  );
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

userNotLoggedIn(){
  Get.offAllNamed(Routes.loginScreen);
  showSnackBar(subTitle: Strings.notLoggedIn);
}

Future<bool> checkCameraPermissions() async {
  final status = await Permission.camera.request();
  if (status == PermissionStatus.granted) {
    log('Camera: Permission granted');
    final isMicEnabled = await checkMicroPhonePermission();
    if(isMicEnabled){
      return true;
    }
  } else if (status == PermissionStatus.denied) {
    log('Camera: Permission denied. Show a dialog and again ask for the permission');
  } else if (status == PermissionStatus.permanentlyDenied) {
    log('Camera: Take the user to the settings page.');
    await openAppSettings();
  }
  return false;
}

Future<bool> checkMicroPhonePermission() async {
  final status = await Permission.microphone.request();
  if (status == PermissionStatus.granted) {
    log('Microphone: Permission granted');
    return true;
  } else if (status == PermissionStatus.denied) {
    print('Microphone: Permission denied. Show a dialog and again ask for the permission');
  } else if (status == PermissionStatus.permanentlyDenied) {
    print('Microphone: Take the user to the settings page.');
    await openAppSettings();
  }
  return false;
}
