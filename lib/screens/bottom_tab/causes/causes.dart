import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_app/local/dummy_data/causes.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_controller.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_tabs_screen.dart';
import 'package:flutter_app/screens/cause_search/cause_search.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail.dart';
import 'package:flutter_app/screens/causes_upcoming/causes_upcoming.dart';
import 'package:flutter_app/screens/location_search/location_search.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/status_bar.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Causes extends StatelessWidget {

  final CausesComponents _causesComponents = CausesComponents();
  final TextEditingController? searchController = TextEditingController();

  Causes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final CausesController _causesController = Get.put(CausesController());
    setStatusBarColor(color: PreferenceUtils.getGradient().first);
    // Height: 8.053333333333335
    // Width: 3.84

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
                  TextView.getMediumText15("Showing causes near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                  Row(
                    children: [
                      TextView.bold22Text("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsMedium,
                          textDecoration: TextDecoration.underline),
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
                SizedBox(height: getHeight() * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: CommonWidgets.searchLocationTextField(
                      controller: searchController,
                      hint: "Search for a cause",
                      onPressSearch: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const CauseSearch()));
                      }
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _causesComponents.typesFeaturedText(title: "Featured", isSelected: _causesController.isFeatured.value,  onTap: (){ _causesController.setFeaturedTab(); }),
                      _causesComponents.typesFeaturedText(title: "Trending", isSelected: _causesController.isTrending.value, onTap: (){ _causesController.setTrendingTab(); }),
                      _causesComponents.typesFeaturedText(title: "Favorites", isSelected: _causesController.isFavorites.value, onTap: (){ _causesController.setFavoritesTab(); }),
                      _causesComponents.typesFeaturedText(title: "Past", isSelected: _causesController.isPost.value, onTap: (){ _causesController.setPostTab(); }),
                    ],
                  ),
                ),
                CausesTabScreen(),
              ],
            ),

          ],
        ),
      ),)

    );
  }
}
