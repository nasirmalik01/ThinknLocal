import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseDynamicApi {
  static Future<void> initDynamicLinks() async {
    await getPendingDynamicLink();
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri? deeplink = dynamicLinkData.link;
      if (deeplink != null) {
        handleDynamicLink(deeplink);
      }
    }).onError((error) {});
    final pendingDynamicLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (pendingDynamicLink != null) {
      handleDynamicLink(pendingDynamicLink.link);
    }
  }

  static buildDynamicLinks(String category, String id,
      {String? organizationId}) async {
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
      Get.toNamed(Routes.causesDetailScreen, arguments: {
        Strings.causeId: int.parse(_splitDynamicLink[2]),
        Strings.organizationId: int.parse(_splitDynamicLink[3])
      });
    } else {
      Get.toNamed(Routes.businessDetailScreen,
          arguments: int.parse(_splitDynamicLink[2]));
    }
  }

  static Future<void> getPendingDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink?.link != null) {
      handleDynamicLink(initialLink!.link);
    }
  }
}
