import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/text_views.dart';

import '../../../res/colors.dart';
import '../../../res/res.dart';


class Businesses extends StatefulWidget {
  const Businesses({Key? key}) : super(key: key);

  @override
  _BusinessesState createState() => _BusinessesState();
}

class _BusinessesState extends State<Businesses> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.appBackground,
        body: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: sizes!.height,
            width: sizes!.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: getHeight() * 0.1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientColor1,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes!.width * 0.06),
                  child: Column(
                    children: [
                      TextView.getMediumText15("Salam Buisness", color: AppColors.greenColor),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
