import 'package:flutter/material.dart';

import '../const/appcolors.dart';

class CardWidget extends StatelessWidget {
  final double? widthRatio;
  final double? heightRatio;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final double borderRradius;

  const CardWidget({
    super.key,
    this.widthRatio,
    this.heightRatio,
    this.child,
    this.borderRradius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          width: widthRatio != null
              ? MediaQuery.of(context).size.width * widthRatio!
              : null,
          height: heightRatio != null
              ? MediaQuery.of(context).size.width * heightRatio!
              : null,
          decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(borderRradius)),
          child: Padding(padding: padding, child: child)),
    );
  }
}
