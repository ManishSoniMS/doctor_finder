import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).width;
  }

  static double _getProportionateScreenWidth(double inputWidth) {
    // 360 is the layout width that designer use
    return (inputWidth / 360.0) * screenWidth;
  }

  static double _getProportionateScreenHeight(double inputHeight) {
    // 640 is the layout height that designer use
    return (inputHeight / 640.0) * screenHeight;
  }
}

extension OnNum on num {
  double get rsW => SizeConfig._getProportionateScreenWidth(toDouble());
  double get rsH => SizeConfig._getProportionateScreenHeight(toDouble());
}
