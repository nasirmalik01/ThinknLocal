import 'package:flutter/cupertino.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';

class AboutVisitComponents {
  Widget ratingContainer({required double? starRating, ignoreEdit, Function? onPress}) {
    return Container(
        width: getWidth(),
        padding: EdgeInsets.symmetric(horizontal: getHeight() * 0.02, vertical: getWidth() * 0.02),
        decoration: BoxDecoration(
          color: AppColors.boxGrey,
          borderRadius: BorderRadius.circular(getHeight() * 0.01),
        ),
        child: CommonWidgets.getRating(
          starRating: starRating,
          ignoreEdit: ignoreEdit,
          onPress: onPress,
        ),
    );
  }
}