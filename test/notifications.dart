import 'package:flutter/material.dart';
import 'package:flutter_app/local/dummy_data/notification.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizer/sizer.dart';

void main(){

  testWidgets('Notification screen testing', (WidgetTester tester) async{

    await tester.pumpWidget(
      Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return const MaterialApp(home: NotificationScreen(),);
      },),);

    // To check length of the list
    expect(notificationList.length, 5);
    expect(pendingReceiptsList.length, 5);
    expect(sentReceiptsList.length, 5);

    // To check all the 3 tabs in notification screen
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Pending Receipts'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);


    // To check navigation occur or not
    await tester.tap(find.text('Edit Settings'), warnIfMissed: false);
    await tester.pumpAndSettle();
  });

}
