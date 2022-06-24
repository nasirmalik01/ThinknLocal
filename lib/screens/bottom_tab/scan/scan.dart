import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/widgets/text_views.dart';

import '../../../constants/colors.dart';
import '../../../res/res.dart';


class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
          },
          child: Container(
            height: sizes.height,
            width: sizes.width,
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
                        AppColors.lightGreenColor,
                        AppColors.pureWhiteColor,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.06),
                  child: Column(
                    children: [
                      TextView.titleWithDecoration(Strings.helloScan, color: AppColors.greenColor),
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