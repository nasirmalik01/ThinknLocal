import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';

class DropDownField extends StatelessWidget {
  final String ?selectedCategory;
  final Function ?updateSelectedCategory;
  final List<String> ?categories;
  final String ?hint;


  const DropDownField(
      {Key? key, this.selectedCategory, this.updateSelectedCategory, this.categories, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(),
      padding: EdgeInsets.symmetric(
          horizontal: getHeight() * 0.02, vertical: getWidth() * 0.02),
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
                fontFamily: Assets.poppinsMedium,
              ),
            ),
            value: selectedCategory,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.darkGrey,
              size: getHeight() * .035,),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (updateSelectedCategory != null) {
                updateSelectedCategory!(newValue);
              }
            },
            items: categories?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(
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
}
