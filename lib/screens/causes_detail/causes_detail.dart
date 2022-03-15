import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/causes_detail/causes_detail_components.dart';
import 'package:flutter_app/widgets/common_widgets.dart';
import 'package:flutter_app/widgets/text_views.dart';
import 'package:flutter_app/screens/bottom_tab/causes/causes_components.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../../res/res.dart';


class CausesDetail extends StatefulWidget {
  const CausesDetail({Key? key}) : super(key: key);

  @override
  _CausesDetailState createState() => _CausesDetailState();
}

class _CausesDetailState extends State<CausesDetail> with SingleTickerProviderStateMixin {
  final CauseDetailComponents _causeDetailComponents = CauseDetailComponents();
  TabController? _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: sizes!.height * 0.32,
                child: _causeDetailComponents.getCausesFundsContainer(
                  name: "Chino Hills High School Girls Softall Fundraiser",
                  fullBoxImage: Assets.schoolDummy1,
                  logoImage: Assets.huskiesLogo,
                  completePercentage: 0.7,
                  collectedAmount: "342.5",
                  totalAmount: "450",
                  endDate: "Feb 4 - Feb 21",
                  isFavorite: false,
                  onClickBox: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CausesDetail()));
                  },
                  onPressBackArrow: () {
                    Navigator.pop(context);
                  }
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth() * 0.05,
                    vertical: getHeight() * 0.01),
                decoration: const BoxDecoration(
                  color: AppColors.pureWhiteColor,
                ),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    print("Tab: $index");
                  },
                  indicator: BoxDecoration(

                    borderRadius: BorderRadius.circular(getHeight() * 0.01),
                    color: AppColors.lightBlue,
                  ),
                  //indicatorColor: AppColors.pureWhiteColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding:
                  EdgeInsets.symmetric(vertical: sizes!.heightRatio * 5),
                  labelColor: AppColors.pureWhiteColor,
                  labelStyle: TextStyle(
                      fontSize: sizes!.fontRatio * 12,
                      fontFamily: Assets.poppinsMedium,
                      fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: AppColors.darkGrey,
                  unselectedLabelStyle: TextStyle(
                      fontSize: sizes!.fontRatio * 12,
                      fontFamily: Assets.poppinsRegular,
                      fontWeight: FontWeight.w400
                  ),
                  //labelPadding: EdgeInsets.all(sizes!.smallPadding),
                  tabs: const [
                    Tab(
                      text: 'Overview',

                    ),
                    Tab(
                      text: 'Update',
                    ),
                    Tab(
                      text: 'Stats',
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizes!.height * 0.01),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding),
                      child: Column(
                        children: [
                          TextView.bold22Text("", color: AppColors.greenColor),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding),
                      child: Column(
                        children: [
                          TextView.bold22Text("", color: AppColors.greenColor),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes!.pagePadding),
                      child: TextView.bold22Text("", color: AppColors.greenColor)
                    ),
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
