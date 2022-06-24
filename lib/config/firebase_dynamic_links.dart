
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_app/config/navigation_service.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/screens/businesses_detail/businesses_detail.dart';
import 'package:flutter_app/screens/businesses_nearby/businesses_nearby.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseDynamicApi {


  static Future<void> initDynamicLinks() async {
   // await getPendingDynamicLink();
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri? deeplink = dynamicLinkData.link;
      if (deeplink != null) {
        handleDynamicLink(deeplink);
      }
    }).onError((error) {});
    final pendingDynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (pendingDynamicLink != null) {
      handleDynamicLink(pendingDynamicLink.link);
    }
  }

  static buildDynamicLinks(String category, String id, {String? organizationId}) async {
    String url = Strings.dynamicLinkInitialUrl;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$category/$id/${organizationId ?? '1'}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.thinknlocal.Thinknlocal',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.thinknlocal.Thinknlocal',
        minimumVersion: '0',
        appStoreId: '1524846479',
      ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   description: '',
      //   imageUrl: Uri.parse(Strings.dynamicLinkImageUrl),
      //   title: Strings.thinknLocal,
      // ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    String? desc = dynamicLink.shortUrl.toString();

    await Share.share(desc, subject: Strings.thinknLocal);
  }

  static void handleDynamicLink(Uri url) {
    List<String> _splitDynamicLink = [];
    _splitDynamicLink.addAll(url.path.split('/'));
    String _category = _splitDynamicLink[1];
    if (_category == Strings.causes) {
      pushNewScreen(
        NavigationService.navigatorKey.currentContext!,
        screen: CausesDetail(
            causeId: int.parse(_splitDynamicLink[2]),
            organizationId: int.parse(_splitDynamicLink[3])
        ),
        withNavBar: true,
      );
    } else {
      pushNewScreen(
        NavigationService.navigatorKey.currentContext!,
        screen: BusinessesDetailScreen(
            businessId: int.parse(_splitDynamicLink[2])),
        withNavBar: true,
      );
    }
  }

  static Future<void> getPendingDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink?.link != null) {
      log("Newly Generated PendingLink : $initialLink");
      handleDynamicLink(initialLink!.link);
    }
  }
}
