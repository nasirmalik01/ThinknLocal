import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/screens/bottom_tab/causes/upcoming_causes.dart';
import 'package:thinknlocal_app/screens/causes_detail/causes_detail.dart';

import '../../constants/colors.dart';
import '../../res/res.dart';
import '../../widgets/common_widgets.dart';


class CausesListingScreen extends StatelessWidget {
  final List<dynamic> detailList;
  final String title;
  const CausesListingScreen({Key? key, required this.title, required this.detailList}) : super(key: key);

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
                title: title,
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
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: detailList.length,
                      itemBuilder: (context, index) {
                        dynamic _raisedFormattedAmount = commaFormatter(detailList[index].raised);

                        return GestureDetector(
                          onTap: (){
                            pushNewScreen(
                              context,
                              screen: CausesDetail(
                                  causeId: detailList[index].id,
                                  organizationId: detailList[index].organization!.id
                              ),
                              withNavBar: true,
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: sizes.height*0.001),
                            child: UpcomingCauses(
                                image:  detailList[index].organization!.logo ?? Strings.dummyBgImage,
                                headerText: detailList[index].organization!.name,
                                description:   detailList[index].name!,
                                onViewCourse: (){},
                                totalAmount:  _raisedFormattedAmount,
                                date: detailList[index].start.toString()
                            ),
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
