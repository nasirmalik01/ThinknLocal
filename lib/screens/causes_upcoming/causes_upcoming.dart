import 'package:flutter/material.dart';
import 'package:flutter_app/screens/location_search/location_search_components.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/text_views.dart';


class CausesUpcoming extends StatefulWidget {
  const CausesUpcoming({Key? key}) : super(key: key);

  @override
  _CausesUpcomingState createState() => _CausesUpcomingState();
}

class _CausesUpcomingState extends State<CausesUpcoming> {
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
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonWidgets.getSimpleAppBar(
                title: "Upcoming causes near you",
                  onPressBackArrow: () {
                  Navigator.pop(context);
                }),
              SizedBox(height: getHeight() * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return CommonWidgets.getUpcomingCauses(
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
