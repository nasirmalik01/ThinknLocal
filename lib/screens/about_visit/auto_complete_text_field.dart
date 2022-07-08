import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';
import 'package:thinknlocal_app/screens/about_visit/about_visit_controller.dart';

class AutoFieldTextField extends StatelessWidget {
  final String hintText;
  final Function(SuggestionModel) onSelect;
  final bool isBusiness;
  final bool isEnabled;
  final Function(TextEditingController textEditingController)?
      onControllerAssign;
  AutoFieldTextField(
      {required this.hintText,
      this.isBusiness = false,
      this.isEnabled = true,
      required this.onSelect,
      Key? key,
      this.onControllerAssign})
      : super(key: key);
  final AboutVisitController _aboutVisitController =
      Get.put(AboutVisitController());

  ///Suggestion ListView
  Widget _suggestionListView(
      BuildContext context,
      AutocompleteOnSelected<SuggestionModel> onSelected,
      Iterable<SuggestionModel> options) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(48, 54, 63, 1),
        child: SizedBox(
          width: getWidth() * 0.88,
          height: getHeight() * 0.2,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final SuggestionModel option = options.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    title: Text(
                      option.title,
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: sizes.fontSize14,
                        fontFamily: Assets.poppinsMedium,
                      ),
                    ),
                    subtitle: Text(
                      option.subTitle ?? '',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: sizes.fontSize10,
                        fontFamily: Assets.poppinsMedium,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.black54,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Selected View
  Widget _selectedView(
      BuildContext context,
      TextEditingController fieldTextEditingController,
      FocusNode fieldFocusNode,
      VoidCallback onFieldSubmitted) {
    return Container(
      padding: EdgeInsets.all(getWidth() * 0.013),
      height: getHeight() * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(48, 54, 63, 1),
        borderRadius: BorderRadius.circular(getHeight() * 0.01),
      ),
      child: TextFormField(
        enabled: isEnabled ? true : false,
        controller: fieldTextEditingController,
        focusNode: fieldFocusNode,
        textAlign: TextAlign.start,
        maxLength: null,
        maxLines: isBusiness ? null : 1,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(
          color: AppColors.darkGrey,
          fontSize: sizes.fontSize12,
          fontFamily: Assets.poppinsMedium,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: getWidth() * 0.04),
          hintStyle: TextStyle(
            color: AppColors.darkGrey.withOpacity(0.5),
            fontSize: sizes.fontSize15,
            fontFamily: Assets.poppinsMedium,
          ),
          hintText: hintText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<SuggestionModel>(
      optionsBuilder: (TextEditingValue value) async {
        if (value.text == '') {
          Iterable<SuggestionModel> list =
              await _aboutVisitController.setOptionsBuilder(
                  isEmptyTextFieldValue: true, isBusiness: isBusiness);
          return list;
        }
        Iterable<SuggestionModel> list = await _aboutVisitController
            .setOptionsBuilder(value: value, isBusiness: isBusiness);
        return list;
      },
      displayStringForOption: (SuggestionModel option) => option.title,
      onSelected: onSelect,
      optionsViewBuilder: _suggestionListView,
      fieldViewBuilder: _selectedView,
    );
  }
}
