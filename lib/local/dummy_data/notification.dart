import 'package:flutter_app/constants/assets.dart';

import '../../model/dummy/notification.dart';

List<Notification> notificationList = [
  Notification(leadingIcon: Assets.notificationIcon1, title: 'Auraganic', subTitle: 'Running a 30% contribution...', time: '2h'),
  Notification(leadingIcon: Assets.notificationIcon2, title: 'Chaparral Elementary', subTitle: 'They did it, cause funded!', time: '15h'),
  Notification(leadingIcon: Assets.notificationIcon3, title: 'Receipt Processed!', subTitle: '\$39.23 sent to the cause', time: '1d'),
  Notification(leadingIcon: Assets.notificationIcon4, title: 'Receipt Sent', subTitle: 'To Causes', time: '2d'),
  Notification(leadingIcon: Assets.notificationIcon5, title: 'Welcome!', subTitle: 'Not sure where to start?', time: '8d'),
];

List<Notification> pendingReceiptsList = [
Notification(leadingIcon: Assets.pendingReceiptIcon1, title: 'Walmart', subTitle: '\$24.91 will be sent to cause', time: '2h'),
Notification(leadingIcon: Assets.pendingReceiptIcon2, title: 'Chik Fil A', subTitle: '\$24.91 will be sent to cause', time: '15h'),
Notification(leadingIcon: Assets.pendingReceiptIcon3, title: 'Steak House', subTitle: '\$24.91 will be sent to cause', time: '1d'),
Notification(leadingIcon: Assets.pendingReceiptIcon4, title: 'AtoZ Car Wash', subTitle: '\$24.91 will be sent to cause', time: '2d'),
Notification(leadingIcon: Assets.pendingReceiptIcon1, title: 'Baskin Robbins', subTitle: '\$24.91 will be sent to cause', time: '8d'),
];

List<Notification> sentReceiptsList = [
Notification(leadingIcon: Assets.sentReceiptIcon1, title: 'Home Goods', subTitle: '\$24.91 will be sent to cause', time: '2h'),
Notification(leadingIcon: Assets.sentReceiptIcon2, title: 'Best Buy', subTitle: '\$24.91 will be sent to cause', time: '15h'),
Notification(leadingIcon: Assets.sentReceiptIcon3, title: 'Walmart', subTitle: '\$24.91 will be sent to cause', time: '1d'),
Notification(leadingIcon: Assets.sentReceiptIcon4, title: 'Publix', subTitle: '\$24.91 will be sent to cause', time: '2d'),
Notification(leadingIcon: Assets.sentReceiptIcon5, title: 'Target', subTitle: '\$24.91 will be sent to cause', time: '8d'),
];