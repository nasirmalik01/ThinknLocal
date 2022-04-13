import 'package:flutter/material.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class BusinessesNearBy extends StatefulWidget {
  const BusinessesNearBy({Key? key}) : super(key: key);

  @override
  _BusinessesNearByState createState() => _BusinessesNearByState();
}

class _BusinessesNearByState extends State<BusinessesNearBy> {

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
                title: "Businesses near you",
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