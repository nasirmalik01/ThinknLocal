import 'package:flutter/material.dart';
import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/screens/bottom_tab/bottom_tab_new.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  setUpAll(() async {
    dependencyInjectionSetUp();
  });

  group("Cause Screen UI Testing", () {
    testWidgets("Cause Screen Widgets test", (WidgetTester tester) async {
      await tester.pumpWidget(Sizer(
        builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
          return GetMaterialApp(
              builder: (BuildContext context, child){
                initializeResources(context: context);
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.07);
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!);
              },
              home: const BottomTabNew(pageIndex: 0,));
        },
      ));

      // await tester.pumpAndSettle(const Duration(seconds: 4));
      // expect(find.text(Strings.recentlyStarted), findsOneWidget);
      // expect(find.text(Strings.upcomingCauses),  findsOneWidget);
    });
  });
}

