import 'package:flutter/material.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';


class ThingsToDo extends StatefulWidget {
  const ThingsToDo({Key? key}) : super(key: key);

  @override
  _ThingsToDoState createState() => _ThingsToDoState();
}

class _ThingsToDoState extends State<ThingsToDo> {

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
                title: "",
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
                    SizedBox(height: getHeight() * 0.02),
                    CommonWidgets.getCategoryWithText(
                        image: Assets.thingsIcon,
                        title: "Things to do"
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return CommonWidgets.businessesDetailListView(
                            image:  Assets.dummyNearBy,
                            headerText: "Andy's Xpress Wash ",
                            onViewCourse: (){
                            },
                            address: "Chino, CA 91710",
                            streetAddress: "15705 Euclid Ave",
                            phoneNumber: "908-900-1791"
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
