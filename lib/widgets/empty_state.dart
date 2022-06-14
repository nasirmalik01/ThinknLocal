import 'package:flutter/material.dart';
import 'package:flutter_app/res/res.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

Widget emptyState(String title, {double? height}){
  return Container(
      color: Colors.transparent,
      height: height ?? getHeight()*0.88,
      child: Center(child: Padding(
        padding: EdgeInsets.only(bottom: 0.h),
        child: TextView.title(title, color: AppColors.blackColor, lines: 2),
      ),));
}