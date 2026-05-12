import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shimmers/image_shimmer.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({
    super.key,
    required this.imageURL,
    required this.width,
    required this.height,
    this.radius,
  });
  final String imageURL;
  final double width;
  final double height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: imagePlaceHolderColor,
        borderRadius: BorderRadius.circular(radius ?? SizeConfig.radius * 1.8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(
          radius ?? SizeConfig.radius * 1.8,
        ),
        child: CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          placeholder: (context, url) => ImageShimmer(radius: radius),
          errorWidget: (context, url, error) =>
              Icon(Icons.network_check_rounded, color: elegantYellow),
        ),
      ),
    );
  }
}
