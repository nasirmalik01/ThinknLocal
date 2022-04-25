import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/businesses.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/businesses_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizer/sizer.dart';

void main(){

  testWidgets('Business home screen testing', (WidgetTester tester) async{

    await tester.pumpWidget(
      Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(home: BusinessesScreen(),);
      },),);

    // To check length of the list
    expect(businessTabViewDataList.length, 2);
    expect(recentlyStartedBusinessList.length, 4);
    expect(nearbyBusinessesList.length, 6);

    //To check different required sections exists or not
    expect(find.text('Recently Added'), findsOneWidget);
    expect(find.text('Featured'), findsOneWidget);
    expect(find.text('Nearby'), findsOneWidget);

    // To check navigation occur or not
    await tester.tap(find.text('See All'), warnIfMissed: false);
    await tester.pumpAndSettle();
  });

}
