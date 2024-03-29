import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/screens/bottom_tab/notifications/custom_network_image.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

class NotificationCard extends StatelessWidget {
  final String? image;
  final String? text;
  final String? subText;
  final String? date;
  final Function? onPressNotification;
  final bool isSentReceipts;
  final bool isNetworkImage;
  final bool isShowImage;
  final bool isSubTitleBold;
  final bool isShowReason;


  const NotificationCard(
      {Key? key, this.image,
        this.text,
        this.subText,
        this.date,
        this.onPressNotification,
        this.isSentReceipts = false,
        this.isNetworkImage = true,
        this.isShowImage = true,
        this.isSubTitleBold = false,
        this.isShowReason = true,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: sizes.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             isShowImage ? SizedBox(
                  width: sizes.width * 0.16,
                  height: sizes.width * 0.16,
                  child: isNetworkImage ? CustomNetworkImage(imageUrl: image ?? Assets.noImage, fit: BoxFit.fill,): Image(
                    image: AssetImage(image!),
                    fit: BoxFit.fill,
                  )
              ) : const SizedBox(),
              SizedBox(width: sizes.width * 0.03),
              SizedBox(
                width: isShowImage ? sizes.width * 0.70 : sizes.width * 0.88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 9,
                            child: TextView.titleWithDecoration(text, color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 1),
                        ),
                        TextView.headerWithBlurRadius(date, color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular, lines: 1),
                      ],
                    ),
                    SizedBox(height: sizes.height * 0.005),
                    TextView.headerWithBlurRadius(isShowReason ? subText : '', color: isSentReceipts ? AppColors.greenColor : AppColors.darkGrey, fontFamily: isSubTitleBold ? Assets.poppinsSemiBold : Assets.poppinsRegular, isShowFullText: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getHeight() * 0.01),
      ],
    );
  }
}
