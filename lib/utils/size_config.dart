import 'package:flutter/cupertino.dart';

double _baseWidth = 393.0; // Base width used by designers;
double _baseHeight = 852.0; // Base hight used by designers;

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).width;
  }

  // Base height used by designers;

  static double _getProportionateScreenWidth(double inputWidth) {
    // 360 is the layout width that designer use
    return (inputWidth / _baseWidth) * screenWidth;
  }

  static double _getProportionateScreenHeight(double inputHeight) {
    // 640 is the layout height that designer use
    return (inputHeight / 852.0) * screenHeight;
  }

  static double _getProportionateScreenFontSize(double inputFontSize) {
    final baseRation = _baseHeight * _baseWidth;
    final actualRatio = screenHeight * screenWidth;
    return (inputFontSize / baseRation) * actualRatio;
  }
}

extension OnNum on num {
  double get rsW => SizeConfig._getProportionateScreenWidth(toDouble());
  double get rsH => SizeConfig._getProportionateScreenHeight(toDouble());
  double get rsF => SizeConfig._getProportionateScreenFontSize(toDouble());
}
