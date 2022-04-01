import 'package:flutter/material.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';


class CauseSearch extends StatefulWidget {
  const CauseSearch({Key? key}) : super(key: key);

  @override
  _CauseSearchState createState() => _CauseSearchState();
}

class _CauseSearchState extends State<CauseSearch> {
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            CommonWidgets.getAppBarWithSearch(
                title: "",
                hint: "Search for a cause",
                textEditingController: searchController,
                onPressBackArrow: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  children: [
                    TextView.getMediumText18("Showing results for",
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.01),
                    TextView.bold15Text("- chino hills high school", color: AppColors.greenColor, fontFamily: Assets.poppinsRegular, lines: 1),
                    SizedBox(height: getHeight() * 0.02),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return CommonWidgets.getUpcomingCausesList(
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
            ),
          ],
        ),
      ),
    );
  }
}
