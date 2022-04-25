import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/res/res.dart';
import 'package:sizer/sizer.dart';

class AutoFieldTextField extends StatelessWidget {
  final List<String> list;
  final String hintText;
  final Function(String) onSelect;
  const AutoFieldTextField({required this.list, required this.hintText, required this.onSelect, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          return [];
        }

        // The logic to find out which ones should appear
        return list.where((business) =>
            business.toLowerCase().startsWith(value.text.toLowerCase()));
      },
      onSelected: onSelect,
      fieldViewBuilder: (
          BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted
          ) {
        return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 54, 63, 1),
              borderRadius: BorderRadius.circular(getHeight() * 0.01),
            ),
            child: Padding(
                padding: EdgeInsets.only(left: getWidth()*0.04, right: getWidth()*0.04, top: 0.7.h),
                child: TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: sizes.fontSize15,
                      fontFamily: Assets.poppinsMedium,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: AppColors.darkGrey.withOpacity(0.5),
                          fontSize: sizes.fontSize15,
                          fontFamily: Assets.poppinsMedium,
                        ),
                        hintText: hintText,
                    ))));
      },
    );
  }
}
