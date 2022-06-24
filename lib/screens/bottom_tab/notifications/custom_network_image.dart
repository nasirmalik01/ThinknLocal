import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thinknlocal_app/constants/assets.dart';
import 'package:thinknlocal_app/constants/colors.dart';
import 'package:thinknlocal_app/res/res.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final Color backgroundColor;
  final double clipRadius;
  final String? placeholderUrl;
  const CustomNetworkImage(
      {Key? key,
        required this.imageUrl,
        this.fit = BoxFit.cover,
        this.backgroundColor = AppColors.pureWhiteColor,
        this.clipRadius = 0,
        this.placeholderUrl,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(clipRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => Image.asset(
          placeholderUrl ?? Assets.loading,
          height: getHeight()*0.15,
          width: getHeight()*0.15,
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeholderUrl ?? Assets.errorImage,
          height: getHeight()*0.1,
          width: getHeight()*0.1,
        ),
      )
    );
  }
}