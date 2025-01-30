import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class CategoryModel {
  String name = "";
  double count = 0.0;
  Color? color;
  CategoryModel(String n, double c) {
    name = n;
    count = c;
    color = _randomColor.randomColor(colorBrightness: ColorBrightness.light);
  }
}
