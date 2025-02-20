import 'package:flutter/material.dart';

class S {
  static SizedBox h(double height) {
    return SizedBox(height: height);
  }

  static SizedBox shrink(){
    return const SizedBox.shrink();
  }

  static bool isMobile(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var smallestDimension = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not. The
    // number 600 here is a common breakpoint for a typical
    // 7-inch tablet.
    return smallestDimension < 600;
  }

  static SizedBox rbh(BuildContext context, double percent) {
    return SizedBox(height: rH(context, percent));
  }

  static SizedBox rbw(BuildContext context, double percent) {
    return SizedBox(width: rW(context, percent));
  }

  static double rH(BuildContext context, double h) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return MediaQuery.of(context).size.height * h;
    } else {
      return MediaQuery.of(context).size.width * h;
    }
  }

  static double rW(BuildContext context, double w) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return MediaQuery.of(context).size.width * w;
    } else {
      return MediaQuery.of(context).size.height * w;
    }
  }

  static SizedBox w(double width, [BuildContext? context]) {
    return SizedBox(width: width);
  }
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
