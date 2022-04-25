import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/causes.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizer/sizer.dart';

void main(){

  /// Add initializeResources(context: context); in build method for testing.

  testWidgets('Cause home screen testing', (WidgetTester tester) async{

    await tester.pumpWidget(
      Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(home: CausesScreen(),);
    },),);

    // To check length of the list
    expect(featuredCausesList.length, 4);
    expect(recentlyStartedCauseList.length, 4);

    //To check different required sections exists or not
    expect(find.text('Recently Started'), findsOneWidget);
    expect(find.text('Featured'), findsOneWidget);
    expect(find.text('Upcoming Causes'), findsOneWidget);

    // To check navigation occur or not
    await tester.tap(find.text('See All'), warnIfMissed: false);
    await tester.pumpAndSettle();
  });

}
