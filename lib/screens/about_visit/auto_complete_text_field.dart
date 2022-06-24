import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/screens/about_visit/about_visit_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AutoFieldTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onSelect;
  final bool isBusiness;
  final bool isEnabled;
  AutoFieldTextField({required this.hintText, this.isBusiness = false, this.isEnabled = true, required this.onSelect, Key? key}) : super(key: key);
  final AboutVisitController _aboutVisitController = Get.put(AboutVisitController());


  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        if(value.text == ''){
          Iterable<String> list = _aboutVisitController.setOptionsBuilder(isEmptyTextFieldValue: true, isBusiness: isBusiness);
          return list;
        }
        Iterable<String> list = _aboutVisitController.setOptionsBuilder(value: value, isBusiness: isBusiness);
        return list;
      },
      onSelected: onSelect,
      fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 54, 63, 1),
              borderRadius: BorderRadius.circular(getHeight() * 0.01),
            ),
            child: Padding(
                padding: EdgeInsets.only(left: getWidth()*0.04, right: getWidth()*0.04, top: 0.7.h),
                child: TextFormField(
                    enabled:  isEnabled ? true : false,
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


