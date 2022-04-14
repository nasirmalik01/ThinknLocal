import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bottom_tab/businesses/business_nearby.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../../res/res.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/text_views.dart';


class BusinessCategory extends StatefulWidget {
  const BusinessCategory({
    Key? key,
    required this.businessType,
  }) : super(key: key);
  final String businessType;

  @override
  _BusinessCategoryState createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {

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
                    TextView.title("Showing results for",
                        color: AppColors.lightBlack,
                        fontFamily: Assets.poppinsMedium),
                    SizedBox(height: getHeight() * 0.02),
                    CommonWidgets.getCategoryWithText(
                        image: Assets.foodIcon,
                        title: widget.businessType
                    ),
                    SizedBox(height: getHeight() * 0.04),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return BusinessNearBy(
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
