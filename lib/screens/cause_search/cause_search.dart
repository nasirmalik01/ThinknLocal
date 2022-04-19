import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';


class CauseSearch extends StatelessWidget {
  final TextEditingController? searchController = TextEditingController();
  final bool isBusiness;

  CauseSearch({this.isBusiness = false, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CommonWidgets.getAppBarWithSearch(
                  title: "",
                  hint: 'Search for a ${isBusiness ? 'business' : 'cause'}',
                  textEditingController: searchController,
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TextView.title("Showing results for",
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.headerWithBlurRadius("- chino hills high school", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, lines: 1, fontSize: sizes.fontSize12),
                    SizedBox(height: getHeight() * 0.02),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return UpcomingCauses(
                            image:  "",
                            headerText: "Chino Hills High Softball Team",
                            description:  "Spring Training Equipment Fundraiser",
                            onViewCourse: (){
                            },
                            totalAmount: "500",
                            date: "Mar 25"
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                            height: getHeight() * 0.04,
                            thickness: getHeight() * 0.002,
                            color: AppColors.borderColor);
                      },
                    ),
                    SizedBox(height: getHeight() * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
