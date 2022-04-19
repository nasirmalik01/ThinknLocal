import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_category_screen.dart';
import 'package:flutter_app/screens/cause_search/cause_search.dart';
import 'package:flutter_app/screens/location_search/location_search.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../res/res.dart';


class CausesScreen extends StatelessWidget{
  final TextEditingController? searchController = TextEditingController();

  CausesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CausesController _causesController = Get.put(CausesController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Container(
              height: getHeight() * 0.12,
              width: getWidth(),
              padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, top: sizes.height * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: PreferenceUtils.getGradient()
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView.titleWithDecoration("Showing causes near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                  Row(
                    children: [
                      TextView.header("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, textDecoration: TextDecoration.underline, fontSize: sizes.fontSize25),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 0.5.h),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const LocationSearch()));
                            },
                            // child: Icon(Icons.location_on_outlined, size: getHeight() * 0.03, color: AppColors.greenColor,)),
                            child: Image(
                              height: getHeight() * 0.03,
                              image: const AssetImage(Assets.vectorIcon),),),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: CommonWidgets.searchLocationTextField(
                      controller: searchController,
                      hint: "Search for a cause",
                      onPressSearch: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CauseSearch()));
                      }
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: sizes.width * 0.06, right: sizes.width * 0.06, bottom: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customTabBar(title: "Featured", isSelected: _causesController.isFeatured.value,  onTap: (){ _causesController.setFeaturedTab(); }),
                      customTabBar(title: "Trending", isSelected: _causesController.isTrending.value, onTap: (){ _causesController.setTrendingTab(); }),
                      customTabBar(title: "Favorites", isSelected: _causesController.isFavorites.value, onTap: (){ _causesController.setFavoritesTab(); }),
                      customTabBar(title: "Past", isSelected: _causesController.isPast.value, onTap: (){ _causesController.setPostTab(); }),
                    ],
                  ),
                ),
                const CausesCategoryScreen(),
              ],
            ),

          ],
        ),
      ),),
    );
  }
}
