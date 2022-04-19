import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/causes/upcoming_causes.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class CausesUpcoming extends StatelessWidget {
  const CausesUpcoming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: sizes.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CommonWidgets.getSimpleAppBar(
                title: "Upcoming causes near you",
                  onPressBackArrow: () {
                  Navigator.pop(context);
                }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: sizes.height*0.02),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: sizes.height*0.001),
                          child: UpcomingCauses(
                              image:  "",
                              headerText: "Chino Hills High Softball Team",
                              description:  "Spring Training Equipment Fundraiser",
                              onViewCourse: (){
                              },
                              totalAmount: "500",
                              date: "Mar 25"
                          ),
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
