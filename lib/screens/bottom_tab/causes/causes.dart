import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class Causes extends StatefulWidget {
  const Causes({Key? key}) : super(key: key);

  @override
  _CausesState createState() => _CausesState();
}

class _CausesState extends State<Causes> {
  final CausesComponents _causesComponents = CausesComponents();
  TextEditingController? searchController;


  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: sizes!.height,
            width: sizes!.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  width: getWidth(),
                  padding: EdgeInsets.only(left: sizes!.width * 0.06, right: sizes!.width * 0.06, top: sizes!.height * 0.02),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView.getMediumText15("Businesses near", color: AppColors.darkGrey, fontFamily: Assets.poppinsRegular,),
                      TextView.bold22Text("Chino Hills, CA", color: AppColors.greenColor, fontFamily: Assets.poppinsSemiBold,
                          textDecoration: TextDecoration.underline)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight() * 0.02),
                      CommonWidgets.searchLocation(controller: searchController, hint: "Search for a cause"),
                      SizedBox(height: getHeight() * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _causesComponents.getIconsContainer(image: Assets.foodIcon, label: "Food & Drink"),
                          _causesComponents.getIconsContainer(image: Assets.thingsIcon, label: "Things to do"),
                          _causesComponents.getIconsContainer(image: Assets.bagIcon, label: "Retail"),
                          _causesComponents.getIconsContainer(image: Assets.servicesIcon, label: "Services"),
                        ],
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
