import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class CausesUpcoming extends StatefulWidget {
  const CausesUpcoming({Key? key}) : super(key: key);

  @override
  _CausesUpcomingState createState() => _CausesUpcomingState();
}

class _CausesUpcomingState extends State<CausesUpcoming> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizes.height,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: ListView(
                  children: [
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
