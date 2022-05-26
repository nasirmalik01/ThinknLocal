import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/screens/bottom_tab/notifications/custom_network_image.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FullPhoto extends StatelessWidget {
  final String imageUrl;
  const FullPhoto({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: InteractiveViewer(
                scaleEnabled: true,
                constrained: true,
                alignPanAxis: false,
                panEnabled: false,
                minScale: 0.5,
                maxScale: 2,
                child: CustomNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            left: 2.h,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close,
                color: AppColors.pureWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}