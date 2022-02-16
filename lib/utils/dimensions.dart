import 'package:multiscreen/multiscreen.dart';

const guideSize = 375.0;

extension MultiScreenResize on num{
  ///Calculate screen size base on iPhone X size
  double get sz => resize(toDouble(),guideSize: guideSize);
}

class AppDimen{
  static double defaultMargin = 16.sz;
  static double defaultBorderRadius = 20.sz;
}