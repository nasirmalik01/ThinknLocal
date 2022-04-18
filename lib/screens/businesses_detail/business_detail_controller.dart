import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import 'package:get/get.dart';

class BusinessDetailController extends GetxController{
  final RxBool isLoading = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    setStatusBarColor(color: Colors.transparent);
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  scrollListener() {
    if (scrollController.position.isScrollingNotifier.value) {
      setStatusBarColor(color: Colors.black54, isTextColorLight: true);
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange) {
      setStatusBarColor(color: Colors.transparent);
    }
  }
}