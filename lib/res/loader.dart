import 'package:flutter/material.dart';
import 'package:flutter_app/res/res.dart';
import 'package:lottie/lottie.dart';

import 'assets.dart';

class Loader {
    showLoader({
    BuildContext ? context,
  }) {
    showDialog(
      context: context!,
      builder: (_) {
        return Material(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: SizedBox(
                width: getWidth() * 0.45,
                height: getHeight() * 0.45,
                child: Lottie.asset(
                  Assets.apiLoading,
                ),
            ),
          ),
        );
      },
    );
  }

  hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }

  getLoader(){
      return Center(
        child: Container(
          height: getHeight()*0.1,
          child: Lottie.asset(Assets.apiLoading, fit: BoxFit.cover),
        ),
      );
  }

    static double getHeight() => sizes?.height ?? 2560;
    static double getWidth() => sizes?.width ?? 1440;

}
