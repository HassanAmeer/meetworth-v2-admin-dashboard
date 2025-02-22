import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../const/appColors.dart';
import '../const/appImages.dart';

imagePreview(context, {required String imageUrl}) {
  return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Opacity(
                    opacity: 0.5,
                    child: Image.asset(AppImages.profiledarkgold),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
}
