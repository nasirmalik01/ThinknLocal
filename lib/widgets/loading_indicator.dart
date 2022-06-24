import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget bouncingLoadingIndicator({Color? color}){
    return Center(
      child: SpinKitThreeBounce(
        size: 35,
        color: color ?? AppColors.greenColor,
      ),
    );
}