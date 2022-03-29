import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../res/assets.dart';
import '../res/colors.dart';
import '../res/res.dart';


class CommonWidgets {
  static  Widget textField({
    TextEditingController ? textEditingController,
    bool ? obscureText,
    String?  hint,
    TextInputType? textInputType,
    double ? width,
    String ? icon,
    Color? borderColor,
    Color? bgColor,
    Color? textColor,
    Color? hintTextColor,
    Color? cursorColor
  }){
    return   Container(
      height: getHeight() * 0.07,
      width:  width??sizes.width,
      decoration: BoxDecoration(
          color: bgColor?? AppColors.lightGrey,
          border: Border.all(color: borderColor?? AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(getHeight()*.01))
      ),
      child: Center(
        child: TextField(
          controller: textEditingController,
          obscureText:obscureText?? false,
          cursorHeight: getHeight()*.03,
          keyboardType: textInputType??TextInputType.text,
          cursorColor: cursorColor?? AppColors.lightBlack,
          style: TextStyle(
            color: textColor ?? AppColors.lightBlack,
            fontSize: sizes.fontSize15,
            fontFamily:Assets.poppinsMedium,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: getWidth()*.02),
              hintText: hint??"",
              alignLabelWithHint: false,
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.darkGrey,
                fontSize: sizes.fontSize15,
                fontFamily:Assets.poppinsMedium,
              )
          ),
        ),
      ),
    );
  }

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
            child: TextView.getMediumText18(
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

  static Widget searchLocation({
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

  static Widget getUpcomingCauses({
    String? image,
    String? headerText,
    String? description,
    String? totalAmount,
    String? date,
    required Function onViewCourse
  }){
    bool isImageUrl = Uri.tryParse(image!)?.hasAbsolutePath ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: ()=> onViewCourse.call(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getHeight()*0.085,
                width: getWidth()*0.2,
                decoration: BoxDecoration(
                  //color: AppColors.lightGrey,
                    image: DecorationImage(
                        image: isImageUrl ? NetworkImage(image): const AssetImage(Assets.dummyLogo) as ImageProvider,
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(getHeight() * 0.01)
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: getWidth()*0.02),
                width: getWidth()*0.6,
                // color: AppColors.redDarkColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView.regular11Text(headerText??"", color: AppColors.blackColor, fontFamily: Assets.poppinsRegular),
                    SizedBox(height: getHeight()*0.003),
                    TextView.getMediumText15(description??"", color: AppColors.lightBlack, fontFamily: Assets.poppinsMedium, lines: 2, height: getHeight() * 0.0016),
                    SizedBox(height: getHeight()*0.006),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Raising ",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: sizes.fontSize11,
                                fontFamily: Assets.poppinsRegular,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '\$$totalAmount',
                                  style: TextStyle(
                                    color: AppColors.greenColor,
                                    fontSize: sizes.fontSize11,
                                    fontFamily: Assets.poppinsMedium,
                                  ),
                                ),
                                TextSpan(
                                  text: ';',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: sizes.fontSize11,
                                    fontFamily: Assets.poppinsMedium,
                                  ),
                                ),
                                TextSpan(
                                  text: ' starting ',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: sizes.fontSize11,
                                    fontFamily: Assets.poppinsRegular,
                                  ),
                                ),
                                TextSpan(
                                  text: date,
                                  style: TextStyle(
                                    color: AppColors.greenColor,
                                    fontSize: sizes.fontSize11,
                                    fontFamily: Assets.poppinsMedium,
                                  ),
                                )
                              ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  static Widget getRating({double? starRating, bool? ignoreEdit, Function? onPress}){
    return RatingBar(
      initialRating: starRating ?? 4,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: getWidth() * 0.08,
      itemPadding: EdgeInsets.symmetric(horizontal: sizes.widthRatio * 0),
      ratingWidget: RatingWidget(
          full: const Icon(Icons.star, color: Colors.amber),
          half: const Icon(Icons.star_half, color: Colors.amber),
          empty: const Icon(Icons.star_outline, color: AppColors.darkGrey,)
      ),
      ignoreGestures: ignoreEdit ?? true,
      onRatingUpdate: (rating) {
        onPress!.call(rating);
        print(rating);
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
      //margin: EdgeInsets.only(right: sizes!.mediumPadding ?? 0),
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
            underline:SizedBox() ,
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

  static  Widget textFieldForPassword({
    TextEditingController ? textEditingController,
    bool ? obscureText,
    String?  hint,
    TextInputType? textInputType,
    double ? width,
    String ? icon,
    Color? borderColor,
    Color? bgColor,
    Color? textColor,
    Color? hintTextColor,
    Color? cursorColor,
    required bool hidePassword,
    required Function? clickIcon,
  }){
    return   Container(
      height: getHeight() * 0.07,
      width:  width??sizes.width,
      decoration: BoxDecoration(
          color: bgColor?? AppColors.lightGrey,
          border: Border.all(color: borderColor?? AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(getHeight()*.01))
      ),
      child: Center(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: textEditingController,
          obscureText: hidePassword,
          cursorHeight: getHeight()*.03,
          keyboardType: textInputType??TextInputType.text,
          cursorColor: cursorColor?? AppColors.lightBlack,
          style: TextStyle(
            color: textColor ?? AppColors.lightBlack,
            fontSize: sizes.fontSize15,
            fontFamily:Assets.poppinsMedium,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: getWidth()*.02),
              hintText: hint??"",
              alignLabelWithHint: false,
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.darkGrey,
                fontSize: sizes.fontSize15,
                fontFamily:Assets.poppinsMedium,
              ),
            suffixIcon: IconButton(
              icon: Icon(
                hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.darkGrey,
              ),
              onPressed: () {
                if (clickIcon != null) {
                  clickIcon.call();
                }
              },
            ),
          ),
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
                  child: TextView.bold22Text(title??"", color: AppColors.pureWhiteColor)
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
                  child: TextView.regular16Text(title??"", color: AppColors.pureWhiteColor, fontFamily: Assets.poppinsMedium, lines: 1)
              ),

            ],
          ),
        ],
      ),
    );
  }

}


