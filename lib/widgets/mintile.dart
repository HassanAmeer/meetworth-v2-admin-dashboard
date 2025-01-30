import 'package:flutter/material.dart';
import '../const/appcolors.dart';

class MiniTileCardWidget extends StatelessWidget {
  final double? widthRatio;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry padding;
  final double borderRradius;

  const MiniTileCardWidget({
    super.key,
    this.widthRatio,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.borderRradius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
          width: widthRatio != null
              ? MediaQuery.of(context).size.width * widthRatio!
              : null,
          decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(borderRradius)),
          child: Padding(
              padding: padding,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.only(right: leading == null ? 0 : 11),
                    child: leading ?? const SizedBox.shrink()),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title ?? const SizedBox.shrink(),
                      subtitle ?? const SizedBox.shrink()
                    ]),
                Padding(
                    padding: EdgeInsets.only(left: trailing == null ? 0 : 11),
                    child: trailing ?? const SizedBox.shrink()),
              ]))),
    );
  }
}
