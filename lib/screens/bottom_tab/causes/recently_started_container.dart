import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';

class RecentlyStartedContainer extends StatelessWidget {
  final String? image;
  final String? name;
  final List<Color> colors;
  final Function onPressFullContainer;
  final int index;

  const RecentlyStartedContainer({Key? key, this.image, this.name, required this.colors, required this.onPressFullContainer, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return Container(
      width: getWidth() * 0.40,
      margin: EdgeInsets.only(left: index == 0 ? getWidth()*0.06 : getWidth()*0.04),
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(getHeight() * 0.015),
          image: DecorationImage(
              image: isImageUrl ? NetworkImage(image!): AssetImage(image!) as ImageProvider,
              fit: BoxFit.cover)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.015)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: getHeight() * 0.08, left: getWidth() * 0.03, right: getWidth() * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name??"",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  height: getHeight() * 0.0015,
                  fontSize: sizes.fontSize17,
                  fontFamily: Assets.poppinsMedium,
                  color: AppColors.pureWhiteColor,
                  shadows: const [
                    Shadow(
                      blurRadius: 5,
                      //offset: Offset(0.0, 1)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
