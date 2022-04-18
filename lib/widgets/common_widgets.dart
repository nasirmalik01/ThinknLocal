import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../res/res.dart';


class CommonWidgets {
  static Widget getButton({
    double ? width,
    double ? height,
    String ? text,
    required Function ? onPress,
    Color ? btnColor,
    Color ? textColor,
    Color ? borderColor,
  }) {
    return GestureDetector(
      //key: const Key('Main button'),
      onTap: (){
        onPress!.call();
      },
      child: Container(
        height: height?? getHeight() * 0.075,
        width:  width?? getWidth(),
        decoration: BoxDecoration(
          color: btnColor??AppColors.greenColor,
          border: Border.all(color: borderColor??Colors.transparent),
          borderRadius: BorderRadius.circular(getWidth()*.02,),
        ),
        child: Center(
            child: TextView.title(
              text??"SUBMIT",
              color: textColor?? AppColors.pureWhiteColor,
              fontFamily: Assets.poppinsMedium
            )
        ),
      ),
    );
  }
  
  static Widget getSmallButton({Color? borderColor, Color? fillColor}) {
    return Container(
      height: getHeight() * 0.03,
      width: getWidth() * 0.03,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fillColor?? AppColors.pureWhiteColor,
        border: Border.all(color: borderColor ?? AppColors.greenColor)
      ),
    );
  }

  static Widget searchLocationTextField({
    TextEditingController? controller,
    String?  hint,
    required Function onPressSearch
  }) {
    return Container(
      padding: EdgeInsets.only(right: getWidth() * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.pureWhiteColor,
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          onPressSearch.call();
        },
        style: TextStyle(
            fontFamily: Assets.poppinsRegular,
            fontSize: sizes.fontSize15,
            color: AppColors.lightBlack
        ),
        decoration: InputDecoration(
          hintText: hint ?? "Search",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintStyle: TextStyle(
              fontFamily: Assets.poppinsRegular,
              fontSize: sizes.fontSize15,
              color: AppColors.veryLightGrey
          ),
          prefixIcon: GestureDetector(
            onTap: () => onPressSearch(),
            child: const Icon(
              Icons.search_outlined,
              color: AppColors.darkGrey,
            ),
          ),
        ),
      ),
    );
  }

  static Widget getRating({double? starRating, bool? ignoreEdit, Function? onPress}){
    return RatingBar(
      initialRating: starRating ?? 4,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: getWidth() * 0.1,
      itemPadding: EdgeInsets.symmetric(horizontal: sizes.widthRatio * 2),
      ratingWidget: RatingWidget(
          full: const Icon(Icons.star, color: Colors.amber),
          half: const Icon(Icons.star_half, color: Colors.amber),
          empty: const Icon(Icons.star_outline, color: AppColors.darkGrey,)
      ),
      ignoreGestures: ignoreEdit ?? true,
      onRatingUpdate: (rating) {
        onPress!.call(rating);
      },
    );
  }

  static Widget dropDownField({
    @required String ?selectedCategory,
    @required Function ?updateSelectedCategory,
    @required List<String> ?categories,
    @required String ?hint,
  }){
    return Container(
      width: getWidth(),
      padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.02, vertical: getWidth() * 0.02),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(getHeight() * 0.01),
      ),
      child: ButtonTheme(
        child: DropdownButton <String>(
          dropdownColor: AppColors.blackColor,
            hint: Text(hint ?? '',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: sizes.fontSize15,
                fontFamily:Assets.poppinsMedium,
              ),
            ),
            value: selectedCategory,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down,color: AppColors.darkGrey,size: getHeight()*.035,),
            underline:const SizedBox() ,
            onChanged: (String? newValue) {
              if(updateSelectedCategory != null){
                updateSelectedCategory(newValue);
              }
            },
            items: categories?.map<DropdownMenuItem<String>> ((String value) {
              return DropdownMenuItem<String> (
                value: value,
                child: Text(value,style: TextStyle(
                  color: AppColors.darkGrey,
                  fontFamily: Assets.poppinsMedium,
                  fontSize: sizes.fontSize15,
                ),
                ),
              );
            }).toList()
        ),
      ),
    );
  }

  static Widget getAppBarWithSearch({
    String? title,
    String? hint,
    TextEditingController? textEditingController,
    required Function onPressBackArrow,

  }){
    return Container(
      width: sizes.width,
      color: AppColors.greenColor,
      padding: EdgeInsets.only(
          left: sizes.pagePadding,
          right: sizes.pagePadding,
          top: getHeight() * 0.07,
          bottom: getHeight() * 0.025
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => onPressBackArrow(),
                child: Container(
                  padding: EdgeInsets.only(top: getHeight() * 0.01, left: getWidth() * 0.02, bottom: getHeight() * 0.01),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.pureWhiteColor
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.greenColor,
                    size: getHeight() * 0.03,
                  ),
                ),
              ),
              SizedBox(width: getWidth() * 0.05),
              SizedBox(
                  width: getWidth() * 0.75,
                  child: TextView.header(title??"", color: AppColors.pureWhiteColor, fontSize: sizes.fontSize22)
              ),

            ],
          ),
          SizedBox(height: getHeight()*0.02),
          searchAppBarField(controller: textEditingController, hint: hint)
        ],
      ),
    );
  }

  static Widget searchAppBarField({TextEditingController? controller, String? hint}) {
    return Container(
      padding: EdgeInsets.only(right: getWidth() * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(getHeight() * 0.015)),
        color: AppColors.pureWhiteColor,
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        style: TextStyle(
            fontFamily: Assets.poppinsRegular,
            fontSize: sizes.fontSize15,
            color: AppColors.blackColor
        ),
        decoration: InputDecoration(
          hintText: hint ?? "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintStyle: TextStyle(
              fontFamily: Assets.poppinsRegular,
              fontSize: sizes.fontSize15,
              color: AppColors.darkGrey
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
  static Widget getSimpleAppBar({
    String? title,
    required Function onPressBackArrow,
  }){
    return Container(
      width: sizes.width,
      color: AppColors.greenColor,
      padding: EdgeInsets.only(
          left: sizes.pagePadding,
          right: sizes.pagePadding,
          top: getHeight() * 0.05,
          bottom: getHeight() * 0.03
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => onPressBackArrow(),
                child: Container(
                  padding: EdgeInsets.only(top: getHeight() * 0.01, left: getWidth() * 0.02, bottom: getHeight() * 0.01),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.pureWhiteColor
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.greenColor,
                    size: getHeight() * 0.03,
                  ),
                ),
              ),
              SizedBox(width: getWidth() * 0.05),
              SizedBox(
                  width: getWidth() * 0.75,
                  child: TextView.caption(title??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1, fontSize: sizes.fontSize16)
              ),
            ],
          ),
        ],
      ),
    );
  }

  static getCategoryWithText({
    String? image,
    String? title
  }) {
    return Row(
      children: [
        Image.asset(image!),
        SizedBox(width: getWidth() * 0.05),
        TextView.headerWithBlurRadius(title ?? "", color: AppColors.darkGrey, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize14)

      ],
    );
  }

  static Widget getTextWithSeeAll({required String leadingText, required String trailingText, required Function onPressSeeAllButton}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView.titleWithDecoration(leadingText, color: AppColors.blackColor, fontFamily: Assets.poppinsMedium, fontSize: sizes.fontSize16),
        GestureDetector(
            onTap: () => onPressSeeAllButton(),
            child: TextView.headerWithBlurRadius(trailingText, color: AppColors.greenColor,
                fontFamily: Assets.poppinsMedium, textDecoration: TextDecoration.underline, fontSize: sizes.fontSize15)),
      ],
    );
  }

}


